//
//  PMBasicViewController.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/6/3.
//

#import "PMBasicViewController.h"
#import "PMQuestionModel.h"
#import "PMBasicViewCell.h"
#import "PMQuestionViewCell.h"
#import "PMIDAuthHeaderView.h"
#import "PMEmergencyContactViewController.h"
#import "JKPickerViewAppearance.h"
#import "BasicDataModel.h"
#import "CXDatePickerView.h"


#import "PMIDAuthModel.h"

@interface PMBasicViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSDate *date;



@end

@implementation PMBasicViewController

//-(void)leftItemAction{
//    [self shoWYouHuiAlert:@[]];
//}

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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitleLabel.text=@"Información personal";
    [self addRightBarButtonWithImag:@"bai_kefu"];
    [self modelWithData];
    
    // 创建日期组件
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:1995];
    [components setMonth:1];
    [components setDay:1];

    // 创建日历对象并指定日历类型
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    // 从日期组件和日历对象创建NSDate对象
    NSDate *date = [calendar dateFromComponents:components];
    self.date = date;
    
    if(!self.userID){
        [self requestImagPic];
    }
    
    //基本信息认证页
    PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_base_auth content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
    [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
   
}
- (void)modelWithData{

    BasicData * dataModel =[BasicData new];
    [dataModel initData];
    
    
    PMQuestionModel *model1 = [[PMQuestionModel alloc] init];
    model1.title     = @"Género";
    model1.type=0;
    model1.isHave=YES;
    model1.isColor=NO;
    model1.contentArr =  dataModel.Género;
    [self.dataArray addObject:model1];
    
    PMQuestionModel *model2 = [[PMQuestionModel alloc] init];
    model2.title     = @"CURP";
    model2.type=1;
    model2.isHave=NO;
    model2.isColor=NO;
    if(self.userID){
        model2.content=self.userID;
    }
    [self.dataArray addObject:model2];
    
    PMQuestionModel *model3 = [[PMQuestionModel alloc] init];
    model3.title     = @"Correo electrónico";
    model3.type=2;
    model3.isHave=NO;
    model3.isColor=NO;
    [self.dataArray addObject:model3];
    
    PMQuestionModel *model4 = [[PMQuestionModel alloc] init];
    model4.title     =@"Estado civil";
    model4.type=3;
    model4.isHave=YES;
    model4.isColor=NO;
    model4.contentArr =  dataModel.EstadoCivil;
    [self.dataArray addObject:model4];
    
    PMQuestionModel *model5 = [[PMQuestionModel alloc] init];
    model5.title     =@"Numero de niños";
    model5.type=4;
    model5.isHave=YES;
    model5.isColor=NO;
    model5.contentArr =  dataModel.NumeroDeNiños;
    [self.dataArray addObject:model5];
    
    PMQuestionModel *model6 = [[PMQuestionModel alloc] init];
    model6.title     =@"Antecedentes educacionales";
    model6.type=5;
    model6.isHave=YES;
    model6.isColor=NO;
    model6.contentArr =  dataModel.AntecedenteEducacionales;
    [self.dataArray addObject:model6];
    
    PMQuestionModel *model7= [[PMQuestionModel alloc] init];
    model7.title     =@"Fecha de nacimiento";
    model7.type=6;
    model7.isHave=YES;
    model7.isColor=NO;
//    model7.contentArr =  dataModel.Fec;
    [self.dataArray addObject:model7];
    
    PMQuestionModel *model8 = [[PMQuestionModel alloc] init];
    model8.title     =@"Estado de trabajo";
    model8.type=7;
    model8.isHave=YES;
    model8.isColor=NO;
    model8.contentArr =  dataModel.EstadoDeTrabajo;
    [self.dataArray addObject:model8];
    
    PMQuestionModel *model9 = [[PMQuestionModel alloc] init];
    model9.title     =@"Industria";
    model9.type=8;
    model9.isHave=YES;
    model9.isColor=NO;
    model9.contentArr =  dataModel.Industria;
    [self.dataArray addObject:model9];
    
    PMQuestionModel *model10 = [[PMQuestionModel alloc] init];
    model10.title     =@"Ingreso mensual";
    model10.type=9;
    model10.isHave=YES;
    model10.isColor=NO;
    model10.contentArr =  dataModel.IngresoMensual;
    [self.dataArray addObject:model10];
    
    PMQuestionModel *model11 = [[PMQuestionModel alloc] init];
    model11.title     =@"Tipo de salario";
    model11.type=10;
    model11.isHave=YES;
    model11.isColor=NO;
    model11.contentArr =  dataModel.TipoDeSalario;
    [self.dataArray addObject:model11];
    
    PMQuestionModel *model12 = [[PMQuestionModel alloc] init];
    model12.title     =@"Día de pago 1";
    model12.type=11;
    model12.isHave=YES;
    model12.isColor=NO;
    model12.contentArr =  dataModel.DíaDePago1;
    [self.dataArray addObject:model12];
    
    PMQuestionModel *model13 = [[PMQuestionModel alloc] init];
    model13.title     =@"Día de pago 2";
    model13.type=12;
    model13.isHave=YES;
    model13.isColor=NO;
    model13.REQUIRED = NO;
    model13.contentArr =  dataModel.DíaDePago2;
    [self.dataArray addObject:model13];
    
    PMQuestionModel *model14 = [[PMQuestionModel alloc] init];
    model14.title     =@"Nombre de la compañía";
    model14.type=13;
    model14.isHave=NO;
    model14.isColor=NO;
    model14.REQUIRED = NO;
    [self.dataArray addObject:model14];
    
    PMQuestionModel *model15 = [[PMQuestionModel alloc] init];
    model15.title     =@"Número de empresa";
    model15.type=14;
    model15.isHave=NO;
    model15.isColor=NO;
    model15.REQUIRED = NO;
    [self.dataArray addObject:model15];
    
    PMQuestionModel *model16 = [[PMQuestionModel alloc] init];
    model16.title     =@"Estado donde trabaja";
    model16.type=15;
    model16.isHave=YES;
    model16.isColor=NO;
    model16.contentArr =  dataModel.EstadoDeTrabajo;
    [self.dataArray addObject:model16];
    
    PMQuestionModel *model17 = [[PMQuestionModel alloc] init];
    model17.title     =@"Municipio donde trabaja";
    model17.type=16;
    model17.isHave=NO;
    model17.isColor=NO;
    [self.dataArray addObject:model17];
    
    PMQuestionModel *model18 = [[PMQuestionModel alloc] init];
    model18.title     =@"Dirección detallada de trabajo";
    model18.type=17;
    model18.isHave=NO;
    model18.isColor=NO;
    [self.dataArray addObject:model18];
    
 
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
    
    PMQuestionModel *model8=self.dataArray[7];
    if(model8.indx == 0 || model8.indx == 1 || model8.indx == 2 ){
        return self.dataArray.count;
    }else{
        return 8;
    }
        
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PMQuestionModel *model=self.dataArray[indexPath.row];
    PMBasicViewCell *cell=[PMBasicViewCell cellWithTableView:tableView];
    [cell setCellWithModel:model maxCount:1000];
    
    weakify(cell);
    [cell setEndInputBlock:^(NSString * _Nonnull title, NSString * _Nonnull text, BOOL end) {
        strongify(cell);
        model.isColor = NO;
        model.content = text;
        
        if (end) {
            if (indexPath.row == 1) {
                PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_curp content:text beginTime:cell.contentTF.beginTime Duration:cell.contentTF.duration];
                [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];

            } else if (indexPath.row == 2) {
                PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_email content:text beginTime:cell.contentTF.beginTime Duration:cell.contentTF.duration];
                [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];

            } else if (indexPath.row == 13) {
                
                    PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_company_name content:text beginTime:cell.contentTF.beginTime Duration:cell.contentTF.duration];
                    [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
            } else if (indexPath.row == 14) {
                PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_company_number content:text beginTime:cell.contentTF.beginTime Duration:cell.contentTF.duration];
                [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
            }else if (indexPath.row == 16) {
                
                    PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_work_district content:text beginTime:cell.contentTF.beginTime Duration:cell.contentTF.duration];
                    [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
            } else if (indexPath.row == 17) {
                PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_work_detail_address content:text beginTime:cell.contentTF.beginTime Duration:cell.contentTF.duration];
                [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
            }
        }
        
    }];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self sutupAlertViewWithIndx:indexPath.row];
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_gender content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
    } else if (indexPath.row == 1) {
        
    } else if (indexPath.row == 2) {
        
    } else if (indexPath.row == 3) {
        [self sutupAlertViewWithIndx:indexPath.row];
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_marry_state content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        
    } else if (indexPath.row == 4) {
        [self sutupAlertViewWithIndx:indexPath.row];
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_children_num content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        
    } else if (indexPath.row == 5) {
        [self sutupAlertViewWithIndx:indexPath.row];
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_education content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        
    } else if (indexPath.row == 6) {
        [self showYearMonth];
//        [self sutupAlertViewWithIndx:indexPath.row];
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_birth content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        
    } else if (indexPath.row == 7) {
        [self sutupAlertViewWithIndx:indexPath.row];
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_job_state content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        
    } else if (indexPath.row == 8) {
        [self sutupAlertViewWithIndx:indexPath.row];
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_industry content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        
    } else if (indexPath.row == 9) {
        [self sutupAlertViewWithIndx:indexPath.row];
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_month_income content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        
    } else if (indexPath.row == 10) {
        [self sutupAlertViewWithIndx:indexPath.row];
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_salary_type content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        
    } else if (indexPath.row == 11) {
        [self sutupAlertViewWithIndx:indexPath.row];
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_salary_day1 content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        
    } else if (indexPath.row == 12) {
        [self sutupAlertViewWithIndx:indexPath.row];
        
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_salary_day1 content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        
    } else if (indexPath.row == 13) {
        
    } else if (indexPath.row == 14) {
        
    } else if (indexPath.row == 15) {
        [self sutupAlertViewWithIndx:indexPath.row];
        
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_work_city content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        
    } else if (indexPath.row == 16) {
        
    } else if (indexPath.row == 17) {
        
    }
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}
-(void)setupHeadView{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, 165)];
    headerView.backgroundColor=[UIColor whiteColor];
    PMIDAuthHeaderView *header = [[PMIDAuthHeaderView alloc] initViewWithType:2];
    [headerView addSubview:header];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.frame = CGRectMake(15,12,WF_ScreenWidth,36);
    tipLabel.numberOfLines = 0;
    tipLabel.text=@"Consejo: asegúrese de que todas las imágenes de los documentos se tomen con claridad y sean las más recientes para obtener el préstamo al instante.";
    [headerView addSubview:tipLabel];
    tipLabel.textColor=BColor_Hex(@"#FFB602", 1);
    tipLabel.textAlignment = NSTextAlignmentLeft;
    tipLabel.font=B_FONT_REGULAR(11);
    CGSize size=[UILabel sizeWithText:tipLabel.text fontSize:11 andMaxsize:WF_ScreenWidth-30];
    tipLabel.frame = CGRectMake(15,header.swf_bottom+12,WF_ScreenWidth-30,size.height);
    self.tableView.tableHeaderView=headerView;
    
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


-(void)sutupAlertViewWithIndx:(NSInteger)indxP{
    [self.view endEditing:YES];
    
    
    NSMutableArray * arr = [NSMutableArray array];
    PMQuestionModel * model = self.dataArray[indxP];
    
    for (BasicDataModel * dataModel in model.contentArr) {
        [arr addObject:dataModel.title];
    }
    
//    weakify(self);
//    JKPickerViewAppearance *alert=[[JKPickerViewAppearance alloc] initWithPickerViewTilte:model.title withData:arr pickerCompleteBlock:^(id  _Nonnull responseObjct,NSInteger indx) {
//        strongify(self);
//        PMQuestionModel * model = self.dataArray[indxP];
//        model.indx = indx;
//       
//        
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
        PMQuestionModel * model = self.dataArray[indxP];
        model.indx = indx;
        model.isColor = NO;
        [self.tableView reloadData];
        [popView dismiss];
        [self Dot:indx];
    };
}


-(void)Dot:(NSInteger)indx{
    
    NSString * content = @"";
    PMQuestionModel *model=self.dataArray[indx];
    if (model.isHave) {
        if (model.indx >= 0) {
            BasicDataModel *  DataModel = model.contentArr[model.indx];
            content = DataModel.title;
        }else if (model.content && model.content.length){
            content =model.content;
        }else{
            content = @"";
        }
    } else {
        content=model.content;
    }
   
    
    
    if (indx == 0) {
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_gender content:content beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
    } else if (indx == 1) {
        
    } else if (indx == 2) {
        
    } else if (indx == 3) {
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_marry_state content:content beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        
    } else if (indx == 4) {
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_children_num content:content beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        
    } else if (indx == 5) {
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_education content:content beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        
    } else if (indx == 6) {
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_birth content:content beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        
    } else if (indx == 7) {
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_job_state content:content beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        
    } else if (indx == 8) {
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_industry content:content beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        
    } else if (indx == 9) {
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_month_income content:content beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        
    } else if (indx == 10) {
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_salary_type content:content beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        
    } else if (indx == 11) {
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_salary_day1 content:content beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        
    } else if (indx == 12) {
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_salary_day1 content:content beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        
    } else if (indx == 13) {
        
    } else if (indx == 14) {
        
    } else if (indx == 15) {
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_base_auth_work_city content:content beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        
    }
}
#pragma mark - 年-月
- (void)showYearMonth{
    //年-月
    WF_WEAKSELF(weakself);
    CXDatePickerView *datepicker = [[CXDatePickerView alloc] initWithDateStyle:CXDateYearMonthDay scrollToDate:self.date completeBlock:^(NSDate *selectDate) {
        weakself.date = selectDate;
       
        NSString *dateString = [selectDate cx_stringWithFormat:@"dd-MM-yyyy"];
        PMQuestionModel * model = self.dataArray[6];
        model.content = dateString;
        [weakself.tableView reloadData];
    }];
    datepicker.datePickerFont = [UIFont systemFontOfSize:15];
    datepicker.datePickerColor = BColor_Hex(@"#999999", 1);//滚轮日期颜色
    datepicker.datePickerSelectColor = BColor_Hex(@"#333333", 1);//滚轮日期颜色
    datepicker.doneButtonColor = [UIColor whiteColor];//确定按钮的颜色
    datepicker.cancelButtonColor = BColor_Hex(@"#333333", 1);
    [datepicker show];
}


-(void)clickSubmitBtn{
    NSInteger arrCount = 8;
    
    PMQuestionModel *model8=self.dataArray[7];
    if(model8.indx == 0 || model8.indx == 1 || model8.indx == 2 ){
        arrCount = self.dataArray.count;
    }else{
        arrCount = 8;
    }
    for (int i = 0; i < arrCount; i++) {
        PMQuestionModel *model=self.dataArray[i];
        
        if (model.REQUIRED) {
            if (model.isHave) {
                if (model.indx >= 0) {
                    continue;
                }else if (model.content && model.content.length){
                    continue;
                }else{
                    model.isColor = YES;
                    [self showTip:@"Verifique los campos obligatorios."];
                    [self.tableView reloadData];
                    return;
                }
            } else {
                if (model.content && model.content.length) {
                    if (i == 2) {
                        //邮箱
                        if ([self isValidEmail:model.content]) {
                            continue;
                        } else {
                            model.isColor = YES;
                            [self showTip:@"Por favor, introduzca el buzón correcto."];
                            [self.tableView reloadData];
                            PMBasicViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                            [cell.contentTF becomeFirstResponder];
                            
                            return;
                        }
                    } else {
                        continue;
                    }
                    
                } else {
                    model.isColor = YES;
                    [self showTip:@"Verifique los campos obligatorios."];
                    [self.tableView reloadData];
                    return;
                }
            }
        } else {
            continue;
        }
    }
    
 
    
    
    [self POSTUserBaseMeans];
    
   
}
- (BOOL)isValidEmail:(NSString *)email {
    // 定义邮箱格式的正则表达式
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}";
    
    // 创建正则表达式对象
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:emailRegex options:NSRegularExpressionCaseInsensitive error:nil];
    
    // 在邮箱字符串中查找符合正则表达式的字符串
    NSTextCheckingResult *match = [regex firstMatchInString:email options:0 range:NSMakeRange(0, [email length])];
    
    // 如果找到符合正则表达式的字符串，则返回YES，否则返回NO
    return (match != nil);
}

-(void)POSTUserBaseMeans{

    
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
    PMQuestionModel * model1 = self.dataArray[0];
    BasicDataModel * dataModel1 = model1.contentArr[model1.indx];
    pars[@"rental"] = [NSNumber numberWithLong:dataModel1.ID];//性别:
    
    PMQuestionModel * model2 = self.dataArray[1];
    pars[@"cartoon"] = model2.content;//身份证号
    
    PMQuestionModel * model3 = self.dataArray[2];
    pars[@"kenny"] = model3.content;//身份证号
    
    PMQuestionModel * model4 = self.dataArray[3];
    BasicDataModel * dataModel4 = model4.contentArr[model4.indx];
    pars[@"profits"] = [NSNumber numberWithLong:dataModel4.ID];//婚姻状况
    
    
    PMQuestionModel * model5 = self.dataArray[4];
    BasicDataModel * dataModel5 = model5.contentArr[model5.indx];
    pars[@"payable"] = [NSNumber numberWithLong:dataModel5.ID];//孩子数量
    
    PMQuestionModel * model6 = self.dataArray[5];
    BasicDataModel * dataModel6 = model6.contentArr[model6.indx];
    pars[@"emerging"] = [NSNumber numberWithLong:dataModel6.ID];//学历
    
    PMQuestionModel * model7 = self.dataArray[6];
    pars[@"pod"] = model7.content;//出生日期(dd-MM-YYYY)
    
    PMQuestionModel * model8 = self.dataArray[7];
    BasicDataModel * dataModel8 = model8.contentArr[model8.indx];
    pars[@"browsers"] = [NSNumber numberWithLong:dataModel8.ID];//工作状态
   
    if(model8.indx == 0 || model8.indx == 1 || model8.indx == 2 ){
        PMQuestionModel * model9 = self.dataArray[8];
        BasicDataModel * dataModel9 = model9.contentArr[model9.indx];
        pars[@"pays"] = [NSNumber numberWithLong:dataModel9.ID];//行业
        
        PMQuestionModel * model10 = self.dataArray[9];
        BasicDataModel * dataModel10 = model10.contentArr[model10.indx];
        pars[@"transcription"] = [NSNumber numberWithLong:dataModel10.ID];//月收入(比索)
        
        
        PMQuestionModel * model11 = self.dataArray[10];
        BasicDataModel * dataModel11 = model11.contentArr[model11.indx];
        pars[@"fda"] = [NSNumber numberWithLong:dataModel11.ID];//工资类型:
        
        PMQuestionModel * model12 = self.dataArray[11];
        BasicDataModel * dataModel12 = model12.contentArr[model12.indx];
        pars[@"today"] = [NSNumber numberWithLong:dataModel12.ID];//    发薪日1
        
        PMQuestionModel * model13 = self.dataArray[12];
        if (model13.indx >= 0) {
            BasicDataModel * dataModel13 = model13.contentArr[model13.indx];
            pars[@"wires"] = [NSNumber numberWithLong:dataModel13.ID];//    发薪日2
        }
        
        PMQuestionModel * model14 = self.dataArray[13];
        if (model14.content && model14.content >= 0) {
            pars[@"speaker"] = model14.content;//    公司名称,选填
        }
        
        PMQuestionModel * model15 = self.dataArray[14];
        if (model15.content && model15.content >= 0) {
            pars[@"airline"] = model15.content;//     公司电话,选填
        }
        
        
        PMQuestionModel * model16 = self.dataArray[15];
        BasicDataModel * dataModel16 = model16.contentArr[model16.indx];
        pars[@"head"] = [NSNumber numberWithLong:dataModel16.ID];//公司所在的城市
        
        
        PMQuestionModel * model17 = self.dataArray[16];
        if (model17.content && model17.content >= 0) {
            pars[@"dosage"] = model17.content;// 公司所在的区
        }
        
        PMQuestionModel * model18 = self.dataArray[17];
        if (model18.content && model18.content >= 0) {
            pars[@"lies"] = model18.content;// 公司详细地址
        }
        
    }
    
    
    [self show];
    WF_WEAKSELF(weakself);
    [PMBaseHttp postJson:POST_User_Base_Means parameters:pars success:^(id  _Nonnull responseObject) {
        [weakself dismiss];
        if ([responseObject[@"retail"] intValue]==200) {
            PMEmergencyContactViewController*vc=[PMEmergencyContactViewController new];
            [weakself.navigationController pushViewController:vc animated:YES];
            
            [[AppsFlyerLib shared]  logEvent: @"af_action_04" withValues:nil];
        }else{
            [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
    } failure:^(NSError * _Nonnull error) {
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        [weakself dismiss];
        
    }];
    
}


//15002 - Ocr回显接口(类型合并+活体照+字段)
-(void)requestImagPic{
    
    [self show];
    NSMutableDictionary*dict=[NSMutableDictionary new];
    WF_WEAKSELF(weakself);
    [PMBaseHttp get:GET_OCR_USER_INFO parameters:dict success:^(id  _Nonnull responseObject) {
        [self dismiss];
        if ([responseObject[@"retail"]intValue]==200) {
            PMIDAuthModel*model=[PMIDAuthModel yy_modelWithDictionary:responseObject[@"shame"]];
           
            
            
            PMQuestionModel *model2 = self.dataArray[1];
            
            self.userID = model.cartoon;
            if(self.userID){
                model2.content=self.userID;
            }
            [self.tableView reloadData];
        } else{
            [weakself dismiss];
            [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
    } failure:^(NSError * _Nonnull error) {
        [weakself dismiss];
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        
    }];
}

@end
