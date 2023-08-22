//
//  PayVC.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/6.
//

#import "PayVC.h"
#import "WFLabelCell.h"
#import "WFLeftRightLabelCell.h"
#import "WFLeftTBLbaelRightBtnCell.h"
#import "WFImageCell.h"
#import "WFTopBtnBottomTwoLabelCell.h"
#import "WFEmptyCell.h"

#import "PayModel.h"
#import "PayResultModel.h"
#import "ExtendedSuccessfullyAlart.h"
#import "RepaymentSuccessfulAlert.h"
#import "HomeDetailsVC.h"

@interface PayVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/

@property (nonatomic, strong) PayModel * model;

@property (nonatomic, strong) NSTimer *timer;


@end

@implementation PayVC



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tempView addSubview:self.tableView];
    
    if ([self.fraction isEqualToString:@"va"]) {
        self.navTitleLabel.text = @"STP（Cuenta virtual）";
    } else if ([self.fraction isEqualToString:@"store"]) {
        self.navTitleLabel.text = @"Store（Tiendas)";
    }
//    else if ([self.fraction isEqualToString:@"Cash"]) {
//        self.navTitleLabel.text = @"OXXO Cash";
//    }
    [self GETRepayVcInfo];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        WFLeftRightLabelCell * cell = [WFLeftRightLabelCell bottomLineCellWithTableView:tableView];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(15.5, 15, 15.5, 15)];
        cell.bottomLine.hidden = NO;
        [cell.leftLabel setText:@"Total de la factura：" TextColor:BColor_Hex(@"#7C7C7C", 1) Font:[UIFont systemFontOfSize:13]];
        [cell.rightLabel setText:@"" TextColor:BColor_Hex(@"#1B1200", 1) Font:[UIFont boldSystemFontOfSize:15]];
        if ([self.fraction isEqualToString:@"va"]) {
            cell.rightLabel.text = self.model.specials.tt;
        } else if ([self.fraction isEqualToString:@"store"]) {
            cell.rightLabel.text = self.model.yo.tt;
        }
        
        [cell upLineFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
        return cell;
    }else if (indexPath.row == 1) {
        
       //还款码
        WFLeftTBLbaelRightBtnCell * cell = [WFLeftTBLbaelRightBtnCell cellWithTableView:tableView];
        
        [cell.topLabel setText:@"Referencia：" TextColor:BColor_Hex(@"#7C7C7C", 1) Font:[UIFont systemFontOfSize:13]];
        if ([self.fraction isEqualToString:@"va"]) {
            cell.topLabel.text = @"Código de reembolso：";
        } else if ([self.fraction isEqualToString:@"store"]) {
            cell.topLabel.text = @"Referencia：";
        }
        
        [cell.bottomLabel setText:@"" TextColor:BColor_Hex(@"#1B1200", 1) Font:[UIFont systemFontOfSize:15]];
        NSString * batch = @"";
        if ([self.fraction isEqualToString:@"va"]) {
            batch = self.model.specials.batch;
        } else if ([self.fraction isEqualToString:@"store"]) {
            batch = self.model.yo.batch;
        }
        
        cell.bottomLabel.text = batch;
        
        [cell.btn addLinearGradientwithSize:CGSizeMake(85, 33) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:5];
        [cell.btn setText:@"Copiar" TextColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
        [cell.btn setImage:[UIImage imageNamed:@"fuzhi"] forState:UIControlStateNormal];
        cell.btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [cell.btn bringSubviewToFront:cell.btn.imageView];
        cell.bottomLine.hidden = NO;
        [cell upLabelsFrameWithInsets:UIEdgeInsetsMake(16, 15, 17, 10) centerSpac:14];
        
        [cell upBtnFrameWithInsets:UIEdgeInsetsMake(16, 0, 34, 15) size:CGSizeMake(85, 33)];
        [cell upLineFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
        WF_WEAKSELF(weakself);
        [cell setClickbtnBlock:^(UIButton * _Nonnull btn) {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = batch;
            [weakself.view showTipC:@"Copia exitosa"];
        }];
        
        return cell;
        
    }else if (indexPath.row == 2) {
        if ([self.fraction isEqualToString:@"va"]) {
            WFEmptyCell * cell = [WFEmptyCell cellWithTableView:tableView];
            return cell;
        }
        
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
        cell.label.text = @"código de barras de pago：";
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#7C7C7C"];
        cell.label.font = [UIFont boldSystemFontOfSize:13];
        cell.label.textAlignment = NSTextAlignmentLeft;
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(16, 15, 0, 15)];
        return cell;
    }else if (indexPath.row == 3) {
        if ([self.fraction isEqualToString:@"va"]) {
            WFEmptyCell * cell = [WFEmptyCell cellWithTableView:tableView];
            return cell;
        }
        WFImageCell * cell = [WFImageCell cellWithTableView:tableView];
        [cell.imgV sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:nil];
        cell.bottomLine.hidden = NO;
        if ([self.fraction isEqualToString:@"va"]) {
            cell.imgV.image = self.model.specials.batchImage;
        } else if ([self.fraction isEqualToString:@"store"]) {
            cell.imgV.image = self.model.yo.batchImage;
        }
        [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) height:109];
        return cell;
    } else {
        WFTopBtnBottomTwoLabelCell * cell = [WFTopBtnBottomTwoLabelCell cellWithTableView:tableView];
        [cell.btn setBackgroundImage:[UIImage imageNamed:@"pago"] forState:UIControlStateNormal];
        [cell.btn setTitle:@"Directrices de pago" forState:UIControlStateNormal];
        cell.btn.backgroundColor = [UIColor whiteColor];
        [cell.btn setTitleColor:BColor_Hex(@"#FC7500", 1) forState:UIControlStateNormal];
        [cell.label1 setText:@"El código de pago es válido durante 6 horas, organice el pago lo antes posible." TextColor:BColor_Hex(@"#7C7C7C", 1) Font:[UIFont systemFontOfSize:11]];
        
        NSURL *url;
        if ([self.fraction isEqualToString:@"va"]) {
            url = [NSURL URLWithString:H5_STP];
        } else if ([self.fraction isEqualToString:@"store"]) {
            url = [NSURL URLWithString:H5_store];
        }
        
        [cell.label2 loadRequest:[NSURLRequest requestWithURL:url]];
        
        
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(40, 16, 30, 16)];
        cell.BGView.layer.cornerRadius = 10;
    
        cell.BGView.layer.masksToBounds = YES;
        cell.BGView.layer.borderWidth = 0.5;
        cell.BGView.layer.borderColor = BColor_Hex(@"#DDDDDD", 1).CGColor;
        
        [cell upBtnFrameWithEdgeInsets:UIEdgeInsetsMake(25, (WF_ScreenWidth - 257)/2, 0, (WF_ScreenWidth - 257)/2) height:33];
        
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(14, 13, 21, 13) spacing:14];
        
        
        
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

-(void)initNSTimer{
    // 创建定时器，时间间隔为12秒，重复执行
    self.timer = [NSTimer scheduledTimerWithTimeInterval:12.0 target:self selector:@selector(GETRepayBill) userInfo:nil repeats:YES];
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

//获取还款页面信息
-(void)GETRepayVcInfo{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
    pars[@"fraction"] = self.fraction;
    pars[@"rated"] = self.rated;
    
    WF_WEAKSELF(weakself);
    [self.view show];
    [PMBaseHttp get:[NSString stringWithFormat:GET_Repay_Vc_Info,self.repayId,self.repaymentType] parameters:pars success:^(id  _Nonnull responseObject) {
        [weakself.view dismiss];
        if ([responseObject[@"retail"] intValue]==200) {
            NSDictionary * shame = responseObject[@"shame"];
            weakself.model = [PayModel mj_objectWithKeyValues:shame];
            [weakself.tableView reloadData];
            [weakself GETRepayBill];
            [weakself initNSTimer];
            
        }else{
            [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
    } failure:^(NSError * _Nonnull error) {
        [weakself dismiss];
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        
    }];
}

//查询还款/展期结果
-(void)GETRepayBill{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
    
    
    WF_WEAKSELF(weakself);
    [PMBaseHttp get:[NSString stringWithFormat:GET_Repay_Bill,self.repayId] parameters:pars success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"retail"] intValue]==200) {
            NSDictionary * shame = responseObject[@"shame"];
            PayResultModel * model = [PayResultModel mj_objectWithKeyValues:shame];
            
            if ([model.small integerValue] == 20) {
                
                [weakself.timer invalidate];
                weakself.timer = nil;
                //已还款)
                //全款
                
                RepaymentSuccessfulAlert * alert = [[RepaymentSuccessfulAlert alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth - 60, 147 + 20 + 190) withConttent:weakself.nu btnTitel:@""];
                WFCustomAlertView *  AlertView = [[WFCustomAlertView alloc] initWithContentView:alert];
                [AlertView show];
                WF_WEAKSELF(weakself);
                [alert setClickBtnBlock:^(NSInteger indx) {
                    [AlertView dismiss];
                    
                    [weakself.tabBarController setSelectedIndex:0];
                    
                    [weakself.navigationController popToRootViewControllerAnimated:NO];
                    
                    
                    
                }];
                
                PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_all_repay_succ content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
                 [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
                
            } else if([model.small integerValue] == 30){
                //展期
                [weakself.timer invalidate];
                weakself.timer = nil;
                ExtendedSuccessfullyAlart * alert = [[ExtendedSuccessfullyAlart alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth - 60, 147 + 20 + 190) withConttent:weakself.nu btnTitel:@""];
                
                WFCustomAlertView *  AlertView = [[WFCustomAlertView alloc] initWithContentView:alert];
                [AlertView show];
                WF_WEAKSELF(weakself);
                [alert setClickBtnBlock:^{
                    [AlertView dismiss];
                    
                    [weakself.navigationController popToRootViewControllerAnimated:YES];
                   
                }];
                
                PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_extension_repay_succ content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
                 [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
                
            }
            
        }else{
            [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
    } failure:^(NSError * _Nonnull error) {
        [weakself dismiss];
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        
    }];
}

@end
