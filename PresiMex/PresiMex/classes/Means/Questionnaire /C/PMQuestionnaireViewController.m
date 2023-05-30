//
//  PMQuestionnaireViewController.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/30.
//

#import "PMQuestionnaireViewController.h"

#import "PMQuestionModel.h"
#import "PMQuestionViewCell.h"

@interface PMQuestionnaireViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation PMQuestionnaireViewController

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
    [self modelWithData];
    
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
    
    PMQuestionModel *model=self.dataArray[indexPath.row];
    PMQuestionViewCell *cell=[PMQuestionViewCell cellWithTableView:tableView];
    [cell setCellWithModel:model];
      return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PMQuestionModel *model=self.dataArray[indexPath.row];
    return [PMQuestionViewCell cellWithHight:model];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   

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
    
}


@end
