//
//  HomeDetailsVC.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/30.
//

#import "HomeDetailsVC.h"
#import "WFFourLabelCell.h"
#import "HomeSectionView.h"
#import "WFLeftRightLabelCell.h"

@interface HomeDetailsVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataList;


@property (nonatomic, strong) UITableView *tableView; /**< 列表*/

@property (nonatomic, assign) NSInteger selectIndx;// 点击的section


@end

@implementation HomeDetailsVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.dataList addObject:@""];
    [self.dataList addObject:@""];
    [self.dataList addObject:@""];
    [self.dataList addObject:@""];
    
    [self.tempView addSubview:self.tableView];
    self.navTitleLabel.text = @"Detalles de préstamo";
    
}


#pragma mark -- UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2 + self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 7;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0.1;
    }else if(section > 0 && section < self.dataList.count + 1){
        return 80;
    }else{
        return 0.1;
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        
        return [UIView new];
    }else if(section > 0 && section < self.dataList.count + 1){
        HomeSectionView * headerView = [[HomeSectionView alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, 80)];
        if(self.selectIndx == section){
            
            [headerView upDataWithModel:@"" select:YES];
        }else{
            [headerView upDataWithModel:@"" select:NO];
        }
        return headerView;
    }else{
        
        return [UIView new];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            WFFourLabelCell * cell = [WFFourLabelCell cellWithTableView:tableView];
            [cell upLabelsFrameWithInsets:UIEdgeInsetsMake(14.5, 0, 14, 0) spacing:5.5];
            [cell upDataWithModel:@""];
            
            return cell;;
        }else if(indexPath.row == 1){
            WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView];
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(14, 25, 7.5, 25)];
            [cell.leftLabel setText:@"Cargo por servicio:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
            [cell.rightLabel setText:@"$ 900" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
            return cell;
        }else if(indexPath.row == 2){
            WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView];
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(14, 25, 7.5, 25)];
            [cell.leftLabel setText:@"IVA:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
            [cell.rightLabel setText:@"$ 900" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
            return cell;
        }else if(indexPath.row == 3){
            WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView];
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(14, 25, 7.5, 25)];
            [cell.leftLabel setText:@"Importe del recibo:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
            [cell.rightLabel setText:@"$ 900" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
            return cell;
        }else if(indexPath.row == 4){
            WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView];
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(14, 25, 7.5, 25)];
            [cell.leftLabel setText:@"Deuda de Reembolso:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
            [cell.rightLabel setText:@"$ 900" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
            return cell;
        }else if(indexPath.row == 5){
            WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView];
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(14, 25, 7.5, 25)];
            [cell.leftLabel setText:@"Tiempo de reembolso:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
            [cell.rightLabel setText:@"29/04/2023" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
            return cell;
        }else{
            WFLeftRightLabelCell * cell = [WFLeftRightLabelCell bottomLineCellWithTableView:tableView];
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(14, 25, 19.5, 25)];
            [cell.leftLabel setText:@"Número de productos:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
            cell.bottomLine.hidden = NO;
            [cell.rightLabel setText:@"3" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
            return cell;
        }
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, WF_ScreenHeight - WF_NavigationHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor  = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

-(NSMutableArray *)dataList{
    if(_dataList == nil){
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}


@end
