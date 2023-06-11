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

#import "PMCertificationCoreViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView; /**< 列表*/
@property (nonatomic, strong) HomeNoAuthView *NoAuthView; /**< 列表*/


@property (nonatomic, strong) PMNotiView *notiView;

@property (nonatomic, assign) NSInteger selectIndx;// 点击的section
@property (nonatomic, assign) NSInteger changeValue;
@property (nonatomic,strong) PMAuthModel * authModel;//用户信息
@property (nonatomic,strong) PMHomeModel * homeModel;//产品信息

@property (nonatomic,strong) NSMutableArray * dataList;
@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectIndx = 0;
    self.navBarView.hidden = YES;
    [self.view addSubview:self.notiView];
    [self.notiView setNotList:@[@"123456789",@"09876543234567898765456"]];
//    [self.view addSubview:self.tableView];
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [self GETAppBanner];
    
    if([PMAccountTool isLogin]){
        [self GETUserAuthInfo];
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
            WFLeftRightBtnCell * cell = [WFLeftRightBtnCell cellWithTableView:tableView];
            [cell upBtnsFrameWithEdgeInsets:UIEdgeInsetsMake(15, 16, 13.5, 16)];
            [cell.leftBtn setTitle:@"Bienvenido a PresiMex" forState:UIControlStateNormal];
            [cell.leftBtn setTitleColor:[UIColor jk_colorWithHexString:@"#1B1200"]  forState:UIControlStateNormal];
            cell.leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
            [cell.rightBtn setImage:[UIImage imageNamed:@"kefu"] forState:UIControlStateNormal];
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
            WFLabelCell * cell  = [WFLabelCell cellWithTableView:tableView identifier:@"22"];
            cell.label.textAlignment = NSTextAlignmentCenter;
            [cell.label setText:[NSString stringWithFormat:@"%ld",self.changeValue] TextColor:[UIColor whiteColor] Font:[UIFont boldSystemFontOfSize:25]];
            
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(2, 15, 5, 15)];
            
            [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
            [cell.BGView addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth-30, 37) maskedCorners:kCALayerMinXMinYCorner cornerRadius:0.1];
            
            
            return cell;
            
            
        }else if (indexPath.row == 3){
            WFSliderCell * cell  = [WFSliderCell cellWithTableView:tableView];
            
            
            if(self.homeModel){
                //剩余额度大于最小额度
                if([self.authModel.monster doubleValue] >= [self.authModel.clear doubleValue]){
                    cell.slider.userInteractionEnabled = YES;
                    cell.slider.value = [self.authModel.monster doubleValue];
                    cell.slider.maximumValue = [self.authModel.monster doubleValue];
                    cell.slider.minimumValue = [self.authModel.clear doubleValue];
                }else{
                    cell.slider.userInteractionEnabled = NO;
                }
                
            }else{
                cell.slider.userInteractionEnabled = NO;
            }
            [cell.slider trackRectForBounds:CGRectMake(0, 0, WF_ScreenWidth - 30, 8)];
            [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
            [cell upSliderFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15) height:21];
            [cell.BGView addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth-30, 24) maskedCorners:kCALayerMinXMinYCorner cornerRadius:0.1];
            WF_WEAKSELF(weakself);
            cell.sliderChangeBlock = ^(NSInteger number) {
                weakself.changeValue = number;
                
                NSIndexPath * IndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
                [weakself.tableView reloadRowsAtIndexPaths:@[IndexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
            return cell;
            
            
        }else if (indexPath.row == 4){
            WFThreeBtnCell * cell = [WFThreeBtnCell cellWithTableView:tableView];
            [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15) height:24.5];
            [cell upBtnsFrameWithInsets:UIEdgeInsetsMake(10, 15, 0, 15)];
            [cell.BGView addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth-30, 25) maskedCorners:kCALayerMinXMinYCorner cornerRadius:0.1];
            
            [cell.centerBtn setText:@"Plazo de validez del límite" TextColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
           
            
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
            [cell.label setText:@"2d, 12h, 30m,12s" TextColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:11]];
            
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(5, 15, 8.5, 15)];
            
            [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
            [cell.BGView addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth-30, 23.5) maskedCorners:kCALayerMinXMinYCorner cornerRadius:0.1];
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
            [cell.label setText:@"Tu crédito no es insuficiente. Mejora tu puntuación al realizar el pago." TextColor:BColor_Hex(@"#7C7C7C", 1) Font:[UIFont systemFontOfSize:13]];
            
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(15.5, 66, 20, 66)];
            [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
            [cell.BGView deletaLinearGradient];
            
            return cell;
        } else if (indexPath.row == 8){
            WFBtnCell * cell = [WFBtnCell cellWithTableView:tableView];
            [cell.btn setTitle:@"Ver mis pedidos" forState:UIControlStateNormal];
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
                HomeDetailsVC * vc = [HomeDetailsVC new];
                vc.homeModel = weakself.homeModel;
                
                [weakself.navigationController pushViewController:vc animated:YES];
            }];
            [cell.btn addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth - 30, 50) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:13];
        
            [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(10, 15, 15, 15) height:50];
            return cell;
        }else{
            WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
            cell.label.textAlignment = NSTextAlignmentCenter;
            cell.label.textColor = [UIColor jk_colorWithHexString:@"#999999"];
            cell.label.font = [UIFont systemFontOfSize:12];
            NSString * String = @"El monto real está sujeto a la sum de las\n\"Opciones Recomendadas\"";
            
            NSString * subString0 = @"Opciones Recomendadas";
          
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
        _tableView.backgroundColor  = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

-(HomeNoAuthView *)NoAuthView{
    
    if (!_NoAuthView) {
        _NoAuthView = [[HomeNoAuthView alloc] initWithFrame:CGRectMake(0, self.notiView.swf_bottom, WF_ScreenWidth, WF_ScreenHeight - self.notiView.swf_bottom - WF_TabBarHeight)];
        WF_WEAKSELF(weakself);
        _NoAuthView.clickBock = ^{
            [weakself pushCerVc];
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


#pragma mark --网络请求

-(void)GETAppBanner{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
  
    WF_WEAKSELF(weakself);
    [PMBaseHttp get:GET_App_Banner parameters:pars success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"retail"] intValue]==200) {
            [weakself.notiView setNotList:responseObject[@"trackback"]];
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
            
            [weakself upDataSubview];
            
        }else{
            
            weakself.authModel = nil;
            [weakself.tableView reloadData];
        }
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

-(void)upDataSubview{
    
    if ([self.authModel.shop integerValue] == 20) {
        [self.view addSubview:self.tableView];
        [self.NoAuthView removeFromSuperview];
        [self.tableView reloadData];
        [self GETProductList];
    } else {
        
        [self.view addSubview:self.NoAuthView];
        [self.tableView removeFromSuperview];
    }
}


//获取产品列表
-(void)GETProductList{
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
        }
        
        
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}



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
@end
