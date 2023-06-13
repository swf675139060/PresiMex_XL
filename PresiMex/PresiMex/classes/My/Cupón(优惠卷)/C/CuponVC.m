//
//  CuponVC.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/27.
//

#import "CuponVC.h"
#import "CuponCell.h"

@interface CuponVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/


@property (nonatomic, assign) NSInteger eg; //页

@end

@implementation CuponVC



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tempView addSubview:self.tableView];
    self.eg = 1;
    
    WF_WEAKSELF(weakself);
//    self.tableView.mj_footer =  [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        weakself.eg += 1;
//        [weakself GETCouponUrl];
//    }];
    self.navTitleLabel.text = @"Cupón";
    
    [self GETCouponUrl];
    
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
    
    CuponCell * cell = [CuponCell cellWithTableView:tableView];
    
    [cell updataWithModel:@"" indx:indexPath.row];
    
    cell.clickUseBlock = ^(NSInteger indx) {
        
    };
    
    return cell;
   
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    
}


-(void)clickBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- init
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, WF_ScreenHeight - WF_NavigationHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor  = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}


//获取优惠卷
-(void)GETCouponUrl{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
    pars[@"eg"] = [NSString stringWithFormat:@"%ld",self.eg];
    pars[@"patricia"] = @"100";
    WF_WEAKSELF(weakself);
    [PMBaseHttp get:GET_Coupon_Url parameters:pars success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"retail"] intValue]==200) {
            NSDictionary * shame = responseObject[@"shame"];
            
            
        }else{
            
        }
        
        [weakself.tableView.mj_footer endRefreshing];
        
        
    } failure:^(NSError * _Nonnull error) {
        
        [weakself.tableView.mj_footer endRefreshing];
        
    }];
}

@end
