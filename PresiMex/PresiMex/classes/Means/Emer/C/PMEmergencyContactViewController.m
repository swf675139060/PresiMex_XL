//
//  PMEmergencyContactViewController.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/6/3.
//

#import "PMEmergencyContactViewController.h"

#import "PMEmergencyContactModel.h"
#import "PMEmergencyContactCell.h"
#import "PMIDAuthHeaderView.h"

@interface PMEmergencyContactViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PMEmergencyContactViewController



-(void)modelWithData{
    
    _dataArray = [NSMutableArray array];
    PMEmergencyContactModel *relationModel = [[PMEmergencyContactModel alloc] init];
    //relationModel.relation     =[self setInitStringWithKey:PS_EmContact_Relation1]; ;
    relationModel.type  =@"0";
    //relationModel.name   = [self setInitStringWithKey:PS_EmContact_Relation_Name1];
    //relationModel.telephone= [self setInitStringWithKey:PS_EmContact_Relation_Number1];
    
    [_dataArray addObject:relationModel];
    
    
    PMEmergencyContactModel *relationModel1 = [[PMEmergencyContactModel alloc] init];
    //relationModel1.relation =[self setInitStringWithKey:PS_EmContact_Relation2]; ;
    relationModel1.type  =@"1";
    //relationModel1.name   = [self setInitStringWithKey:PS_EmContact_Relation_Name2];
   // relationModel1.telephone= [self setInitStringWithKey:PS_EmContact_Relation_Number2];
    [_dataArray addObject:relationModel1];
    [self.tableView reloadData];
}
   

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitleLabel.text=@"Información del personal";
    [self addRightBarButtonWithImag:@"bai_kefu"];
    [self modelWithData];
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
    
    PMEmergencyContactModel *model=self.dataArray[indexPath.row];
    PMEmergencyContactCell *cell=[PMEmergencyContactCell cellWithTableView:tableView];
    [cell setCellWithModel:model];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200;
    
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
    PMIDAuthHeaderView *header = [[PMIDAuthHeaderView alloc] initViewWithType:3];
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
    
    //PMEmergencyContactViewController*vc=[PMEmergencyContactViewController new];
    //[self.navigationController pushViewController:vc animated:YES];
    
}
@end
