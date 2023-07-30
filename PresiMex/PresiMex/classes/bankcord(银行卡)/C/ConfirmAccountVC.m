//
//  ConfirmAccountVC.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/17.
//

#import "ConfirmAccountVC.h"
#import "bankcardCell.h"
#import "WFLeftRightBtnCell.h"
#import "PMAddBankViewController.h"
#import "PMAddBankViewController.h"
#import "BankConfrimAlert.h"

@interface ConfirmAccountVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/


@end

@implementation ConfirmAccountVC



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tempView addSubview:self.tableView];
    self.navTitleLabel.text = @"Confirmacion de cuen";
    
//    [self GETCouponUrl];
    
    if(!self.bankModel){
        [self GETBindUserAccount];
    }
    
    if (self.reLoan) {
        
        
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_account_info content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
    } else {
        
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_account_confirm content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
    }
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
    
    if (indexPath.row == 0) {
        
        bankcardCell * cell = [bankcardCell cellWithTableView:tableView];
        [cell updataWithModel:self.bankModel indx:indexPath.row];
        return cell;
    }else{

        WFLeftRightBtnCell * cell = [WFLeftRightBtnCell cellWithTableView:tableView];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(30, 32, 20, 32) height:50];
        [cell.leftBtn setTitle:@"Quedarse" forState:UIControlStateNormal];
        [cell.leftBtn setTitleColor:[UIColor jk_colorWithHexString:@"#CCCCCC"]  forState:UIControlStateNormal];
        cell.leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        cell.leftBtn.layer.cornerRadius = 13;
        cell.leftBtn.layer.masksToBounds = YES;
        cell.leftBtn.layer.borderWidth = 1;
        cell.leftBtn.layer.borderColor = BColor_Hex(@"#CCCCCC", 1).CGColor;
        
        
        [cell.rightBtn setText:@"Modificar" TextColor:BColor_Hex(@"#FFFFFF", 1) Font:[UIFont systemFontOfSize:13] forState:UIControlStateNormal];
        
        [cell.rightBtn addLinearGradientwithSize:CGSizeMake((WF_ScreenWidth - 79)/2, 50) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:13];
        
        [cell.leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(0));
            make.top.equalTo(@(0));
            make.bottom.equalTo(@(0));
            make.width.equalTo(@((WF_ScreenWidth - 79)/2));

        }];
        
        [cell.rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(0));
            make.top.equalTo(@(0));
            make.bottom.equalTo(@(0));
            make.left.equalTo(cell.leftBtn.mas_right).offset(11);
            make.width.equalTo(@((WF_ScreenWidth - 79)/2));
            

        }];
        
        WF_WEAKSELF(weakself);
        [cell setClickBtnBlock:^(NSInteger indx) {
            if (indx == 0) {
                if (weakself.reLoan) {
                    // 重新借款，弹出确认窗
                    [weakself showBankConfrimAlert];
                } else {
                    //返回
                    if(weakself.clickConfirmBlock){
                        weakself.clickConfirmBlock(weakself.bankModel);
                        
                        [weakself.navigationController popViewControllerAnimated:YES];
                    }
                    
                    if (self.reLoan) {
                        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq03_account_info_confirm content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
                        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
                    } else {
                        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq03_account_confirm_confirm content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
                        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
                    }
                    
                    
                }
            } else {
                PMAddBankViewController * VC = [[PMAddBankViewController alloc] init];
                VC.VCType = 1;
                VC.reLoan = self.reLoan;
                VC.orderModel = self.orderModel;
                WF_WEAKSELF(weakself);
                [VC setChangeBlock:^(bankcardModel * _Nonnull bankModel) {
                    weakself.bankModel = bankModel;
                    [weakself.tableView reloadData];
                }];
                [weakself.navigationController pushViewController:VC animated:YES];
                
                if (self.reLoan) {
                    PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq03_account_info_modify content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
                    [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
                }else{
                    PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq03_account_confirm_modify content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
                    [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
                }
                
            }
            
        }];
        return cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    
}

//确认借款弹出框
-(void)showBankConfrimAlert{
    BankConfrimAlert * alert = [[BankConfrimAlert alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth - 40, 396) withType:0] ;
    alert.bankModel = self.bankModel;
    alert.money = self.orderModel.barbie;
    
    WFCustomAlertView *  AlertView = [[WFCustomAlertView alloc] initWithContentView:alert];
    [AlertView show];
    WF_WEAKSELF(weakself);
    [alert setClickBtnBlock:^(NSInteger indx) {
        if (indx == 0) {
            //返回修改
            [AlertView dismiss];
        } else {
            //确认重新提交
            [weakself PostOderFailReset];
            [AlertView dismiss];
            
        }
    }];
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
//-(void)GETCouponUrl{
//    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
////    pars[@"eg"] = [NSString stringWithFormat:@"%ld",self.eg];
////    pars[@"patricia"] = @"100";
//    WF_WEAKSELF(weakself);
//    [PMBaseHttp get:GET_Coupon_Url parameters:pars success:^(id  _Nonnull responseObject) {
//        
//        if ([responseObject[@"retail"] intValue]==200) {
//            NSDictionary * shame = responseObject[@"shame"];
//            
//            
//        }else{
//            
//        }
//        
//        [weakself.tableView.mj_footer endRefreshing];
//        
//        
//    } failure:^(NSError * _Nonnull error) {
//        
//        [weakself.tableView.mj_footer endRefreshing];
//        
//    }];
//}


//获取用户当前绑定账户信息
-(void)GETBindUserAccount{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
  
    WF_WEAKSELF(weakself);
    [self show];
    [PMBaseHttp get:GET_Bind_User_Account parameters:pars success:^(id  _Nonnull responseObject) {
        [weakself dismiss];
        if ([responseObject[@"retail"] intValue]==200) {
            NSDictionary * shame = responseObject[@"shame"];
            
            bankcardModel * model = [bankcardModel mj_objectWithKeyValues:shame];
//
            weakself.bankModel = model;
            [weakself.tableView reloadData];
            
        }else{
            [weakself showTip:responseObject[@"entire"]];//（对）
            [weakself.tableView reloadData];
        }
        
        
        
    } failure:^(NSError * _Nonnull error) {
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        [weakself dismiss];
    }];
}



//12003 - 手工发起重新放款操作，后端将失败订单处理为待重新放款状态
-(void)PostOderFailReset{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
    pars[@"products"] = self.orderModel.products;
    WF_WEAKSELF(weakself);
    [self show];
    [PMBaseHttp post:Post_Oder_Fail_Reset parameters:pars success:^(id  _Nonnull responseObject) {
        [weakself dismiss];
        if ([responseObject[@"retail"] intValue]==200) {
            [weakself.navigationController popViewControllerAnimated:YES];
        }else{
            [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
    } failure:^(NSError * _Nonnull error) {
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        [weakself dismiss];
        
        
    }];
}

@end
