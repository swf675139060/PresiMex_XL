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
#import "PMAuthModel.h"
#import "bankcardModel.h"
#import "ConfirmAccountVC.h"

@interface HomeDetailsVC ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView; /**< 列表*/

@property (nonatomic, strong) UITableView *tableViewBottom; /**< 底部视图*/

@property (nonatomic, assign) NSInteger selectIndx;// 点击的section

@property (nonatomic, strong) bankcardModel * bankModel;// 点击的section



@end

@implementation HomeDetailsVC



- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.homeModel == nil) {
        [self GETUserAuthInfo];
    }
    
    
    [self.tempView addSubview:self.tableView];
    [self.tempView addSubview:self.tableViewBottom];
    self.navTitleLabel.text = @"Detalles de préstamo";
    
    [self GETBindUserAccount];
    
}


#pragma mark -- UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    if (tableView.tag == 0) {
        return 1 + self.homeModel.pledge.count;
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
        }else if(section > 0 && section < self.homeModel.pledge.count + 1){
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
        }else if(section > 0 && section < self.homeModel.pledge.count + 1){
            HomeSectionView * headerView = [[HomeSectionView alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, 80)];
            if(self.selectIndx == section){
                
                [headerView upDataWithModel:self.homeModel.pledge[section -1] select:YES];
            }else{
                [headerView upDataWithModel:self.homeModel.pledge[section -1] select:NO];
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
                [cell.label1 setText:@"Monto de préstamos" TextColor:BColor_Hex(@"#999999", 1) Font:[UIFont systemFontOfSize:12]];
                [cell.label2 setText:@"Plazo de préstamo" TextColor:BColor_Hex(@"#999999", 1) Font:[UIFont systemFontOfSize:12]];
                [cell.label3 setText:self.homeModel.starsmerchant.years TextColor:BColor_Hex(@"#1B1200", 1) Font:[UIFont boldSystemFontOfSize:20]];
                [cell.label4 setText:[NSString stringWithFormat:@"%@días",self.homeModel.starsmerchant.caused] TextColor:BColor_Hex(@"#1B1200", 1) Font:[UIFont boldSystemFontOfSize:20]];
                
                return cell;;
            }else if(indexPath.row == 1){
                WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView];
                [cell upLabelFrameWithInsets:UIEdgeInsetsMake(14, 25, 7.5, 25)];
                [cell.leftLabel setText:@"Cargo por servicio:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
                [cell.rightLabel setText:self.homeModel.starsmerchant.comparing TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
                return cell;
            }else if(indexPath.row == 2){
                WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView];
                [cell upLabelFrameWithInsets:UIEdgeInsetsMake(14, 25, 7.5, 25)];
                [cell.leftLabel setText:@"IVA:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
                [cell.rightLabel setText:self.homeModel.starsmerchant.military TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
                return cell;
            }else if(indexPath.row == 3){
                WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView];
                [cell upLabelFrameWithInsets:UIEdgeInsetsMake(14, 25, 7.5, 25)];
                [cell.leftLabel setText:@"Importe del recibo:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
                [cell.rightLabel setText:self.homeModel.starsmerchant.adam TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
                return cell;
            }else if(indexPath.row == 4){
                WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView];
                [cell upLabelFrameWithInsets:UIEdgeInsetsMake(14, 25, 7.5, 25)];
                [cell.leftLabel setText:@"Deuda de Reembolso:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
                [cell.rightLabel setText:self.homeModel.starsmerchant.equality TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
                return cell;
            }else if(indexPath.row == 5){
                WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView];
                [cell upLabelFrameWithInsets:UIEdgeInsetsMake(14, 25, 7.5, 25)];
                [cell.leftLabel setText:@"Tiempo de reembolso:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
                [cell.rightLabel setText:self.homeModel.starsmerchant.Short TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
                return cell;
            }else{
                WFLeftRightLabelCell * cell = [WFLeftRightLabelCell bottomLineCellWithTableView:tableView];
                [cell upLabelFrameWithInsets:UIEdgeInsetsMake(14, 25, 19.5, 25)];
                [cell.leftLabel setText:@"Número de productos:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
                cell.bottomLine.hidden = NO;
                [cell.rightLabel setText:self.homeModel.starsmerchant.apparatus TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
                return cell;
            }
        }
    } else {
        if (indexPath.row == 0) {
            WFLeftRightBtnCell * cell = [WFLeftRightBtnCell cellWithTableView:tableView];
            [cell upBtnsFrameWithEdgeInsets:UIEdgeInsetsMake(12.5, 15, 0, 15)];
            if(self.bankModel){
                if ([self.bankModel.diameter integerValue] == 1) {
                    [cell.leftBtn setTitle:@"BANK" forState:UIControlStateNormal];
                } else {
                    [cell.leftBtn setTitle:@"CLABE" forState:UIControlStateNormal];
                }
            }
            
            [cell.leftBtn setTitleColor:[UIColor jk_colorWithHexString:@"#1B1200"]  forState:UIControlStateNormal];
            cell.leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
            [cell.rightBtn setText:@"Modificar cuenta" TextColor:BColor_Hex(@"#FC7500", 1) Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
            WF_WEAKSELF(weakself);
            [cell setClickBtnBlock:^(NSInteger indx) {
                if (indx == 1) {
                    ConfirmAccountVC * VC = [[ConfirmAccountVC alloc] init];
                    VC.bankModel = weakself.bankModel;
                    [weakself.navigationController pushViewController:VC animated:YES];
                }
            }];
            
            return cell;
        } else if (indexPath.row == 1)  {
            WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView identifier:@"1"];
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(14, 15, 20, 15)];
            if(self.bankModel){
                
                [cell.leftLabel setText:self.bankModel.diploma TextColor:BColor_Hex(@"#7C7C7C", 1) Font:[UIFont systemFontOfSize:12]];
                [cell.rightLabel setText:[NSString stringWithFormat:@"BANK %@",self.bankModel.marshall] TextColor:BColor_Hex(@"#7C7C7C", 1) Font:[UIFont boldSystemFontOfSize:12]];
            }
            return cell;
        }else{
            WFBtnCell * cell = [WFBtnCell cellWithTableView:tableView];
            [cell.btn setTitle:@"Confirmar" forState:UIControlStateNormal];
            cell.btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            WF_WEAKSELF(weakself);
            [cell setClickBtnBlock:^{
                [weakself POSTLoanApply];
            }];
            
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


//获取用户当前绑定账户信息
-(void)GETBindUserAccount{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
  
    WF_WEAKSELF(weakself);
    [PMBaseHttp get:GET_Bind_User_Account parameters:pars success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"retail"] intValue]==200) {
            NSDictionary * shame = responseObject[@"shame"];
            
            bankcardModel * model = [bankcardModel mj_objectWithKeyValues:shame];
//
            weakself.bankModel = model;
            [weakself.tableViewBottom reloadData];
            
        }else{
            [weakself.tableViewBottom reloadData];
        }
        
        
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

//借款申请
-(void)POSTLoanApply{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
  
    pars[@"detailed"] = self.homeModel.building;
    
    NSMutableArray * duringArr = [NSMutableArray array];
    for (PMHomeProductModel * model in self.homeModel.pledge) {
        
        NSMutableDictionary * duringDic = [NSMutableDictionary dictionary];
        duringDic[@"demanding"] = model.demanding;
        duringDic[@"madison"] = model.flip;
        [duringArr addObject:duringDic];
    }
    pars[@"during"] = duringArr;
    
    WF_WEAKSELF(weakself);
    [PMBaseHttp postJson:POST_Loan_Apply parameters:pars success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"retail"] intValue]==200) {
            NSDictionary * shame = responseObject[@"shame"];
            
            
        }else{
        }
        
        
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}



//获取用户授信信息
-(void)GETUserAuthInfo{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
  
    [self.view show];
    WF_WEAKSELF(weakself);
    [PMBaseHttp get:GET_User_Auth_Info parameters:pars success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"retail"] intValue]==200) {
            NSDictionary * shame = responseObject[@"shame"];
            
            PMAuthModel * model = [PMAuthModel mj_objectWithKeyValues:shame];
            [weakself GETProductList:[model.monster integerValue]];
            
        }else{
            
            [weakself.view dismiss];
        }
        
    } failure:^(NSError * _Nonnull error) {
        
        [weakself.view dismiss];
    }];
}


//获取产品列表
-(void)GETProductList:(NSInteger )changeValue{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
  
    WF_WEAKSELF(weakself);
    [PMBaseHttp get:[NSString stringWithFormat:GET_Product_List,changeValue] parameters:pars success:^(id  _Nonnull responseObject) {
        
        [weakself.view dismiss];
        if ([responseObject[@"retail"] intValue]==200) {
            NSDictionary * shame = responseObject[@"shame"];
            
            PMHomeModel * model = [PMHomeModel mj_objectWithKeyValues:shame];
            
            weakself.homeModel = model;
            [weakself.tableView reloadData];
            
        }else{
            weakself.homeModel = nil;
            [weakself.tableView reloadData];
        }
        
        
        
    } failure:^(NSError * _Nonnull error) {
        
        [weakself.view dismiss];
    }];
}


@end
