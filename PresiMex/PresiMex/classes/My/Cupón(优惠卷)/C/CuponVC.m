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

@end

@implementation CuponVC



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tempView addSubview:self.tableView];
    self.navTitleLabel.text = @"Cupón";
    
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
@end
