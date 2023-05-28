//
//  AjustesVC.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/27.
//

#import "AjustesVC.h"
#import "WFSetCell.h"
#import "WFBtnCell.h"

@interface AjustesVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/

@end

@implementation AjustesVC



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tempView addSubview:self.tableView];
    self.navTitleLabel.text = @"Ajustes";
    
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
    if (indexPath.row == 0){
        WFSetCell * cell = [WFSetCell cellWithTableView:tableView];
        [cell.typeLabel setText:@"Versión actual" TextColor:[UIColor jk_colorWithHexString:@"#333333"] Font:[UIFont boldSystemFontOfSize:14]];
        [cell.valueLabel setText:@"V1.0" TextColor:[UIColor jk_colorWithHexString:@"#7C7C7C"] Font:[UIFont boldSystemFontOfSize:12]];
        [cell updata:@"jurassic_version" type:@"Versión actual" value:@"V1.0"];
        return cell;
    }else{
        WFBtnCell * cell = [WFBtnCell cellWithTableView:tableView];
        [cell.btn setTitle:@"Próximo paso" forState:UIControlStateNormal];
        cell.btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cell.btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.btn addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth - 30, 50) withColors:@[(id)[UIColor jk_colorWithHexString:@"#FFB602"].CGColor,(id)[UIColor jk_colorWithHexString:@"#FC7500"].CGColor] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:13];
    
        [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(140, 15, 25, 15) height:50];
        return cell;
    }
    
    return [UITableViewCell new];
    
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
