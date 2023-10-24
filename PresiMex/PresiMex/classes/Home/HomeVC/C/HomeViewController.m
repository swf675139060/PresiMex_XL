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
#import "HomeSectionView.h"
#import "WFBtnCell.h"
#import "WFImageCell.h"

#import "HomeDetailsVC.h"
#import "OrderVC.h"
#import "PMAuthModel.h"
#import "PMHomeModel.h"
#import "HomeNoAuthView.h"
#import "LoanWaitingAlert.h"
#import "LoanFailAlert.h"
#import "topLabelBottmBtnAlert.h"

#import "HomeDetailView.h"
#import "PMLoginViewController.h" //登录页面
#import "ConfirmAccountVC.h"
#import "PMCertificationCoreViewController.h"
#import "FLAnimatedImage.h"


@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView; /**< 列表*/

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *bgImageViewtop;

@property (nonatomic, strong) HomeNoAuthView *NoAuthView; /**< 列表*/


@property (nonatomic, strong) PMNotiView *notiView;

@property (nonatomic, assign) NSInteger selectIndx;// 点击的section
@property (nonatomic, assign) NSInteger changeValue;
@property (nonatomic,strong) PMAuthModel * authModel;//用户信息
@property (nonatomic,strong) PMHomeModel * homeModel;//产品信息

@property (nonatomic,strong) NSMutableArray * dataList;

@property (nonatomic,strong) HomeDetailView * detailView;//付款界面
@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectIndx = 0;
    self.navBarView.hidden = YES;
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.notiView];
    [self.view addSubview:self.bgImageViewtop];
    [self GETAPPVersionUpdate];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:@"dengLuChengGong"
                                               object:nil];
//        [self showTopLabelBottmBtnAlert:@"sdfasdfasdf"];
//    [self POSTCouponGetUrl];
//    [self showLoanWaitingAlertType:1];
//    [self showLoanFailAlert];
//    [self.notiView setNotList:@[@"123456789",@"09876543234567898765456"]];
//    [self.view addSubview:self.tableView];
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [self GETAppBanner];
    self.changeValue = 0;
    if([PMAccountTool isLogin]){
        //获取授信
        [self GETUserAuthInfo];
        
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_product content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
         [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        
    }else{
        
        [self.view addSubview:self.NoAuthView];
        [self.NoAuthView.tableView reloadData];
        [self.tableView removeFromSuperview];
        
        [self.NoAuthView addBgImageView];
    }
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
    
    if (self.homeModel.pledge.count) {
        return 2 + self.homeModel.pledge.count;
    } else {
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        if (self.homeModel.pledge.count) {
            return 6;
        } else {
            return 10;
        }
    }else if(section > 0 && section < self.homeModel.pledge.count+1){
        if(self.selectIndx == section){
            return 6;
        }else{
            return 0;
        }
    }else{
        
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0.1;
    }else if(section > 0 && section < self.homeModel.pledge.count + 1){
        return 80;
    }else{
        return 0.1;
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        
        return [UIView new];
    }else if(section > 0 && section < self.homeModel.pledge.count + 1){
        HomeSectionView * headerView = [[HomeSectionView alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, 80)];
        if(self.selectIndx == section){
            
            [headerView upDataWithModel:self.homeModel.pledge[section - 1] select:YES];
        }else{
            [headerView upDataWithModel:self.homeModel.pledge[section - 1] select:NO];
        }
        
        WF_WEAKSELF(weakself);
        [headerView whenTapped:^{
            if (weakself.selectIndx != section) {
                weakself.selectIndx = section;
            } else {
                weakself.selectIndx = 0;
            }
            [weakself.tableView reloadData];
            
            PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq03_product_detail content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
            [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        }];
        
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            WFLeftRightBtnCell * cell = [WFLeftRightBtnCell cellWithTableView:tableView ID:indexPath.row];
            [cell upBtnsFrameWithEdgeInsets:UIEdgeInsetsMake(15, 16, 13.5, 16)];
            [cell.leftBtn setTitle:@"Bienvenido a PresiMex" forState:UIControlStateNormal];
            [cell.leftBtn setTitleColor:[UIColor jk_colorWithHexString:@"#1B1200"]  forState:UIControlStateNormal];
            cell.leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
            [cell.rightBtn setImage:[UIImage imageNamed:@"kefu"] forState:UIControlStateNormal];
            
            WF_WEAKSELF(weakself);
            cell.clickBtnBlock = ^(NSInteger indx) {
                if (indx == 1) {
                    [weakself showKeFuAlert];
                }
            };
            return cell;
        }else if (indexPath.row == 1){
            WFLabelCell * cell  = [WFLabelCell cornerCellWithTableView:tableView];
            cell.label.textAlignment = NSTextAlignmentLeft;
            [cell.label setText:@"Monto total de préstamos" TextColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:13]];
            [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15) maskedCorners: kCALayerMinXMinYCorner | kCALayerMinXMinYCorner cornerRadius:15];
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 15, 5, 15)];
            [cell.BGView addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth-30, 33) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner cornerRadius:15];
            
            
            return cell;
            
            
        }else if (indexPath.row == 2){
            WFLabelCell * cell  = [WFLabelCell cellWithTableView:tableView identifier:@"22"];
            cell.label.textAlignment = NSTextAlignmentCenter;
            
            NSNumberFormatter *moneyFormatter = [[NSNumberFormatter alloc] init];
            moneyFormatter.positiveFormat = @"###,##0";
            NSString *formatString = [moneyFormatter stringFromNumber:@(self.changeValue)];
            [cell.label setText:formatString TextColor:[UIColor whiteColor] Font:[UIFont boldSystemFontOfSize:25]];
//            [cell.label setText:[NSString stringWithFormat:@"%ld",self.changeValue] TextColor:[UIColor whiteColor] Font:[UIFont boldSystemFontOfSize:25]];
            
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(2, 15, 5, 15)];
            
            [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
            [cell.BGView addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth-30, 37) maskedCorners:kCALayerMinXMinYCorner cornerRadius:0.1];
            
            
            return cell;
            
            
        }else if (indexPath.row == 3){
            WFSliderCell * cell  = [WFSliderCell cellWithTableView:tableView];
            
            cell.social = [self.authModel.social integerValue];
            if(self.homeModel){
                //剩余额度大于最小额度
                if([self.authModel.monster doubleValue] >= [self.authModel.clear doubleValue]){
                    cell.slider.userInteractionEnabled = YES;
//                    cell.slider.value = [self.authModel.monster doubleValue];
                    cell.slider.maximumValue = [self.authModel.monster doubleValue];
                    cell.slider.minimumValue = [self.authModel.clear doubleValue];
                }else{
                    cell.slider.userInteractionEnabled = NO;
                }
                
            }else{
                cell.slider.userInteractionEnabled = NO;
            }
            cell.slider.value = self.changeValue;
            [cell.slider trackRectForBounds:CGRectMake(0, 0, WF_ScreenWidth - 30, 8)];
            [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15) height:25];
            [cell upSliderFrameWithInsets:UIEdgeInsetsMake(8, 15, 0, 15) height:16];
            [cell.BGView addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth-30, 25) maskedCorners:kCALayerMinXMinYCorner cornerRadius:0.1];
//            cell.BGView.backgroundColor = [UIColor redColor];
            WF_WEAKSELF(weakself);
            cell.sliderChangeBlock = ^(NSInteger number) {
                weakself.changeValue = number;
                
                NSIndexPath * IndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
                [weakself.tableView reloadRowsAtIndexPaths:@[IndexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
            cell.sliderEndBlock = ^(NSInteger number) {
                weakself.changeValue = number;
                
                NSIndexPath * IndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
                [weakself.tableView reloadRowsAtIndexPaths:@[IndexPath] withRowAnimation:UITableViewRowAnimationNone];
                [weakself GETProductList];
                
                PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_product_amount_slide content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
                [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
            };
            return cell;
            
            
        }else if (indexPath.row == 4){
            WFThreeBtnCell * cell = [WFThreeBtnCell cellWithTableView:tableView];
            [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15) height:24.5];
            [cell upBtnsFrameWithInsets:UIEdgeInsetsMake(10, 15, 0, 15)];
            [cell.BGView addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth-30, 25) maskedCorners:kCALayerMinXMinYCorner cornerRadius:0.1];
            
//            [cell.centerBtn setText:@"Plazo de validez del límite" TextColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
            
            [cell.centerBtn setText:@"" TextColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
           
            
            if([self.authModel.monster doubleValue] >= [self.authModel.clear doubleValue]){
                
                [cell.leftBtn setText:self.authModel.biodiversity TextColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
                [cell.rightBtn setText:self.authModel.researcher TextColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
            }else{
                
                [cell.leftBtn setText:@"0" TextColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
                [cell.rightBtn setText:@"0" TextColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
                
            }
            
            
            
            return cell;
            
        }else if (indexPath.row == 5){
            WFLabelCell * cell  = [WFLabelCell cellWithTableView:tableView];
            cell.label.textAlignment = NSTextAlignmentCenter;
//            [cell.label setText:@"2d, 12h, 30m,12s" TextColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:11]];
            [cell.label setText:@"" TextColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:11]];
            
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(5, 15, 5, 15)];
            
            [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 15, 20, 15)];
            [cell.BGView addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth-30, 20) maskedCorners:kCALayerMinXMinYCorner cornerRadius:0.1];
            return cell;
        }else if (indexPath.row == 6){
            WFImageCell * cell = [WFImageCell cellWithTableView:tableView];
            cell.imgV.image = [UIImage imageNamed:@"beiju"];
            cell.imgV.backgroundColor = [UIColor clearColor];
            CGFloat imgVWidth = 132;
            [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(66, (WF_ScreenWidth - imgVWidth)/2, 19, (WF_ScreenWidth - imgVWidth)/2) height:99];
            return cell;
        }else if (indexPath.row == 7){
            WFLabelCell * cell  = [WFLabelCell cellWithTableView:tableView];
            cell.label.textAlignment = NSTextAlignmentCenter;
            [cell.label setText:@"Actualmente no existen productos que coincidan." TextColor:BColor_Hex(@"#7C7C7C", 1) Font:[UIFont systemFontOfSize:13]];
            
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(15.5, 66, 20, 66)];
            [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
            [cell.BGView deletaLinearGradient];
            
            return cell;
        } else if (indexPath.row == 8){
            WFBtnCell * cell = [WFBtnCell cellWithTableView:tableView];
            [cell.btn setTitle:@"Ir a Mi Factura" forState:UIControlStateNormal];
            cell.btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            WF_WEAKSELF(weakself);
            [cell setClickBtnBlock:^{
                OrderVC *vc = [[OrderVC alloc] init];
                [weakself.navigationController pushViewController:vc animated:YES];
            }];
            [cell.btn addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth - 30, 50) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:13];
            [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(10, 15, 15, 15) height:50];
            return cell;
        }else{
            WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
            cell.label.textAlignment = NSTextAlignmentCenter;
            cell.label.textColor = [UIColor jk_colorWithHexString:@"#7C7C7C"];
            cell.label.font = [UIFont systemFontOfSize:12];
            NSString * String = @"Puede ir a Mi Factura para ver sus pedidos.";
            NSString * subString0 = @"Mi Factura";
          
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:String];
            [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName: BColor_Hex(@"#1B1200", 1)} range:[String rangeOfString:subString0]];
            cell.label.attributedText = attributedString;
            [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 15, 10, 15)];
            [cell.BGView deletaLinearGradient];
            return cell;

        }
        
        
        
    }else if (indexPath.section > 0 && indexPath.section < self.homeModel.pledge.count + 1){
        
        WFLeftRightBtnCell * cell = [WFLeftRightBtnCell cellWithTableView:tableView];
        cell.BGView.backgroundColor = [UIColor jk_colorWithHexString:@"#F7F7F7"];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15) height:27.5];
        [cell upBtnsFrameWithEdgeInsets:UIEdgeInsetsMake(6.5, 61, 6.5, 10)];
        
        [cell.leftBtn setText:@"" TextColor:BColor_Hex(@"#666666", 1) Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
        [cell.rightBtn setText:@"" TextColor:BColor_Hex(@"#666666", 1) Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
        
        PMHomeProductModel * productModel = self.homeModel.pledge[indexPath.section-1];
        if(indexPath.row == 0){
            [cell.leftBtn setTitle:@"Producto:" forState:UIControlStateNormal];
            [cell.rightBtn setTitle:productModel.nu forState:UIControlStateNormal];
        }else if (indexPath.row == 1){
            
            [cell.leftBtn setTitle:@"Monto del préstamo:" forState:UIControlStateNormal];
            [cell.rightBtn setTitle:productModel.readers forState:UIControlStateNormal];
        }else if (indexPath.row == 2){
            
            [cell.leftBtn setTitle:@"Cargo por servicio:" forState:UIControlStateNormal];
            [cell.rightBtn setTitle:productModel.trademark forState:UIControlStateNormal];
        }else if (indexPath.row == 3){
            
            [cell.leftBtn setTitle:@"IVA:" forState:UIControlStateNormal];
            [cell.rightBtn setTitle:productModel.see forState:UIControlStateNormal];
        }else if (indexPath.row == 4){
            
            [cell.leftBtn setTitle:@"Deuda de Reembolso:" forState:UIControlStateNormal];
            [cell.rightBtn setTitle:productModel.tt forState:UIControlStateNormal];
        }else if (indexPath.row == 5){
            
            [cell.leftBtn setTitle:@"Tiempo de reembolso:" forState:UIControlStateNormal];
            [cell.rightBtn setTitle:productModel.Short forState:UIControlStateNormal];
        }
        return cell;
    }else{
        if (indexPath.row == 0) {
            WFBtnCell * cell = [WFBtnCell cellWithTableView:tableView];
            [cell.btn setTitle:@"Presentar la solicitud" forState:UIControlStateNormal];
            cell.btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            WF_WEAKSELF(weakself);
            [cell setClickBtnBlock:^{
//                weakself.view.bounds
                weakself.detailView = [[HomeDetailView alloc] initWithFrame: CGRectMake(0, 0, WF_ScreenWidth, WF_ScreenHeight - WF_TabBarHeight)];
                weakself.detailView.homeModel = self.homeModel;
//                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                [self.view addSubview:weakself.detailView ];
                // 点击修改银行卡
                [weakself.detailView  setClickBankBlock:^(bankcardModel * _Nonnull bankModel) {
                    
                    ConfirmAccountVC * VC = [[ConfirmAccountVC alloc] init];
                    VC.bankModel = bankModel;
                    
                    VC.clickConfirmBlock = ^(bankcardModel * _Nonnull bankModel) {
                        weakself.detailView.bankModel = bankModel;
                        [weakself.detailView.tableView reloadData];
                    };
                    [weakself.navigationController pushViewController:VC animated:YES];
                }];
                // 提交借款
                [weakself.detailView setClickNextBlock:^(BOOL success) {
                    weakself.changeValue = 0;
                    [weakself POSTLoanApply];
                    
                    PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq03_product_apply_submit content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
                    [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
                }];
                
                
                
            }];
            [cell.btn addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth - 30, 50) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:13];
        
            [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(10, 15, 15, 15) height:50];
            return cell;
        }else{
            WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
            cell.label.textAlignment = NSTextAlignmentCenter;
            cell.label.textColor = [UIColor jk_colorWithHexString:@"#999999"];
            cell.label.font = [UIFont systemFontOfSize:12];
            NSString * String = @"El monto real está determinado por la suma del\n\"Monto total de préstamos\"";
            
            NSString * subString0 = @"Monto total de préstamos";
          
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:String];
            [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName: BColor_Hex(@"#1B1200", 1)} range:[String rangeOfString:subString0]];
            cell.label.attributedText = attributedString;
            [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 15, 10, 15)];
            [cell.BGView deletaLinearGradient];
            return cell;

        }
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



#pragma mark -- init
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.notiView.swf_bottom, WF_ScreenWidth, WF_ScreenHeight - self.notiView.swf_bottom - WF_TabBarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor  = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.backgroundView = self.bgImageView;
    }
    
    return _tableView;
}

-(HomeNoAuthView *)NoAuthView{
    
    if (!_NoAuthView) {
        _NoAuthView = [[HomeNoAuthView alloc] initWithFrame:CGRectMake(0, self.notiView.swf_bottom, WF_ScreenWidth, WF_ScreenHeight - self.notiView.swf_bottom - WF_TabBarHeight)];
        WF_WEAKSELF(weakself);
        _NoAuthView.clickBock = ^{
            
            if([PMAccountTool isLogin]){
                
                [weakself pushCerVc];
            }else{
                
                PMLoginViewController*Vc=[PMLoginViewController new];
                [weakself.navigationController pushViewController:Vc animated:YES];
            }
        };
    }
    
    return _NoAuthView;
}

-(PMNotiView *)notiView{
    if(_notiView == nil){
        _notiView = [[PMNotiView alloc] initWithFrame:CGRectMake(0, WF_StatusBarHeight + 15, WF_ScreenWidth, 33)];
    }
    return _notiView;
}


-(UIImageView *)bgImageViewtop{
    if (_bgImageViewtop == nil) {
        _bgImageViewtop = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, WF_StatusBarHeight + 15)];
//        _bgImageViewtop.backgroundColor = [UIColor yellowColor];
        _bgImageViewtop.image = [UIImage imageNamed:@"homeBG"];
        _bgImageViewtop.contentMode = UIViewContentModeScaleToFill;
    }
    return _bgImageViewtop;
}

-(UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] init];
//        _bgImageView.backgroundColor = [UIColor yellowColor];
        _bgImageView.image = [UIImage imageNamed:@"homeBG"];
        _bgImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _bgImageView;
}

-(void)showLoanWaitingAlertType:(NSInteger)type{
    LoanWaitingAlert * alert = [[LoanWaitingAlert alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth - 60, 147 + 20 + 190) withType:type] ;
    
    WFCustomAlertView *  AlertView = [[WFCustomAlertView alloc] initWithContentView:alert];
    [AlertView setClickBGDismiss:NO];
    [AlertView show];
    WF_WEAKSELF(weakself);
    [alert setClickBtnBlock:^{
        [AlertView dismiss];
        
        [weakself GETUserAuthInfo];
        
        
        if (alert.storeCount == 5) {
            [[PMConfigManager sharedInstance] gotoStore];
            
            
            PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq03_loan_processing_to_score_5star content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
            [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        } else {
            //
            
            OrderVC *vc = [[OrderVC alloc] init];
            [weakself.navigationController pushViewController:vc animated:YES];
            
            PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq03_loan_processing_to_score_no5star content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
            [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
            
        }
    }];
    [alert setClickCloseBtnBlock:^{
        [weakself GETUserAuthInfo];
        [AlertView dismiss];
    }];
    
    
    
    PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_loan_processing content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
    [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
}

//借款失败
-(void)showLoanFailAlert{
    LoanFailAlert * alert = [[LoanFailAlert alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth - 60, 147 + 20 + 190) withType:0] ;
    
    WFCustomAlertView *  AlertView = [[WFCustomAlertView alloc] initWithContentView:alert];
    [AlertView show];
    [alert setClickBtnBlock:^{
        [AlertView dismiss];
    }];
}

//通用错误弹框
-(void)showTopLabelBottmBtnAlert:(NSString *)content{
    if ([PMConfigManager sharedInstance].showTost) {
        return;
    }
    
    [PMConfigManager sharedInstance].showTost = YES;
    
    topLabelBottmBtnAlert * alert = [[topLabelBottmBtnAlert alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth - 60,190) withConttent:content btnTitel:@"OK"] ;
    
    WFCustomAlertView *  AlertView = [[WFCustomAlertView alloc] initWithContentView:alert];
    [AlertView show];
    WF_WEAKSELF(weakself);
    [alert setClickBtnBlock:^{
        
        [AlertView dismiss];
        OrderVC *vc = [[OrderVC alloc] init];
        [weakself.navigationController pushViewController:vc animated:YES];
    }];
}



#pragma mark --网络请求
//轮播信息
-(void)GETAppBanner{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
  
    WF_WEAKSELF(weakself);
    [PMBaseHttp get:GET_App_Banner parameters:pars success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"retail"] intValue]==200) {
            [weakself.notiView setNotList:responseObject[@"shame"][@"trackback"]];
        }else{
            [weakself.notiView setNotList:@[]];
        }
    } failure:^(NSError * _Nonnull error) {
        [weakself.notiView setNotList:@[]];
    }];
}


//获取用户授信信息
-(void)GETUserAuthInfo{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
  
    WF_WEAKSELF(weakself);
    [PMBaseHttp get:GET_User_Auth_Info parameters:pars success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"retail"] intValue]==200) {
            NSDictionary * shame = responseObject[@"shame"];
            
            PMAuthModel * model = [PMAuthModel mj_objectWithKeyValues:shame];
            
            weakself.authModel = model;
            if (weakself.changeValue == 0) {
                weakself.changeValue = [model.monster integerValue];
            }
            if (weakself.changeValue > [model.monster integerValue]){
                weakself.changeValue  = [model.monster integerValue];
            }
            [weakself upDataSubview];
            
            if ([weakself.authModel.shop integerValue] == 20) {
                // 授信通过获取订单状态
                [self GetUserOderStatus];
            }
            
        }else{
            
            [weakself showTip:responseObject[@"entire"]];//（对）
            [weakself upDataSubview];
            weakself.authModel = nil;
            [weakself.tableView reloadData];
           
        }
        
    } failure:^(NSError * _Nonnull error) {
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        [weakself upDataSubview];
    }];
}


//12001 - 用户当前订单概况
-(void)GetUserOderStatus{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
  
    WF_WEAKSELF(weakself);
    [PMBaseHttp get:Get_User_Oder_Status parameters:pars success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"retail"] intValue]==200) {
            NSDictionary * shame = responseObject[@"shame"];
            // 订单状态 订单状态 0-待审核 10-审核中 20-审核通过 40-放款中 50-待还款 60-放款失败 70-已还款 80-展期中 90-已逾期 100取消贷款
            
            if(shame){
                NSInteger  lexus = [shame[@"lexus"] integerValue];
                
                if(lexus == 0 || lexus == 10){
                    //处理中弹窗
                    [weakself getConfigModel];
                    
                }else if (lexus == 60){
                    //放款失败
                    [weakself showLoanFailAlert];
                }
            }
        }else if ([responseObject[@"retail"] intValue] >= 300 && [responseObject[@"retail"] intValue] < 400) {
           // 显示弹框
            [weakself showTopLabelBottmBtnAlert:responseObject[@"entire"]];
            
           
        }else{
            [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
    } failure:^(NSError * _Nonnull error) {
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
    }];
}

//获取是否显示引导评价-》后弹窗
-(void)getConfigModel{
    PMConfigManager * manager = [PMConfigManager sharedInstance];
    WF_WEAKSELF(weakself);
    [manager getConfigModelBlock:^(PMConfigModel * _Nonnull model) {
        if ([model.medline boolValue] == YES){
            //显示引导页（审核中）
            [weakself showLoanWaitingAlertType:1];
        }else{
            [weakself showLoanWaitingAlertType:0];
            //不显示引导页（审核中）
        }
    }];
    

}



-(void)upDataSubview{
    
    if ([self.authModel.shop integerValue] == 20) {
        if (!self.tableView.superview) {
            [self.view addSubview:self.tableView];
        }
        [self.NoAuthView removeFromSuperview];
        [self.tableView reloadData];
        [self GETProductList];
        
        UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        [self.bgImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.view);
            make.bottom.equalTo(cell.contentView);
            
        }];
    } else {
        if (!self.NoAuthView.superview) {
            [self.view addSubview:self.NoAuthView];
            
        }
        [self.NoAuthView.tableView reloadData];
        [self.tableView removeFromSuperview];
        
        [self.NoAuthView addBgImageView];
    }
 

}


//获取产品列表
-(void)GETProductList{
//    self.changeValue = 3000;
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
  
    WF_WEAKSELF(weakself);
    [PMBaseHttp get:[NSString stringWithFormat:GET_Product_List,self.changeValue] parameters:pars success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"retail"] intValue]==200) {
            NSDictionary * shame = responseObject[@"shame"];
            
            PMHomeModel * model = [PMHomeModel mj_objectWithKeyValues:shame];
            
            weakself.homeModel = model;
            [weakself.tableView reloadData];
            
        }else{
            
//            [SLFToast showWithContent:responseObject[@"entire"] afterDelay:2];
            weakself.homeModel = nil;
            [weakself.tableView reloadData];
            [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
    } failure:^(NSError * _Nonnull error) {
        [weakself dismiss];
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        
    }];
}


//获取升级版本
-(void)GETAPPVersionUpdate{
//    self.changeValu、 = 3000;
  
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
  
    WF_WEAKSELF(weakself);
    [PMBaseHttp get:GET_APP_Version_Update parameters:pars success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"retail"] intValue]==200) {
            NSDictionary * shame = responseObject[@"shame"];
            [[NSUserDefaults standardUserDefaults] setObject:shame forKey:@"diving"];
            
            NSInteger diving = [shame[@"diving"] integerValue];
            
            NSString * content = shame[@"limitation"];
            
            [weakself showAPPUpdateAlert:content diving:diving];
            
//
        }
        
    } failure:^(NSError * _Nonnull error) {
        NSDictionary * shame = [[NSUserDefaults standardUserDefaults] objectForKey:@"diving"];
        if (shame) {
            
            NSInteger diving = [shame[@"diving"] integerValue];
            
            NSString * content = shame[@"limitation"];
            [weakself showAPPUpdateAlert:content diving:diving];
        }
        
        
    }];
}


//app升级弹窗
-(void)showAPPUpdateAlert:(NSString *)content diving:(NSInteger )diving{
    if (diving == 10) {
        return;
    }
    topLabelBottmBtnAlert * alert = [[topLabelBottmBtnAlert alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth - 60,190) withConttent:content btnTitel:@"OK"] ;
    [alert setOPTtype];
    
    WFCustomAlertView *  AlertView = [[WFCustomAlertView alloc] initWithContentView:alert];
    [AlertView show];
    [alert setClickBtnBlock:^{
        if (diving == 20) {
            [AlertView dismiss];
        } else {
            [[PMConfigManager sharedInstance] openAppStoreForAppWithID:@""];
        }
    }];
}

//24002 借款申请
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
    [self show];
    [PMBaseHttp postJson:POST_Loan_Apply parameters:pars success:^(id  _Nonnull responseObject) {

        [weakself dismiss];
        if ([responseObject[@"retail"] intValue]==200) {
//            NSDictionary * shame = responseObject[@"shame"];

//            [weakself GetUserOderStatus];
            [weakself getConfigModel];
            

        }else{
            [weakself showLoanFailAlert];
//            [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
    } failure:^(NSError * _Nonnull error) {
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        [weakself dismiss];
        
    }];
}

// 20002- 用户认证完成领取优惠券
//-(void)POSTCouponGetUrl{
//
//NSMutableDictionary *pars1=[NSMutableDictionary dictionary];
//
//[self show];
//WF_WEAKSELF(weakself);
//[PMBaseHttp postJson:POST_Coupon_Get_Url parameters:pars1 success:^(id  _Nonnull responseObject) {
//    [weakself dismiss];
//    if ([responseObject[@"retail"] intValue]==200) {
//        NSLog(@"获取优惠卷成功");
//    }else{
//    }
//
//} failure:^(NSError * _Nonnull error) {
//    [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
//    [weakself dismiss];
//
//}];
//
//
//}


-(NSMutableArray *)dataList{
    if(_dataList == nil){
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}
//认证中心
-(void)pushCerVc{
    PMCertificationCoreViewController*vc=[PMCertificationCoreViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
// 实现通知处理方法
- (void)handleNotification:(NSNotification *)notification {
    // 处理通知
    [self sutupAlertView];
}
//登陆成功显示用户权限提示
-(void)sutupAlertView{

    weakify(self);
   AccesoPermisosView * BottomView = [AccesoPermisosView new];
   
    SLFCommentsPopView * popView = [SLFCommentsPopView commentsPopViewWithFrame:CGRectMake(0, 0, WF_ScreenWidth, WF_ScreenHeight) contentView:BottomView contentViewNeedScroView:NO];
    [popView showWithTitileStr:@""];
    [popView clickBGHiden:NO];
    
    BottomView.selectBlock = ^{
        strongify(self);
        [popView dismiss];
        [self showALLAuthor];
    };
}

-(void)showALLAuthor{
    
    dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW, 1 *NSEC_PER_SEC); //设置时间2秒
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
//        [PrivateInfo requestContactAuthor];
        AppDelegate * delegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        [delegate setUpFirebaseConfigure:^(BOOL status) {
            //照片
            [PrivateInfo requestPhotoAuthor:^(PHAuthorizationStatus status) {
                //相机
                [PrivateInfo requestMediaStatusAuthor:^(BOOL status) {
                    //IDFA
                    [PrivateInfo requestIDFA:^(BOOL status) {
                        //登陆Dev
                        
                        dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW, 1 *NSEC_PER_SEC); //设置时间2秒
                        dispatch_after(time, dispatch_get_main_queue(), ^{
                            
                            PMDeviceModel * model =[PMDeviceModel sharedInstance];

                            PMLocationManager * LocationManager  = [PMLocationManager sharedInstance];
                            LocationManager.haveSend = NO;
                            __weak typeof(model) weakModel = model;
                            [LocationManager creatShowAlert:YES LocationBlock:^(BOOL isLocation) {
                                    [weakModel GetDate];
                                    [[PMDotManager sharedInstance] POSTDotDevType:30 value:weakModel];
                                
                            }];
                        });
                    }];
                }];
            }];
        }];
        
        
        
           
        
        

     });
    
}





@end
