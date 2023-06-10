//
//  OrderVC.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/27.
//

#import "OrderVC.h"
#import "PMOrderTopView.h"
#import "OrderCell.h"
#import "OrderModel.h"
#import "OrderDetailsVC.h"

@interface OrderVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

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
        [weakself GETUserOder];
        
        
    }];
    [self.topView setClickRightBtnBlock:^{
        weakself.indx = 1;
        [weakself GETUserOder];
    }];
    [self.tempView addSubview:self.tableView];
    self.navTitleLabel.text = @"Lista de facturas";
    
    [self GETUserOder];
    
}


#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.indx == 0) {
        return  self.leftArr.count;
    } else {
        return  self.rightArr.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OrderCell * cell = [OrderCell cellWithTableView:tableView];
    OrderModel * model;
    if (self.indx == 0) {
        model = self.leftArr[indexPath.row];
    } else {
        model = self.rightArr[indexPath.row];
    }
    [cell updataWithModel:model indx:indexPath.row];

    cell.clickUseBlock = ^(NSInteger indx) {

    };
    
    return cell;
   
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:true];
    OrderDetailsVC * vc = [[OrderDetailsVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - DZNEmptyDataSetSource
// 返回图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"beiju"];
}

// 返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"Oportunidades";
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:14.0f], NSForegroundColorAttributeName: BColor_Hex(@"#1B1200", 1)};
    return [[NSAttributedString alloc] initWithString:text attributes:attribute];
}

// 返回详情文字
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView { NSString *text = @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f], NSForegroundColorAttributeName: [UIColor lightGrayColor], NSParagraphStyleAttributeName: paragraph};
    return [[NSAttributedString alloc] initWithString:text attributes:attribute];
}

// 返回可以点击的按钮 上面带文字
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
    return [[NSAttributedString alloc] initWithString:@"哈喽" attributes:attribute];
}

//#pragma mark - DZNEmptyDataSetDelegate
// 处理按钮的点击事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.baidu.com"]];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

// 标题文字与详情文字的距离
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 100;
}

// 返回空白区域的颜色自定义
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor cyanColor];
}

// 标题文字与详情文字同时调整垂直偏移量
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -100;
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
        
        _tableView.emptyDataSetSource= self;

        _tableView.emptyDataSetDelegate= self;
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
  
    if (self.indx == 0) {
        pars[@"cos"] = @"0";
    } else {
        pars[@"cos"] = @"1";
    }
    [self.view show];
    WF_WEAKSELF(weakself);
    [PMBaseHttp get:GET_User_Oder parameters:pars success:^(id  _Nonnull responseObject) {
        
        [weakself.view dismiss];
        if ([responseObject[@"retail"] intValue]==200) {
            NSArray * pledge = responseObject[@"shame"][@"pledge"];
            NSArray *modelArr = [OrderModel mj_objectArrayWithKeyValuesArray:pledge];
            if (weakself.indx == 0) {
                weakself.leftArr = [NSMutableArray arrayWithArray:modelArr];
                
            } else {
                weakself.leftArr = [NSMutableArray arrayWithArray:modelArr];
            }
            
            [weakself.tableView reloadData];
            
            
        }else{
            [weakself.view showTip:responseObject[@"entire"]];
        }
        
        
        
    } failure:^(NSError * _Nonnull error) {
        
        [weakself.view dismiss];
    }];
}
@end
