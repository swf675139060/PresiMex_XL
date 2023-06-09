//
//  PMQuestionnaireViewController.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/30.
//

#import "PMQuestionnaireViewController.h"
#import "PMIDAuthViewController.h"
#import "PMQuestionModel.h"
#import "PMQuestionViewCell.h"
#import "JKPickerViewAppearance.h"
#import "PMQuesModel.h"
@interface PMQuestionnaireViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) PMQuesModel*model;
@property (nonatomic, strong) NSMutableDictionary *parma;
@end

@implementation PMQuestionnaireViewController

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
//            NSArray *viewControllers = weakself.navigationController.viewControllers;
//            for (UIViewController *viewController in viewControllers) {
//                if ([viewController isKindOfClass:[PMCertificationCoreViewController class]]) {
//                    [weakself.navigationController popToViewController:viewController animated:YES];
//                    break;
//                }
//            }
        } else {
            
        }
    }];
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)modelWithData{

    PMQuestionModel *model1 = [[PMQuestionModel alloc] init];
    model1.title     = @"1. ¿Hay algún pago vencido dentro de medio año?";
    model1.type=0;
    [self.dataArray addObject:model1];
    
    PMQuestionModel *model2 = [[PMQuestionModel alloc] init];
    model2.title     = @"2. ¿Cuál es el número máximo de días de mora?";
    model2.type=1;
    [self.dataArray addObject:model2];
    
    PMQuestionModel *model3 = [[PMQuestionModel alloc] init];
    model3.title     = @"3. ¿Cuál es el préstamo total actual de Internet?";
    model3.type=2;
    [self.dataArray addObject:model3];
    
    PMQuestionModel *model4 = [[PMQuestionModel alloc] init];
    model4.title     =@"4. ¿Cuántas veces has pedido prestado en total?";
    model4.type=3;
    [self.dataArray addObject:model4];
    
    PMQuestionModel *model5 = [[PMQuestionModel alloc] init];
    model5.title     =@"5. ¿Cuál es el número de préstamos de Internet actualmente en préstamo?";
    model5.type=4;
    [self.dataArray addObject:model5];
  
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitleLabel.text=@"Cuestionario";
    [self addRightBarButtonWithImag:@"bai_kefu"];
    //[self modelWithData];
    [self requestQuestInfo];
    self.parma=[NSMutableDictionary new];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, WF_ScreenWidth, WF_ScreenHeight-WF_StatusBarHeight-WF_BottomSafeAreaHeight)];
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
    
    PMQuesModel *model=self.dataArray[indexPath.row];
    PMQuestionViewCell *cell=[PMQuestionViewCell cellWithTableView:tableView];
   
    [cell setCellWithModel1Wenjuan:model index:indexPath.row + 1];
      return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PMQuesModel *model=self.dataArray[indexPath.row];
    return [PMQuestionViewCell cellWithHight1:model];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PMQuesModel *model=self.dataArray[indexPath.row];
    [self didTableViewRowWithModel:model withIndex:indexPath.row];

}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}
-(void)setupHeadView{
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, 60)];
    header.backgroundColor=BColor_Hex(@"#FFB602", 0.06);
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.frame = CGRectMake(15,12,WF_ScreenWidth,36);
    tipLabel.numberOfLines = 0;
    tipLabel.text=@"Por favor, complete el cuestionario con información veraz. Esto aumentará la cantidad que podrá obtener.";
    [header addSubview:tipLabel];
    tipLabel.textColor=BColor_Hex(@"#FFB602", 1);
    tipLabel.textAlignment = NSTextAlignmentLeft;
    tipLabel.font=B_FONT_REGULAR(11);
    CGSize size=[UILabel sizeWithText:tipLabel.text fontSize:11 andMaxsize:WF_ScreenWidth-30];
    tipLabel.frame = CGRectMake(15,12,WF_ScreenWidth-30,size.height);
    
    self.tableView.tableHeaderView=header;
}
-(void)setupFootView{
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, 110)];
    footer.backgroundColor=[UIColor whiteColor];
   
    UIButton* submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.tag=1;
    submitBtn.frame = CGRectMake(15,30,WF_ScreenWidth-30,50);
    [submitBtn setTitle:@"Próximo paso" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(clickSubmitBtn) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.layer.cornerRadius=13;
    submitBtn.layer.masksToBounds=YES;
    [footer addSubview:submitBtn];
    [submitBtn addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth - 30, 50) withColors:@[(id)[UIColor jk_colorWithHexString:@"#FFB602"].CGColor,(id)[UIColor jk_colorWithHexString:@"#FC7500"].CGColor] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:13];
    self.tableView.tableFooterView=footer;
}

-(void)clickSubmitBtn{
    
    [self  submitQuest];
    
}

-(void)didTableViewRowWithModel:(PMQuesModel*)model withIndex:(NSInteger)row{
    model.type=row;
    [self.view endEditing:YES];
    NSMutableArray*arr=[NSMutableArray new];
    for (NSDictionary *dict in model.datas) {
        NSString *title=dict[@"bulgaria"];
        [arr addObject:title];
    }
    if (!arr.count) {
        return;
    }
    PoPBottomView * BottomView = [PoPBottomView new];
    
    BottomView.titles = arr;
    WF_WEAKSELF(weakself);
   
    SLFCommentsPopView * popView = [SLFCommentsPopView commentsPopViewWithFrame:CGRectMake(0, 0, WF_ScreenWidth, WF_ScreenHeight) contentView:BottomView contentViewNeedScroView:NO];
    
    [popView showWithTitileStr:@""];
    
    BottomView.selectBlock = ^(NSString * _Nonnull responseObjct, NSInteger indx) {
        
        NSString*content=responseObjct;
        [weakself resetDataWithContent:content withKey:model.ID];
        weakself.parma[model.ID]=model.datas[indx][@"broken"];
        [popView dismiss];
    };
    
//    JKPickerViewAppearance *alert=[[JKPickerViewAppearance alloc] initWithPickerViewTilte:@"" withData:arr pickerCompleteBlock:^(id  _Nonnull responseObjct, NSInteger indx) {
//        strongify(self);
//        NSString*content=responseObjct;
//        [self resetDataWithContent:content withKey:model.ID];
//        self.parma[model.ID]=model.datas[indx][@"broken"];
//
//    }];
//
//    [alert show] ;
//
    
}


-(void)resetDataWithContent:(NSString*)cont withKey:(NSString*)key{
  
    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PMQuesModel *model=(PMQuesModel *)obj;
        if ([model.ID isEqual:key]) {
            *stop = YES;
            if (*stop == YES) {
                model.content=cont;
                [self.dataArray replaceObjectAtIndex:idx withObject:model];
            }
        }
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
   
}

-(void)requestQuestInfo{
    
    [self show];
    NSMutableDictionary*param=[NSMutableDictionary new];
    WF_WEAKSELF(weakself);
    [PMBaseHttp get:GET_Investigate_Info parameters:param success:^(id  _Nonnull responseObject) {
        [self dismiss];
        
        if ([responseObject[@"retail"] intValue]==200) {
            NSArray*arr=responseObject[@"shame"][@"pledge"];
            NSArray *datas =[NSArray yy_modelArrayWithClass:[PMQuesModel class] json:arr];
            [self.dataArray addObjectsFromArray:datas];
        } else {
            [self showTip:responseObject[@"entire"]];
        }
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [self dismiss];
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        
    }];
    

}


-(void)submitQuest{
    
    

    [self show];
    WF_WEAKSELF(weakself);
    [PMBaseHttp postJson:POST_Investigate_Info parameters:self.parma success:^(id  _Nonnull responseObject) {
        [self dismiss];
        if ([responseObject[@"retail"] intValue]==200) {
            [self pushIdVc];
        } else{
            [weakself dismiss];
            [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
    } failure:^(NSError * _Nonnull error) {
        [weakself dismiss];
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        
    }];
}
-(void)pushIdVc{
    
    PMIDAuthViewController*Vc=[PMIDAuthViewController new];
    [self.navigationController pushViewController:Vc animated:YES];
}
@end
