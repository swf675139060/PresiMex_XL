//
//  PMAddBankViewController.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/6/3.
//

#import "PMAddBankViewController.h"

#import "PMIDAuthHeaderView.h"
#import "PMBasicViewCell.h"
#import "PMBankVerCodeCell.h"
#import "PMQuestionModel.h"
#import "PMBankSelectViewCell.h"

#import "bankcardModel.h"
#import "AuthWaitingAlert.h"
#import "AuthWaitingStoreAlert.h"
#import "AuthSuccessfuiAlert.h"
#import "BankConfrimAlert.h"
#import "OrderVC.h"
#import "YouHuiAlert.h"
#import "PMCertificationCoreViewController.h"


@interface PMAddBankViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) bankcardModel  *oldBankModel;//设置的银行信息

@property (nonatomic, strong) bankcardModel  *bankModel;//设置的银行信息

@property (nonatomic, strong) NSArray<bankcardModel *> *bankList;//银行信息列表

@property (nonatomic, strong) WFCustomAlertView *  AlertView;//base
@property (nonatomic, strong) AuthWaitingAlert * waitingAlert;
@property (nonatomic, strong) AuthWaitingStoreAlert * waitingStoreAlert;


@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger count;


@property (nonatomic, copy) NSString * codeNumber;//输入的验证码
@property (nonatomic, assign) NSInteger CodeCount;//验证码倒计时

@property (nonatomic, assign) BOOL isSendCode;//是否发送验证码

//@property (nonatomic, strong)dataArr


@end

@implementation PMAddBankViewController

//-(void)leftItemAction{
////    [self GETCouponUrl];
//    if (self.VCType == 0) {
//        [self shoWYouHuiAlert:@[]];
//    } else {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitleLabel.text=@"Cuenta bancaria";
    [self addRightBarButtonWithImag:@"bai_kefu"];
    [self modelWithData];
    [self GETBindUserAccount];
//    [self showAuthWaiting];
//    [self startTimer];
    
    PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_bank content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
    [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
    
}
- (void)modelWithData{
    self.bankModel.diameter = @"1";
    _dataArray = [NSMutableArray array];
    PMQuestionModel *model1 = [[PMQuestionModel alloc] init];
    [self.dataArray addObject:model1];
    
    PMQuestionModel *model2 = [[PMQuestionModel alloc] init];
    model2.title     = @"Banco";
    model2.type=1;
    model2.isHave=YES;
    model2.isColor=NO;
    [self.dataArray addObject:model2];
    
    PMQuestionModel *model3 = [[PMQuestionModel alloc] init];
    model3.title     = @"Cuenta (Tarjeta de débito de 16 dígitos)";
    model3.type=2;
    model3.isHave=NO;
    model3.isColor=NO;
    [self.dataArray addObject:model3];
    if(_VCType == 1){
        PMQuestionModel *model4 = [[PMQuestionModel alloc] init];
        model4.title     = @"Verificación (de 4 dígitos)";
        model4.type=3;
        model4.isHave=NO;
        model4.isColor=NO;
        [self.dataArray addObject:model4];
    }
    
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
    if (self.VCType == 1) {
        return 4;
    } else {
        return 3;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        PMBankSelectViewCell*cell=[PMBankSelectViewCell cellWithTableView:tableView];
        
        [cell setCellWithModel:self.bankModel];
        WF_WEAKSELF(weakself);
        cell.click = ^(NSInteger tag) {
            if (tag == 100) {
                
                PMQuestionModel *model3 = weakself.dataArray[2];
                model3.title     = @"Cuenta (Tarjeta de débito de 16 dígitos)";
                
                weakself.bankModel.diameter = @"1";
                PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq03_bank_bank_account content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
                    [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
            } else {
                PMQuestionModel *model3 = weakself.dataArray[2];
                model3.title     = @"Cuenta (CLABE de 18 dígitos)";
                weakself.bankModel.diameter = @"2";
                
                PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq03_bank_clabe content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
                    [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
                
            }
            [weakself.tableView reloadData];
        };
        return cell;
    } else if (indexPath.row==1) {
        PMQuestionModel *model=self.dataArray[indexPath.row];
        PMBasicViewCell *cell=[PMBasicViewCell cellWithTableView:tableView];
        [cell setCellWithModel:model maxCount:18];
        WF_WEAKSELF(weakself);
        [cell setEndInputBlock:^(NSString * _Nonnull title, NSString * _Nonnull text,BOOL end) {
            
            weakself.bankModel.diploma = text;
            model.content = text;
            
           
        }];
        
        return cell;
    } else if (indexPath.row==2) {
        PMQuestionModel *model=self.dataArray[indexPath.row];
        PMBasicViewCell *cell=[PMBasicViewCell cellWithTableView:tableView];
       
        WF_WEAKSELF(weakself);
        
        weakify(cell);
        [cell setEndInputBlock:^(NSString * _Nonnull title, NSString * _Nonnull text,BOOL end) {
            strongify(cell);
            weakself.bankModel.diploma = text;
            model.content = text;
            
            if (end) {
                PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_bank_account content:text beginTime:cell.contentTF.beginTime Duration:cell.contentTF.duration];
                [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
            }
           
        }];
        
        if ([weakself.bankModel.diameter integerValue] == 1) {
            [cell setCellWithModel:model maxCount:16];
        } else {
            [cell setCellWithModel:model maxCount:18];
        }
        
        
        return cell;
    }else{
        PMBankVerCodeCell * cell = [PMBankVerCodeCell cellWithTableView:tableView];
        PMQuestionModel *model=self.dataArray[indexPath.row];
        if (self.CodeCount > 0) {
            [cell setCellWithModel:model btnTitle:[NSString stringWithFormat:@"%ld",self.CodeCount]];
            
            [cell setBtnBGType:YES];
        } else {
            if (self.isSendCode) {
                [cell setCellWithModel:model btnTitle:@"Resend"];
            } else {
                [cell setCellWithModel:model btnTitle:@"OTP"];
            }
            
            [cell setBtnBGType:NO];
        }
        WF_WEAKSELF(weakself);
        [cell setEndInputBlock:^(NSString * _Nonnull title, NSString * _Nonnull text) {
            weakself.codeNumber = text;
            model.content = text;
        }];
        [cell setClickSendBlock:^{
            [weakself POSTBankResetCode];
        }];
        return cell;
    }

    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        return 60;
    } else {
        return 90;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        [self sutupAlertViewWithIndx:1];
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}
-(void)setupHeadView{
    
    
    if(self.VCType == 0){
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, 165)];
        headerView.backgroundColor=[UIColor whiteColor];
        PMIDAuthHeaderView *header = [[PMIDAuthHeaderView alloc] initViewWithType:4];
        WF_WEAKSELF(weakself);
        header.btnEventBlcok = ^{
            [weakself POSTCouponGetUrl];
        };
        [headerView addSubview:header];
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.frame = CGRectMake(15,12,WF_ScreenWidth,36);
        tipLabel.numberOfLines = 0;
        tipLabel.text=@"Verifique la precisión de la información bancaria y confirme que la cuenta es de su propiedad. Si la solicitud falla o el préstamo se ingresa en una cuenta diferente, el usuario asumirá las consecuencias correspondientes.";
        [headerView addSubview:tipLabel];
        tipLabel.textColor=BColor_Hex(@"#FFB602", 1);
        tipLabel.textAlignment = NSTextAlignmentLeft;
        tipLabel.font=B_FONT_REGULAR(11);
        CGSize size=[UILabel sizeWithText:tipLabel.text fontSize:11 andMaxsize:WF_ScreenWidth-30];
        
        tipLabel.frame = CGRectMake(15,header.swf_bottom+12,WF_ScreenWidth-30,size.height);
        self.tableView.tableHeaderView=headerView;
    }else{
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, 100)];
        headerView.backgroundColor=[UIColor whiteColor];
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.frame = CGRectMake(15,12,WF_ScreenWidth,36);
        tipLabel.numberOfLines = 0;
        tipLabel.text=@"Verifique la precisión de la información bancaria y confirme que la cuenta es de su propiedad. Si la solicitud falla o el préstamo se ingresa en una cuenta diferente, el usuario asumirá las consecuencias correspondientes.";
        [headerView addSubview:tipLabel];
        tipLabel.textColor=BColor_Hex(@"#FFB602", 1);
        tipLabel.textAlignment = NSTextAlignmentLeft;
        tipLabel.font=B_FONT_REGULAR(11);
        CGSize size=[UILabel sizeWithText:tipLabel.text fontSize:11 andMaxsize:WF_ScreenWidth-30];
        
        tipLabel.frame = CGRectMake(15,20,WF_ScreenWidth-30,size.height);
        self.tableView.tableHeaderView=headerView;
    }
    
   
    
}
-(void)setupFootView{
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, 110)];
    footer.backgroundColor=[UIColor whiteColor];
    
    UIButton* submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.tag=1;
    submitBtn.frame = CGRectMake(15,40,WF_ScreenWidth-30,50);
    [submitBtn setTitle:@"Próximo paso" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(clickSubmitBtn) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.layer.cornerRadius=13;
    submitBtn.layer.masksToBounds=YES;
    [footer addSubview:submitBtn];
    [submitBtn addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth - 30, 50) withColors:@[(id)[UIColor jk_colorWithHexString:@"#FFB602"].CGColor,(id)[UIColor jk_colorWithHexString:@"#FC7500"].CGColor] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:13];
    self.tableView.tableFooterView=footer;
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
            
        }
    }];
    PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_exit_retention content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
      [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];

}

//添加银行卡成功倒计时
-(void)startTimer{
    // 在需要开启定时器的方法中调用下面的代码
    self.count = 10;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
}
// 添加银行卡成功倒计时调用的方法
- (void)timerFired:(NSTimer *)timer {
    self.count--;
    
    [self.waitingAlert uptime:self.count];
    [self.waitingStoreAlert uptime:self.count];
    NSLog(@"定时器触发，当前执行次数：%ld", self.count);
    if (self.count <= 0) {
        [self.timer invalidate];
        self.timer = nil;
        NSLog(@"定时器已停止。");
        [self.AlertView dismiss];
        [self showAuthSuccessful];
    }
}


//发送验证码
-(void)sendCodeTimer{
    
    self.isSendCode = YES;
    // 在需要开启定时器的方法中调用下面的代码
    self.CodeCount = 60;
    
    PMBankVerCodeCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    [cell setBtnBGType:YES];
    cell.btn.userInteractionEnabled = NO;
    [cell.btn setTitle:[NSString stringWithFormat:@"%ld",self.CodeCount] forState:UIControlStateNormal];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sendCodeTimerFired:) userInfo:nil repeats:YES];
}
// 发送验证码倒计时调用的方法
- (void)sendCodeTimerFired:(NSTimer *)timer {
    self.CodeCount--;
    PMBankVerCodeCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];

    NSLog(@"定时器触发，当前执行次数：%ld", self.CodeCount);
    if (self.CodeCount <= 0) {
        cell.btn.userInteractionEnabled = YES;
        [self.timer invalidate];
        self.timer = nil;
        NSLog(@"定时器已停止。");
        [cell setBtnBGType:NO];
        [cell.btn setTitle:@"Resend" forState:UIControlStateNormal];
    }else{
        
        [cell setBtnBGType:YES];
        cell.btn.userInteractionEnabled = NO;
        [cell.btn setTitle:[NSString stringWithFormat:@"%ld",self.CodeCount] forState:UIControlStateNormal];
    }
}

-(void)showAuthWaiting{
    WF_WEAKSELF(weakself);
    [[PMConfigManager sharedInstance] getConfigModelBlock:^(PMConfigModel * _Nonnull model) {
        if ([model.medline integerValue] == 1) {
            
            weakself.waitingStoreAlert = [[AuthWaitingStoreAlert alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth - 60, 324 )];
            
            weakself.AlertView = [[WFCustomAlertView alloc] initWithContentView:weakself.waitingStoreAlert];
            [weakself.waitingStoreAlert setClickBtnBlock:^{
                if (weakself.waitingStoreAlert.storeCount == 5) {
                    
                    [[PMConfigManager sharedInstance] gotoStore];
                    weakself.CodeCount = 0;
                    
                    [weakself.timer invalidate];
                    weakself.timer = nil;
                    NSLog(@"定时器已停止。");
                    [weakself.AlertView dismiss];
                    [weakself showAuthSuccessful];
//                    [weakself POSTCouponGetUrl];
                }else{
                    [weakself.waitingStoreAlert hiddenStore];
                }
            }];
            
            [weakself.AlertView show];
        } else {
            
            weakself.waitingAlert = [[AuthWaitingAlert alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth - 60, 180 + 45 ) withConttent:@"10"];
            
            weakself.AlertView = [[WFCustomAlertView alloc] initWithContentView:weakself.waitingAlert];
            [weakself.AlertView show];
        }
    }];
    
    
    [[AppsFlyerLib shared]  logEvent: @"af_action_06" withValues:nil];
    
    PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_auth_wait content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
    [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
    
    
}
-(void)showAuthSuccessful{
    AuthSuccessfuiAlert * alert = [[AuthSuccessfuiAlert alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth - 60, 147 + 20 + 190) withConttent:@"" btnTitel:@""];
    
    WFCustomAlertView *  AlertView = [[WFCustomAlertView alloc] initWithContentView:alert];
    [AlertView show];
    WF_WEAKSELF(weakself);
    [alert setClickBtnBlock:^{
        [AlertView dismiss];
        [weakself.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    
    
    [[AppsFlyerLib shared]  logEvent: @"af_action_07" withValues:nil];
    PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_auth_pass content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
    [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
}

-(void)sutupAlertViewWithIndx:(NSInteger)indxP{
    [self.view endEditing:YES];
    
    
    NSMutableArray * arr = [NSMutableArray array];
    
    for (bankcardModel * dataModel in self.bankList) {
        [arr addObject:dataModel.marshall];
    }
    
//    weakify(self);
//    JKPickerViewAppearance *alert=[[JKPickerViewAppearance alloc] initWithPickerViewTilte:@"Banco" withData:arr pickerCompleteBlock:^(id  _Nonnull responseObjct,NSInteger indx) {
//        strongify(self);
//
//        bankcardModel * banckModel  = self.bankList[indx];
//
//        PMQuestionModel * model = self.dataArray[1];
//        model.content = banckModel.marshall;
//        model.ID = banckModel.framework;
//
//
//        self.bankModel.marshall = banckModel.marshall;
//        self.bankModel.framework = banckModel.framework;
//        [self.tableView reloadData];
//
//    }];
//    [alert show] ;
    
    
    weakify(self);
    PoPBottomView * BottomView = [PoPBottomView new];
    BottomView.titles = arr;
    SLFCommentsPopView * popView = [SLFCommentsPopView commentsPopViewWithFrame:CGRectMake(0, 0, WF_ScreenWidth, WF_ScreenHeight) contentView:BottomView contentViewNeedScroView:NO];
    [popView showWithTitileStr:@""];
    
    BottomView.selectBlock = ^(NSString * _Nonnull responseObjct, NSInteger indx) {
        strongify(self);
        
        bankcardModel * banckModel  = self.bankList[indx];
        
        PMQuestionModel * model = self.dataArray[1];
        model.content = banckModel.marshall;
        model.ID = banckModel.framework;
        
        
        self.bankModel.marshall = banckModel.marshall;
        self.bankModel.framework = banckModel.framework;
        [self.tableView reloadData];
        [popView dismiss];
        
        
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_bank_bank_name content:model.content beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
           [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
    };
}


//确认借款弹出框 type 0:有下面的金钱的cell 1 没有下面金钱cell
-(void)showBankConfrimAlert:(NSInteger)type{
    BankConfrimAlert * alert = [[BankConfrimAlert alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth - 40, 396) withType:type] ;
    alert.bankModel = self.bankModel;
    alert.money = self.orderModel.barbie;
    
    WFCustomAlertView *  AlertView = [[WFCustomAlertView alloc] initWithContentView:alert];
    [AlertView show];
    WF_WEAKSELF(weakself);
    [alert setClickBtnBlock:^(NSInteger indx) {
        
        if (weakself.VCType == 0) {
            //添加银行卡
            [AlertView dismiss];
            //添加银行卡确认弹出
            if (indx == 0) {
                
            } else {
                
                NSMutableDictionary *pars1=[NSMutableDictionary dictionary];
                pars1[@"diameter"] = weakself.bankModel.diameter;
                pars1[@"framework"] = weakself.bankModel.framework;
                pars1[@"occasion"] = weakself.bankModel.diploma;
                [weakself show];
                [PMBaseHttp postJson:POST_Bank_Info_Submmit parameters:pars1 success:^(id  _Nonnull responseObject) {
                    [weakself dismiss];
                    if ([responseObject[@"retail"] intValue]==200) {
                        [weakself showAuthWaiting];
                        [weakself startTimer];
                        
                        
                        
                        
                        
                    }else{
                        [weakself showTip:responseObject[@"entire"]];//（对）
                    }
                    
                } failure:^(NSError * _Nonnull error) {
                    [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
                    [weakself dismiss];
                    
                }];
            }
        } else {
            //1:修改
            if (indx == 0) {
                //返回修改
                [AlertView dismiss];
                
                //修改成功返回
                if(weakself.changeBlock){
                    weakself.changeBlock(weakself.bankModel);
                }
                for (UIViewController *temp in self.navigationController.viewControllers) {
                    
                    if ([temp isKindOfClass:[OrderVC class]]) {
                        
                        [weakself.navigationController popToViewController:temp animated:YES];
                    }
                    
                }
            } else {
                //确认重新提交
                [weakself PostOderFailReset];
                [AlertView dismiss];
                
            }
        }
        
    }];
}
//12003 - 手工发起重新放款操作，后端将失败订单处理为待重新放款状态
-(void)PostOderFailReset{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
    pars[@"products"] = self.orderModel.products;
    WF_WEAKSELF(weakself);
    [self show];
    [PMBaseHttp post:Post_Oder_Fail_Reset parameters:pars success:^(id  _Nonnull responseObject) {
        [weakself dismiss];
        if ([responseObject[@"retail"] intValue]==200) {
            for (UIViewController *temp in self.navigationController.viewControllers) {
                
                if ([temp isKindOfClass:[OrderVC class]]) {
                    
                    [weakself.navigationController popToViewController:temp animated:YES];
                }
                
            }
        }else{
            [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
    } failure:^(NSError * _Nonnull error) {
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        [weakself dismiss];
        
        
    }];
}

//获取用户当前绑定账户信息
-(void)GETBindUserAccount{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];

    WF_WEAKSELF(weakself);
    [self show];
    [PMBaseHttp get:GET_Bind_User_Account parameters:pars success:^(id  _Nonnull responseObject) {

        if ([responseObject[@"retail"] intValue]==200) {
            NSDictionary * shame = responseObject[@"shame"];

            weakself.oldBankModel = [bankcardModel mj_objectWithKeyValues:shame];
            bankcardModel * model = [bankcardModel mj_objectWithKeyValues:shame];
            if(model){
                weakself.bankModel = model;

                PMQuestionModel *model1 = weakself.dataArray[1];
                model1.content = model.marshall;
                
                PMQuestionModel *model2 = weakself.dataArray[2];
                model2.content = model.diploma;

                if ([weakself.bankModel.diameter integerValue] == 1) {

                    PMQuestionModel *model3 = weakself.dataArray[2];
                    model3.title     = @"Cuenta (Tarjeta de débito de 16 dígitos)";
                } else {
                    PMQuestionModel *model3 = weakself.dataArray[2];
                    model3.title     = @"Cuenta (CLABE de 18 dígitos)";
                }

                [weakself.tableView reloadData];
            }

        }else{
            [weakself showTip:responseObject[@"entire"]];//（对）
        }


        [weakself GETBankList];

    } failure:^(NSError * _Nonnull error) {
        
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        [weakself GETBankList];
    }];
    
}



-(void)GETBankList{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];

    WF_WEAKSELF(weakself);
    [PMBaseHttp get:GET_Bank_List parameters:pars success:^(id  _Nonnull responseObject) {
        [weakself dismiss];
        if ([responseObject[@"retail"] intValue]==200) {
            NSDictionary * shame = responseObject[@"shame"];
            weakself.bankList = [bankcardModel mj_objectArrayWithKeyValuesArray:shame[@"pledge"]];
           
            
        }else{
            [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
    } failure:^(NSError * _Nonnull error) {
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        [weakself dismiss];
        
    }];
}
-(void)clickSubmitBtn{
    
    if (!self.bankModel.diameter || self.bankModel.diameter.length == 0) {
        [self showTip:@"Verifique los campos obligatorios."];
        return;
    }else if (!self.bankModel.marshall || self.bankModel.diameter.length == 0){
        [self showTip:@"Verifique los campos obligatorios."];
        return;
    }else if (!self.bankModel.diploma || self.bankModel.diploma.length == 0){
        [self showTip:@"Verifique los campos obligatorios."];
        return;
    }
    
    if([self.oldBankModel.diameter isEqualToString:self.bankModel.diameter] && [self.oldBankModel.framework isEqualToString:self.bankModel.framework] && [self.oldBankModel.diploma isEqualToString:self.bankModel.diploma]){
        [self showTip:@"La información no ha cambiado, modifique la cuenta."];
        return;
    }
    if(self.VCType == 1){
        if(!self.codeNumber || self.codeNumber.length == 0){
            [self showTip:@"Ingrese el código de verificación."];
            return;
        }
    }
    
    
    NSMutableDictionary *pars1=[NSMutableDictionary dictionary];
    pars1[@"diameter"] = self.bankModel.diameter;
    pars1[@"framework"] = self.bankModel.framework;
    pars1[@"occasion"] = self.bankModel.diploma;
    
    if(self.VCType == 1){
        pars1[@"chance"] = self.codeNumber;
    }
    
    WF_WEAKSELF(weakself);
    NSString * url;
    if (self.VCType == 1) {
        
        [self show];
        url = POST_Reset_Bank_Info;
        [PMBaseHttp PUTJson:url parameters:pars1 success:^(id  _Nonnull responseObject) {
            [weakself dismiss];
            if ([responseObject[@"retail"] intValue]==200) {
//                if (weakself.reLoan) {
//                    // 重新借款 弹出窗
//                    [weakself showBankConfrimAlert:0];
//                }else{
                    //修改成功返回
                    if(weakself.changeBlock){
                        weakself.changeBlock(weakself.bankModel);
                    }
                    [weakself.navigationController popViewControllerAnimated:YES];
//                }
                
            }else{
                [weakself showTip:responseObject[@"entire"]];//（对）
            }
            
        } failure:^(NSError * _Nonnull error) {
            [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
            [weakself dismiss];
            
        }];
    } else {
        [self showBankConfrimAlert:1];
    
    }
    
  
    
    
}

// 20002- 用户认证完成领取优惠券
-(void)POSTCouponGetUrl{
    
    NSMutableDictionary *pars1=[NSMutableDictionary dictionary];
    
    [self show];
    WF_WEAKSELF(weakself);
    [PMBaseHttp postJson:POST_Coupon_Get_Url parameters:pars1 success:^(id  _Nonnull responseObject) {
        [weakself dismiss];
        if ([responseObject[@"retail"] intValue]==200) {
            [weakself showTip:@"Cupón recibido con éxito."];
        }else{
            [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
    } failure:^(NSError * _Nonnull error) {
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        [weakself dismiss];
        
    }];
    
    
}


//25004 - 银行卡修改短信发送
-(void)POSTBankResetCode{
    
    NSMutableDictionary *pars1=[NSMutableDictionary dictionary];
    
    [self show];
    WF_WEAKSELF(weakself);
    [PMBaseHttp post:POST_Bank_Reset_Code parameters:pars1 success:^(id  _Nonnull responseObject) {
        [weakself dismiss];
        if ([responseObject[@"retail"] intValue]==200) {
            [weakself showTip:@"El Código de verificación fue enviado con éxito."];
            PMBankVerCodeCell * cell = [weakself.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
            cell.btn.userInteractionEnabled = NO;
            
            [weakself sendCodeTimer];
        }else{
            PMBankVerCodeCell * cell = [weakself.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
            cell.btn.userInteractionEnabled = YES;
            weakself.CodeCount = 0;
            [cell setBtnBGType:NO];
            [weakself.tableView reloadData];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        [weakself dismiss];
        
        PMBankVerCodeCell * cell = [weakself.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        cell.btn.userInteractionEnabled = YES;
        weakself.CodeCount = 0;
        [cell setBtnBGType:NO];
        [weakself.tableView reloadData];
        
    }];
    
    
}



//20001 - 用户获取优惠券
//-(void)GETCouponUrl{
//    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
//    pars[@"eg"] = [NSString stringWithFormat:@"%d",1];
//    pars[@"patricia"] = @"3";
//    WF_WEAKSELF(weakself);
//    [self show];
//    [PMBaseHttp get:GET_Coupon_Url parameters:pars success:^(id  _Nonnull responseObject) {
//        [weakself dismiss];
//        if ([responseObject[@"retail"] intValue]==200) {
//            NSArray * dataList = responseObject[@"shame"][@"approaches"];
//
//            NSArray * cuponModelArr = [CuponModel mj_objectArrayWithKeyValuesArray:dataList];
//            if (cuponModelArr.count) {
//                [weakself shoWYouHuiAlert:cuponModelArr];
//            }else{
//                NSArray *viewControllers = weakself.navigationController.viewControllers;
//                for (UIViewController *viewController in viewControllers) {
//                    if ([viewController isKindOfClass:[PMCertificationCoreViewController class]]) {
//                        [weakself.navigationController popToViewController:viewController animated:YES];
//                        break;
//                    }
//                }
//            }
//        }else{
//
//                [weakself showTip:responseObject[@"entire"]];//（对）
//        }
//
//        [weakself.tableView.mj_footer endRefreshing];
//
//
//    } failure:^(NSError * _Nonnull error) {
//        [weakself dismiss];
//
//        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
//        [weakself.tableView.mj_footer endRefreshing];
//
//    }];
//
//}

//
//-(NSMutableArray *)dataArr{
//    if(_dataArr == nil){
//        _dataArr = [NSMutableArray array];
//    }
//    return _dataArr;
//}
-(bankcardModel *)bankModel{
    if(_bankModel == nil){
        _bankModel = [bankcardModel new];
    }
    return _bankModel;
}
@end
