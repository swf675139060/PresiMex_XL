//
//  OrderVC.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/27.
//

#import "OrderVC.h"
#import "PMOrderTopView.h"
#import "OrderCell.h"

@interface OrderVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/

@property (nonatomic, strong) PMOrderTopView *topView;


@property (nonatomic, strong) NSMutableArray *leftArr;

@property (nonatomic, strong) NSMutableArray *rightArr;


@property (nonatomic, assign) NSInteger indx;

@end

@implementation OrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tempView addSubview:self.topView];
    WF_WEAKSELF(weakself);
    [self.topView setClickLeftBtnBlock:^{
        weakself.indx = 0;
        [weakself.tableView reloadData];
        
        
    }];
    [self.topView setClickRightBtnBlock:^{
        weakself.indx = 1;
        [weakself.tableView reloadData];
        
    }];
    [self.tempView addSubview:self.tableView];
    self.navTitleLabel.text = @"Lista de facturas";
    
    [self GETUserOder];
    
}


#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OrderCell * cell = [OrderCell cellWithTableView:tableView];
    
    [cell updataWithModel:@"" indx:indexPath.row];

    cell.clickUseBlock = ^(NSInteger indx) {

    };
    
    return cell;
   
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    
}



#pragma mark -- init
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, WF_ScreenWidth, WF_ScreenHeight - WF_NavigationHeight - 70)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor  = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

-(PMOrderTopView *)topView{
    if(_topView == nil){
        _topView = [[PMOrderTopView alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, 70)];
        [_topView selectIndx:0];
    }
    return _topView;
}

-(NSMutableArray *)leftArr{
    if(_leftArr == nil){
        _leftArr = [NSMutableArray array];
    }
    return _leftArr;
}

-(NSMutableArray *)rightArr{
    if(_rightArr == nil){
        _rightArr = [NSMutableArray array];
    }
    return _rightArr;
}


//获取用户订单接口
-(void)GETUserOder{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
  
    if (self.indx) {
        pars[@"cos"] = @"0";
    } else {
        pars[@"cos"] = @"1";
    }
    WF_WEAKSELF(weakself);
    [PMBaseHttp get:GET_User_Oder parameters:pars success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"retail"] intValue]==200) {
            NSDictionary * shame = responseObject[@"shame"];
            
            
        }else{
//            [SLFToast showWithContent:responseObject[@"entire"] afterDelay:2];
        }
        
        
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
@end
