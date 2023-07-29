//
//  CuponVC.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/27.
//

#import "CuponVC.h"
#import "CuponCell.h"
#import "CuponModel.h"

@interface CuponVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/


@property (nonatomic, assign) NSInteger eg; //页


@property (nonatomic, strong) NSMutableArray *dataArr; /**< 列表*/



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
    
    //优惠券页面
    PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_coupon content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
    [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
    
}


#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CuponCell * cell = [CuponCell cellWithTableView:tableView];
    
    [cell updataWithModel:self.dataArr[indexPath.row] indx:indexPath.row];
    
    cell.clickUseBlock = ^(NSInteger indx) {
        
    };
    
    return cell;
   
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    
}

#pragma mark - DZNEmptyDataSetSource
// 返回图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"wuYouhui"];
}

// 返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"Aún no hay cupones";
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:14.0f], NSForegroundColorAttributeName: BColor_Hex(@"#1B1200", 1)};
    return [[NSAttributedString alloc] initWithString:text attributes:attribute];
}

// 标题文字与详情文字的距离
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 20;
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
        
        _tableView.emptyDataSetSource= self;

        _tableView.emptyDataSetDelegate= self;
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
            NSArray * dataList = responseObject[@"shame"][@"approaches"];
            
            weakself.dataArr = [CuponModel mj_objectArrayWithKeyValuesArray:dataList];
            [weakself.tableView reloadData];
            
        }else{
            
                [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
        [weakself.tableView.mj_footer endRefreshing];
        
        
    } failure:^(NSError * _Nonnull error) {
        
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        [weakself.tableView.mj_footer endRefreshing];
        
    }];
    
}


-(NSMutableArray *)dataArr{
    if(_dataArr == nil){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
