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

@interface PMBasicViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PMBasicViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitleLabel.text=@"Información del personal";
    [self addRightBarButtonWithImag:@"bai_kefu"];
    [self modelWithData];
   
}
- (void)modelWithData{

    PMQuestionModel *model1 = [[PMQuestionModel alloc] init];
    model1.title     = @"Género";
    model1.type=0;
    model1.isHave=YES;
    model1.isColor=NO;
    [self.dataArray addObject:model1];
    
    PMQuestionModel *model2 = [[PMQuestionModel alloc] init];
    model2.title     = @"CURP";
    model2.type=1;
    model2.isHave=NO;
    model2.isColor=NO;
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
    [self.dataArray addObject:model4];
    
    PMQuestionModel *model5 = [[PMQuestionModel alloc] init];
    model5.title     =@"Numero de niños";
    model5.type=4;
    model5.isHave=YES;
    model5.isColor=NO;
    [self.dataArray addObject:model5];
    
    PMQuestionModel *model6 = [[PMQuestionModel alloc] init];
    model6.title     =@"Antecedentes educacionales";
    model6.type=5;
    model6.isHave=YES;
    model6.isColor=NO;
    [self.dataArray addObject:model6];
    
    PMQuestionModel *model7= [[PMQuestionModel alloc] init];
    model7.title     =@"Fecha de nacimiento";
    model7.type=6;
    model7.isHave=YES;
    model7.isColor=NO;
    [self.dataArray addObject:model7];
    
    PMQuestionModel *model8 = [[PMQuestionModel alloc] init];
    model8.title     =@"Estado de trabajo";
    model8.type=7;
    model8.isHave=YES;
    model8.isColor=NO;
    [self.dataArray addObject:model8];
    
    PMQuestionModel *model9 = [[PMQuestionModel alloc] init];
    model9.title     =@"Industria";
    model9.type=8;
    model9.isHave=YES;
    model9.isColor=NO;
    [self.dataArray addObject:model9];
    
    PMQuestionModel *model10 = [[PMQuestionModel alloc] init];
    model10.title     =@"Ingreso mensual";
    model10.type=9;
    model10.isHave=NO;
    model10.isColor=NO;
    [self.dataArray addObject:model10];
    
    PMQuestionModel *model11 = [[PMQuestionModel alloc] init];
    model11.title     =@"Tipo de salario";
    model11.type=10;
    model11.isHave=NO;
    model11.isColor=NO;
    [self.dataArray addObject:model11];
    
    PMQuestionModel *model12 = [[PMQuestionModel alloc] init];
    model12.title     =@"Día de pago 1";
    model12.type=11;
    model12.isHave=YES;
    model12.isColor=NO;
    [self.dataArray addObject:model12];
    
    PMQuestionModel *model13 = [[PMQuestionModel alloc] init];
    model13.title     =@"Día de pago 2";
    model13.type=12;
    model13.isHave=YES;
    model13.isColor=NO;
    [self.dataArray addObject:model13];
    
    PMQuestionModel *model14 = [[PMQuestionModel alloc] init];
    model14.title     =@"Nombre de la compañía";
    model14.type=13;
    model14.isHave=NO;
    model14.isColor=NO;
    [self.dataArray addObject:model14];
    
    PMQuestionModel *model15 = [[PMQuestionModel alloc] init];
    model15.title     =@"Número de empresa";
    model15.type=14;
    model15.isHave=NO;
    model15.isColor=NO;
    [self.dataArray addObject:model15];
    
    PMQuestionModel *model16 = [[PMQuestionModel alloc] init];
    model16.title     =@"Estado donde trabaja";
    model16.type=15;
    model16.isHave=YES;
    model16.isColor=NO;
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
    
    return self.dataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PMQuestionModel *model=self.dataArray[indexPath.row];
    PMBasicViewCell *cell=[PMBasicViewCell cellWithTableView:tableView];
    [cell setCellWithModel:model];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
    } else if (indexPath.row == 1) {
        
    } else if (indexPath.row == 2) {
        
    } else if (indexPath.row == 3) {
        
    } else if (indexPath.row == 4) {
        
    } else if (indexPath.row == 5) {
        
    } else if (indexPath.row == 6) {
        
    } else if (indexPath.row == 7) {
        
    } else if (indexPath.row == 8) {
        
    } else if (indexPath.row == 9) {
        
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

-(void)clickSubmitBtn{
    
    PMEmergencyContactViewController*vc=[PMEmergencyContactViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
