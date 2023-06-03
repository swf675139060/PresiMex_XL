//
//  PMIDAuthViewController.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/30.
//

#import "PMIDAuthViewController.h"
#import "PMIDAuthModel.h"
#import "PMIDAuthViewCell.h"
#import "PMIDAuthTextViewCell.h"
#import "PMIDAuthHeaderView.h"
#import "PMBasicViewController.h"
@interface PMIDAuthViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PMIDAuthViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitleLabel.text=@"Autenticación de identidad";
    [self addRightBarButtonWithImag:@"bai_kefu"];
    [self modelWithData];
    //[self tableView];
}
- (void)modelWithData{

    PMIDAuthModel *model1 = [[PMIDAuthModel alloc] init];
    model1.title     = @"Foto del frente de la tarjeta de identificación";
    model1.desTitle    = @"Haga clic para tomar la foto";
    model1.type=0;
    [self.dataArray addObject:model1];
    
    PMIDAuthModel *model2 = [[PMIDAuthModel alloc] init];
    model2.title     = @"Foto del dorso de la tarjeta de identificación";
    model2.desTitle    = @"Haga clic para tomar la foto";
    model2.type=1;
    [self.dataArray addObject:model2];
    
    PMIDAuthModel *model3 = [[PMIDAuthModel alloc] init];
    model3.title     = @"Autenticación biométrica";
    model3.desTitle    = @"Haga clic para la autenticación biométrica";
    model3.type=2;
    [self.dataArray addObject:model3];
    
    PMIDAuthModel *model4 = [[PMIDAuthModel alloc] init];
    model4.title     =@"Nombre";
    model4.type=3;
    model4.placeHold=@"Por favor llénelo";
    [self.dataArray addObject:model4];
    
    PMIDAuthModel *model5 = [[PMIDAuthModel alloc] init];
    model5.title     =@"Número de identificación";
    model5.type=4;
    model5.placeHold=@"Por favor llénelo";
    [self.dataArray addObject:model5];
  
    [self.tableView reloadData];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, WF_ScreenWidth, WF_ScreenHeight-WF_StatusBarHeight-WF_NavigationHeight-WF_BottomSafeAreaHeight)];
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
        [self setupHeadView];
        [self setupFootView];
        
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
    
    PMIDAuthModel *model=self.dataArray[indexPath.row];
    
    if (indexPath.row<3) {
        PMIDAuthViewCell *cell=[PMIDAuthViewCell cellWithTableView:tableView];
        [cell setCellWithModel:model];
        return cell;
    } else {
        PMIDAuthTextViewCell *cell=[PMIDAuthTextViewCell cellWithTableView:tableView];
        [cell setCellWithModel:model];
        return cell;
    }
   
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row<3) {
        return 208;
    } else {
        return 64;
    }
    
    
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
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, 165)];
    headerView.backgroundColor=[UIColor whiteColor];
    PMIDAuthHeaderView *header = [[PMIDAuthHeaderView alloc] initViewWithType:1];
    [headerView addSubview:header];
    
    UILabel *tipLabel = [[UILabel alloc] init];
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
    PMBasicViewController*Vc=[PMBasicViewController new];
    [self.navigationController pushViewController:Vc animated:YES];
}


@end
