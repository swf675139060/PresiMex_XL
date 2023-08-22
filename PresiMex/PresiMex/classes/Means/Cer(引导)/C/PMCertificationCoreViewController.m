//
//  PMCertificationCoreViewController.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/6/4.
//

#import "PMCertificationCoreViewController.h"
#import "PMCerViewCell.h"
#import "PMCerModel.h"

#import "PMQuestionnaireViewController.h"
#import "PMIDAuthViewController.h"
#import "PMBasicViewController.h"
#import "PMEmergencyContactViewController.h"
#import "PMAddBankViewController.h"


@interface PMCertificationCoreViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;


// 用户当前状态 10:注册完成, 20:问卷调查完成 30:kyc完成, 40:基本信息完成, 50:联系人完成,60:账户完成, 70:授信中, 71:授信通过, 72:授信拒绝 80:交易验证, 81:交易验证部分通过, 82:交易验证拒绝 83:交易验证通过, 84:放款失败需要处理'
@property (nonatomic, assign) NSInteger currentState;

@end

@implementation PMCertificationCoreViewController
-(void)leftItemAction{
    [self shoWYouHuiAlert:@[]];
}

//arr:优惠卷数组
-(void)shoWYouHuiAlert:(NSArray *)arr{
    
    
    CGFloat biLi = WF_ScreenWidth/360;
    
    YouHuiAlert * alert = [[YouHuiAlert alloc] initWithFrame:CGRectMake(0, 0, biLi * 320, biLi * 400) withArr:arr] ;
 
    WFCustomAlertView *  AlertView = [[WFCustomAlertView alloc] initWithContentView:alert];
    
    [AlertView show];
    WF_WEAKSELF(weakself);
    [alert setClickBtnBlock:^(NSInteger indx) {
        [AlertView dismiss];
        if (indx == 0) {
            [weakself.navigationController popViewControllerAnimated:YES];
        } else {
            [weakself clickSubmitBtn];
        }
    }];
    
    
    PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_exit_retention content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
      [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitleLabel.text=@"Autenticación";
    [self addRightBarButtonWithImag:@"bai_kefu"];
    [self modelWithData];
    
    //信息认证主页
    PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_info_auth content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
     [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
    
    
    [[AppsFlyerLib shared]  logEvent: @"af_action_01" withValues:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestUserState];
}
- (void)modelWithData{
    
    _dataArray=[NSMutableArray new];
    PMCerModel *model1 = [[PMCerModel alloc] init];
    model1.title     = @"Autenticación";
    model1.iconName=@"cer_icon_1";
    [self.dataArray addObject:model1];
    
    PMCerModel *model2 = [[PMCerModel alloc] init];
    model2.title     = @"Cuestionario";
    model2.iconName=@"cer_icon_2";
    [self.dataArray addObject:model2];
    
    PMCerModel *model3 = [PMCerModel new];
    model3.title     = @"Contactos de emergencia";
    model3.iconName=@"cer_icon_3";
    [self.dataArray addObject:model3];
    
    PMCerModel *model4 = [[PMCerModel alloc] init];
    model4.title     =@"Cuenta bancaria";
    model4.iconName=@"cer_icon_4";
    [self.dataArray addObject:model4];
 
    [self.tableView reloadData];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, WF_ScreenWidth,WF_ScreenHeight-WF_StatusBarHeight-WF_NavigationHeight-WF_BottomSafeAreaHeight)];
        [self.tempView addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.tableHeaderView=[UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 15.0, *)) {
            self.tableView.sectionHeaderTopPadding = 0;
        }
        [self setupFootView];
        [self setupHeadView];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PMCerModel *model=self.dataArray[indexPath.row];
    PMCerViewCell *cell=[PMCerViewCell cellWithTableView:tableView];
    if (self.currentState == 30 && indexPath.row == 0) {
        [cell setCellWithModel:model isSelect:YES];
    } else  if (self.currentState == 40 && indexPath.row == 1) {
        [cell setCellWithModel:model isSelect:YES];
    }else  if (self.currentState == 50 && indexPath.row == 2) {
        [cell setCellWithModel:model isSelect:YES];
    }else  if (self.currentState == 60 && indexPath.row == 3) {
        [cell setCellWithModel:model isSelect:YES];
    }else{
        [cell setCellWithModel:model isSelect:NO];
    }
    
    if (self.currentState == 30) {
        if (indexPath.row == 0) {
            [cell setCellWithModel:model isSelect:YES];
        }else{
            [cell setCellWithModel:model isSelect:NO];
        }
    } else  if (self.currentState == 40) {
        if (indexPath.row == 0) {
            [cell setCellWithModel:model isSelect:YES];
        }else if (indexPath.row == 1) {
            [cell setCellWithModel:model isSelect:YES];
        }else {
            [cell setCellWithModel:model isSelect:NO];
        }
    }else  if (self.currentState == 50) {
        if (indexPath.row == 0) {
            [cell setCellWithModel:model isSelect:YES];
        }else if (indexPath.row == 1) {
            [cell setCellWithModel:model isSelect:YES];
        }else if (indexPath.row == 2) {
            [cell setCellWithModel:model isSelect:YES];
        }else {
            [cell setCellWithModel:model isSelect:NO];
        }
    }else  if (self.currentState == 60) {
        if (indexPath.row == 0) {
            [cell setCellWithModel:model isSelect:YES];
        }else if (indexPath.row == 1) {
            [cell setCellWithModel:model isSelect:YES];
        }else if (indexPath.row == 2) {
            [cell setCellWithModel:model isSelect:YES];
        }else if (indexPath.row == 3) {
            [cell setCellWithModel:model isSelect:YES];
        }else {
            [cell setCellWithModel:model isSelect:NO];
        }
    }else{
        [cell setCellWithModel:model isSelect:NO];
    }
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

-(void)setupHeadView{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, 50)];
    headerView.backgroundColor=[UIColor whiteColor];
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.frame = CGRectMake(15,10,WF_ScreenWidth,30);
    tipLabel.numberOfLines = 0;
    tipLabel.text=@"Información";
    [headerView addSubview:tipLabel];
    tipLabel.textColor=BColor_Hex(@"#1B1200", 1);
    tipLabel.textAlignment = NSTextAlignmentLeft;
    tipLabel.font=B_FONT_BOLD(20);
    self.tableView.tableHeaderView=headerView;
    
}
-(void)setupFootView{
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, 180)];
    footer.backgroundColor=[UIColor whiteColor];
    
    UIButton* submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.tag=1;
    submitBtn.frame = CGRectMake(15,25,WF_ScreenWidth-30,50);
    [submitBtn setTitle:@"Comenzar la autenticación" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(clickSubmitBtn) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.layer.cornerRadius=13;
    submitBtn.layer.masksToBounds=YES;
    [footer addSubview:submitBtn];
    [submitBtn addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth - 30, 50) withColors:@[(id)[UIColor jk_colorWithHexString:@"#FFB602"].CGColor,(id)[UIColor jk_colorWithHexString:@"#FC7500"].CGColor] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:13];
    
    UIView *tipBg = [[UIView alloc] initWithFrame:CGRectMake(15,submitBtn.swf_bottom+20, WF_ScreenWidth-30, 70)];
    tipBg.layer.cornerRadius=10;
    tipBg.backgroundColor=BColor_Hex(@"#FFB602", 0.06);
    [footer addSubview:tipBg];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.numberOfLines = 0;
    tipLabel.text=@"La exactitud de la información que proporciona tiene un impacto directo en su línea de crédito, asegúrese de que sea precisa.";
    [tipBg addSubview:tipLabel];
    tipLabel.textColor=BColor_Hex(@"#FFB602", 1);
    tipLabel.textAlignment = NSTextAlignmentLeft;
    tipLabel.font=B_FONT_REGULAR(11);
    CGSize size=[UILabel sizeWithText:tipLabel.text fontSize:11 andMaxsize:WF_ScreenWidth-60];
    tipLabel.frame = CGRectMake(15,(70-size.height)/2,WF_ScreenWidth-60,size.height);
    
    
    self.tableView.tableFooterView=footer;
}

-(void)clickSubmitBtn{
   
    
    // 用户当前状态 10:注册完成, 20:问卷调查完成 30:kyc完成, 40:基本信息完成, 50:联系人完成,60:账户完成, 70:授信中, 71:授信通过, 72:授信拒绝 80:交易验证, 81:交易验证部分通过, 82:交易验证拒绝 83:交易验证通过, 84:放款失败需要处理'
    if (self.currentState <= 10 ) {
        PMQuestionnaireViewController * VC =[[PMQuestionnaireViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if(self.currentState == 20) {
        
        PMQuestionnaireViewController * VC1 =[[PMQuestionnaireViewController alloc] init];
        PMIDAuthViewController*VC2=[PMIDAuthViewController new];
        NSMutableArray *  viewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        [viewControllers addObjectsFromArray:@[VC1, VC2]];
        [self.navigationController setViewControllers:viewControllers animated:YES];
//        [self.navigationController pushViewController:Vc animated:YES];

    }else if(self.currentState == 30) {

        PMQuestionnaireViewController * VC1 =[[PMQuestionnaireViewController alloc] init];
        PMIDAuthViewController*VC2=[PMIDAuthViewController new];
        
        PMBasicViewController*VC3=[PMBasicViewController new];
        
        NSMutableArray *  viewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        [viewControllers addObjectsFromArray:@[VC1, VC2,VC3]];
        [self.navigationController setViewControllers:viewControllers animated:YES];
    }else if(self.currentState == 40) {
        
        PMQuestionnaireViewController * VC1 =[[PMQuestionnaireViewController alloc] init];
        PMIDAuthViewController*VC2=[PMIDAuthViewController new];
        
        PMBasicViewController*VC3=[PMBasicViewController new];
        PMEmergencyContactViewController*VC4=[PMEmergencyContactViewController new];
        
        NSMutableArray *  viewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        [viewControllers addObjectsFromArray:@[VC1, VC2,VC3,VC4]];
        [self.navigationController setViewControllers:viewControllers animated:YES];
     
    }else if(self.currentState == 50) {
        PMQuestionnaireViewController * VC1 =[[PMQuestionnaireViewController alloc] init];
        PMIDAuthViewController*VC2=[PMIDAuthViewController new];
        
        PMBasicViewController*VC3=[PMBasicViewController new];
        PMEmergencyContactViewController*VC4=[PMEmergencyContactViewController new];
        
        PMAddBankViewController*VC5=[PMAddBankViewController new];
        
        NSMutableArray *  viewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        [viewControllers addObjectsFromArray:@[VC1, VC2,VC3,VC4,VC5]];
        [self.navigationController setViewControllers:viewControllers animated:YES];
    }else if(self.currentState == 60 ) {
        PMQuestionnaireViewController * VC1 =[[PMQuestionnaireViewController alloc] init];
        PMIDAuthViewController*VC2=[PMIDAuthViewController new];
        
        PMBasicViewController*VC3=[PMBasicViewController new];
        PMEmergencyContactViewController*VC4=[PMEmergencyContactViewController new];
        
        PMAddBankViewController*VC5=[PMAddBankViewController new];
        
        NSMutableArray *  viewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        [viewControllers addObjectsFromArray:@[VC1, VC2,VC3,VC4,VC5]];
//        NSArray *viewControllers = @[self, VC1, VC2,VC3,VC4,VC5];
        [self.navigationController setViewControllers:viewControllers animated:YES];
    }else{
    }
    
  
    
}




//获取用户当前状态
-(void)requestUserState{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];

    [self show];
    WF_WEAKSELF(weakself);
    [PMBaseHttp get:Get_User_Status parameters:pars success:^(id  _Nonnull responseObject) {
        [weakself dismiss];
        if ([responseObject[@"retail"] intValue]==200) {
            NSInteger fare = [responseObject[@"shame"][@"fare"] integerValue];
            weakself.currentState = fare;
            [weakself.tableView reloadData];
        }

//        用户当前状态 10:注册完成, 20:问卷调查完成 30:kyc完成, 40:基本信息完成, 50:联系人完成,60:账户完成, 70:授信中, 71:授信通过, 72:授信拒绝 80:交易验证, 81:交易验证部分通过, 82:交易验证拒绝 83:交易验证通过, 84:放款失败需要处理'
        else{
            [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
    } failure:^(NSError * _Nonnull error) {
        [weakself dismiss];
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        
    }];
}
@end
