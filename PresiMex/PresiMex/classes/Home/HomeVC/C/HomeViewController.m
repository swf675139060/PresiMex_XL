//
//  HomeViewController.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/9.
//

#import "HomeViewController.h"
#import "PMNotiView.h"
#import "WFLeftRightBtnCell.h"
#import "WFLabelCell.h"
#import "WFSliderCell.h"
#import "WFThreeBtnCell.h"
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

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        
        return 6;
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
        }else if (indexPath.row == 1){
            WFLabelCell * cell  = [WFLabelCell cornerCellWithTableView:tableView];
            cell.label.textAlignment = NSTextAlignmentLeft;
            [cell.label setText:@"Opciones Recomendadas" TextColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:13]];
            [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15) maskedCorners: kCALayerMinXMinYCorner | kCALayerMinXMinYCorner cornerRadius:15];
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 15, 5, 15)];
            [cell.BGView addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth-30, 33) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner cornerRadius:15];
            
            
            return cell;
            
            
        }else if (indexPath.row == 2){
            WFLabelCell * cell  = [WFLabelCell cellWithTableView:tableView];
            cell.label.textAlignment = NSTextAlignmentCenter;
            [cell.label setText:@"30,000" TextColor:[UIColor whiteColor] Font:[UIFont boldSystemFontOfSize:25]];
            
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(2, 15, 5, 15)];
    
            [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
            [cell.BGView addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth-30, 37) maskedCorners:kCALayerMinXMinYCorner cornerRadius:0.1];
            
            
            return cell;
            
            
        }else if (indexPath.row == 3){
            WFSliderCell * cell  = [WFSliderCell cellWithTableView:tableView];
            
            [cell.slider trackRectForBounds:CGRectMake(0, 0, WF_ScreenWidth - 30, 8)];
            cell.slider.backgroundColor = [UIColor redColor];
            [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
            [cell upSliderFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15) height:21];
            [cell.BGView addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth-30, 24) maskedCorners:kCALayerMinXMinYCorner cornerRadius:0.1];
            
            return cell;
            
            
        }else if (indexPath.row == 4){
            WFThreeBtnCell * cell = [WFThreeBtnCell cellWithTableView:tableView];
            [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15) height:24.5];
            [cell upBtnsFrameWithInsets:UIEdgeInsetsMake(10, 15, 0, 15)];
            [cell.BGView addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth-30, 25) maskedCorners:kCALayerMinXMinYCorner cornerRadius:0.1];
            
            [cell.leftBtn setText:@"$500" TextColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
            [cell.centerBtn setText:@"Plazo de validez del límite" TextColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
            [cell.rightBtn setText:@"$30,000" TextColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
            
            

            return cell;
            
        }else{
            WFLabelCell * cell  = [WFLabelCell cellWithTableView:tableView];
            cell.label.textAlignment = NSTextAlignmentCenter;
            [cell.label setText:@"2d, 12h, 30m,12s" TextColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:11]];
            
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(5, 15, 8.5, 15)];
    
            [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
            [cell.BGView addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth-30, 23.5) maskedCorners:kCALayerMinXMinYCorner cornerRadius:0.1];
            
            
            
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
