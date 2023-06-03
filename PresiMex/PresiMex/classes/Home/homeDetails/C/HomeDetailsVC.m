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
#import "WFLeftRightBtnCell.h"
#import "WFBtnCell.h"

@interface HomeDetailsVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataList;


@property (nonatomic, strong) UITableView *tableView; /**< 列表*/

@property (nonatomic, strong) UITableView *tableViewBottom; /**< 底部视图*/

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
    [self.tempView addSubview:self.tableViewBottom];
    self.navTitleLabel.text = @"Detalles de préstamo";
    
}


#pragma mark -- UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    if (tableView.tag == 0) {
        return 2 + self.dataList.count;
    } else {
        
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 0) {
        if(section == 0){
            return 7;
        }else{
            return 0;
        }
    } else {
        
        return 3;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (tableView.tag == 0) {
        if(section == 0){
            return 0.1;
        }else if(section > 0 && section < self.dataList.count + 1){
            return 80;
        }else{
            return 0.1;
        }
    } else {
        
        return 0.1;
    }
    
   
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 0) {
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
    } else {
        
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
    
    if (tableView.tag == 0) {
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
    } else {
        if (indexPath.row == 0) {
            WFLeftRightBtnCell * cell = [WFLeftRightBtnCell cellWithTableView:tableView];
            [cell upBtnsFrameWithEdgeInsets:UIEdgeInsetsMake(12.5, 15, 0, 15)];
            [cell.leftBtn setTitle:@"CLABE" forState:UIControlStateNormal];
            [cell.leftBtn setTitleColor:[UIColor jk_colorWithHexString:@"#1B1200"]  forState:UIControlStateNormal];
            cell.leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
            [cell.rightBtn setText:@"Modificar cuenta" TextColor:BColor_Hex(@"#FC7500", 1) Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
            return cell;
        } else if (indexPath.row == 1)  {
            WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView identifier:@"1"];
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(14, 15, 20, 15)];
            [cell.leftLabel setText:@"00000000000" TextColor:BColor_Hex(@"#7C7C7C", 1) Font:[UIFont systemFontOfSize:12]];
            [cell.rightLabel setText:@"BANK ABC" TextColor:BColor_Hex(@"#7C7C7C", 1) Font:[UIFont boldSystemFontOfSize:12]];
            return cell;
        }else{
            WFBtnCell * cell = [WFBtnCell cellWithTableView:tableView];
            [cell.btn setTitle:@"Confirmar" forState:UIControlStateNormal];
            cell.btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.btn addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth - 30, 50) withColors:@[(id)[UIColor jk_colorWithHexString:@"#FFB602"].CGColor,(id)[UIColor jk_colorWithHexString:@"#FC7500"].CGColor] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:13];
        
            [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(0, 15, 15, 15) height:50];
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
    
}

#pragma mark -- init
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, WF_ScreenHeight - WF_NavigationHeight - 155 - WF_BottomSafeAreaHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor  = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

- (UITableView *)tableViewBottom
{
    if (!_tableViewBottom) {
        _tableViewBottom = [[UITableView alloc] initWithFrame:CGRectMake(0, WF_ScreenHeight - WF_NavigationHeight - 155 - WF_BottomSafeAreaHeight, WF_ScreenWidth, 155 + WF_BottomSafeAreaHeight) style:UITableViewStyleGrouped];
        _tableViewBottom.tag = 1;
        _tableViewBottom.scrollEnabled = NO;
        _tableViewBottom.delegate = self;
        _tableViewBottom.dataSource = self;
        _tableViewBottom.backgroundColor  = [UIColor whiteColor];
        _tableViewBottom.tableFooterView = [[UIView alloc] init];
        _tableViewBottom.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableViewBottom.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableViewBottom jk_shadowWithColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1] offset:CGSizeMake(0,1) opacity:1 radius:5];
    }
    
    return _tableViewBottom;
}


-(NSMutableArray *)dataList{
    if(_dataList == nil){
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}


@end
