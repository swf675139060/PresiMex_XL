//
//  HomeViewController.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/9.
//

#import "HomeViewController.h"
#import "PMNotiView.h"
#import "WFLeftRightBtnCell.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView; /**< 列表*/


@property (nonatomic, strong) PMNotiView *notiView;



@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarView.hidden = YES;
    [self.view addSubview:self.notiView];
    [self.notiView setNotiContent:@"xxxxxxxxxxx"];
    [self.view addSubview:self.tableView];
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}



#pragma mark -- UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        
        return 2;
    }else if(section == 1){
        
        return 2;
    }else{
        
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            WFLeftRightBtnCell * cell = [WFLeftRightBtnCell cellWithTableView:tableView];
            [cell upBtnsFrameWithEdgeInsets:UIEdgeInsetsMake(15, 16, 13.5, 16)];
            [cell.leftBtn setTitle:@"Bienvenido a PresiMex" forState:UIControlStateNormal];
            [cell.leftBtn setTitleColor:[UIColor jk_colorWithHexString:@"#1B1200"]  forState:UIControlStateNormal];
            cell.leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
//临时图片
            [cell.rightBtn setImage:[UIImage imageNamed:@"guanyuwomen"] forState:UIControlStateNormal];
            return cell;
        }
        
    }
    
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


#pragma mark -- init
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.notiView.swf_bottom, WF_ScreenWidth, WF_ScreenHeight - self.notiView.swf_bottom)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        _tableView.backgroundColor  = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

-(PMNotiView *)notiView{
    if(_notiView == nil){
        _notiView = [[PMNotiView alloc] initWithFrame:CGRectMake(0, WF_StatusBarHeight + 15, WF_ScreenWidth, 33)];
    }
    return _notiView;
}

@end
