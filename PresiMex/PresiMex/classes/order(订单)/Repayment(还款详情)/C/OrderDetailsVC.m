//
//  OrderDetailsVC.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/5.
//

#import "OrderDetailsVC.h"
#import "PMOrderTopView.h"
#import "WFLeftRightLabelCell.h"
#import "WFThreeBtnCell.h"
#import "WFLabelCell.h"
#import "WFBtnCell.h"
#import "PMBasicViewCell.h"
#import "WFLeftRightBtnCell.h"
#import "WFEmptyCell.h"

#import "ThreeLabelAlert.h"
#import "PayVC.h"

#import "RepayModel.h"
#import "PayTypeModel.h"
#import "CuponModel.h"
@interface OrderDetailsVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/

@property (nonatomic, strong) PMOrderTopView *topView;

@property (nonatomic, assign) NSInteger indx;

@property(strong, nonatomic) RepayModel * leftModel;

@property(strong, nonatomic) RepayModel * rightModel;

@property(strong, nonatomic) NSArray<PayTypeModel *> * payModelArr;

@property (nonatomic, assign) NSInteger PayIndx;//支付方式索引


@property (nonatomic, strong) NSArray *cuponArr;//优惠卷数组


@property (nonatomic, assign) NSInteger cuponIndx;//优惠卷索引

@property (nonatomic, strong) NSString *rated;//优惠卷id



@end

@implementation OrderDetailsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitleLabel.text = @"Reembolso";
   
    self.cuponIndx = -1;
    [self.tempView addSubview:self.topView];
    WF_WEAKSELF(weakself);
    [self.topView setClickLeftBtnBlock:^{
        weakself.indx = 0;
        if (!weakself.leftModel) {
           [weakself GETLoanDetail];
        } else {
            
            [weakself.tableView reloadData];
        }
        
        
    }];
    [self.topView setClickRightBtnBlock:^{
        weakself.indx = 1;
        if (!weakself.rightModel) {
            [weakself GETRepayBillDetail];
        } else {
            
            [weakself.tableView reloadData];
        }
    }];
        
    [self.tempView addSubview:self.tableView];
    
    [self GETLoanDetail];
    
}



#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 13;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 15, 7.5, 15)];
        [cell.leftLabel setText:@"Producto:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
        if (self.indx == 0) {
            [cell.rightLabel setText:self.leftModel.nu TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
        } else {
            [cell.rightLabel setText:self.rightModel.nu TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
        }
        return cell;
    }else if (indexPath.row == 1) {
        WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 15, 7.5, 15)];
        [cell.leftLabel setText:@"Principal:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
        if (self.indx == 0) {
            if(self.leftModel){
                [cell.rightLabel setText:[NSString stringWithFormat:@"$ %@",self.leftModel.lower] TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
            }
        } else {
            if(self.rightModel){
                [cell.rightLabel setText:[NSString stringWithFormat:@"$ %@",self.rightModel.lower] TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
            }
        }
        return cell;
    }else if (indexPath.row == 2) {
        WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 15, 7.5, 15)];
        [cell.leftLabel setText:@"Fecha de vencimiento:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
        if (self.indx == 0) {
            [cell.rightLabel setText:self.leftModel.cook TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
        } else {
            [cell.rightLabel setText:self.rightModel.cook TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
        }
        return cell;
    }else if (indexPath.row == 3) {
        //逾期天数：
        WFLeftRightLabelCell * cell = [WFLeftRightLabelCell bottomLineCellWithTableView:tableView];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 15, 14.5, 15)];
        cell.bottomLine.hidden = NO;
        [cell.leftLabel setText:@"Días de mora:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
        if (self.indx == 0) {
            [cell.rightLabel setText:self.leftModel.luis TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
        } else {
            [cell.rightLabel setText:self.rightModel.luis TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
        }
        [cell upLineFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
        return cell;
    }else if (indexPath.row == 4) {
        //逾期费
        WFThreeBtnCell * cell = [WFThreeBtnCell cellWithTableView:tableView];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) height:46.5-7.5];

        [cell.leftBtn setText:@"Cargo por mora:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13] forState:UIControlStateNormal];
        
        if (self.indx == 0) {
            if (self.leftModel) {
                [cell.centerBtn setText:[NSString stringWithFormat:@"$%@",self.leftModel.fifteen] TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13] forState:UIControlStateNormal];
            } else {
                [cell.centerBtn setText:@"" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13] forState:UIControlStateNormal];
            }
        } else {
            if (self.rightModel) {
                
                [cell.centerBtn setText:[NSString stringWithFormat:@"$%@",self.rightModel.fifteen] TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13] forState:UIControlStateNormal];
            }else{
                
                [cell.centerBtn setText:@"" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13] forState:UIControlStateNormal];
            }
        }
        [cell.rightBtn setImage:[UIImage imageNamed:@"tixingtishi"] forState:UIControlStateNormal];
        [cell.rightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        UIEdgeInsets  padding  = UIEdgeInsetsMake(14.5, 15, 7.5, 0);
        [cell.leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(padding.left));
            make.top.equalTo(@(padding.top));
            make.bottom.equalTo(@(-padding.bottom));

        }];
        
        [cell.rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-padding.right));
            make.centerY.equalTo(cell.leftBtn);
            make.width.equalTo(@(45));

        }];
        [cell.centerBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
          
            make.centerY.equalTo(cell.leftBtn);
            make.right.equalTo(cell.rightBtn.mas_left);

        }];
        
        [cell setClickBtnBlock:^(NSInteger index) {
            if(index == 2){
                
                ThreeLabelAlert * alert = [[ThreeLabelAlert alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth - 60, 200) withType:self.beOverdue];
                
                WFCustomAlertView *  AlertView = [[WFCustomAlertView alloc] initWithContentView:alert];
                [AlertView setClickBGDismiss:YES];
                [AlertView show];
             
            }
        }];
        
        
        return cell;
    }else if (indexPath.row == 5) {
        
        
        if(self.indx == 0){
            //优惠券
            WFThreeBtnCell * cell = [WFThreeBtnCell cellWithTableView:tableView];
            [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) height:46.5-7.5];

            [cell.leftBtn setText:@"cupón:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13] forState:UIControlStateNormal];
            
            if (self.cuponIndx >= 0) {
                CuponModel * cuModel = self.cuponArr[self.cuponIndx];
                
                [cell.centerBtn setText:[NSString stringWithFormat:@"$ %@",cuModel.readers] TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
            } else {
                
                [cell.centerBtn setText:@"Por favor seleccione" TextColor:BColor_Hex(@"#CCCCCC", 1) Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
            }
            [cell.rightBtn setImage:[UIImage imageNamed:@"Fill"] forState:UIControlStateNormal];
            [cell.rightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            UIEdgeInsets  padding  = UIEdgeInsetsMake(14.5, 15, 7.5, 0);
            
            WF_WEAKSELF(weakself);
            [cell setClickBtnBlock:^(NSInteger index) {
                if(index == 2){
                   //跳转优惠卷列表
                    [weakself GETCouponUrl];
                 
                }
            }];
            [cell.leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@(padding.left));
                make.top.equalTo(@(padding.top));
                make.bottom.equalTo(@(-padding.bottom));

            }];
            
            [cell.rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(@(-padding.right));
                make.centerY.equalTo(cell.leftBtn);
                make.width.equalTo(@(45));

            }];
            [cell.centerBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
              
                make.centerY.equalTo(cell.leftBtn);
                make.right.equalTo(cell.rightBtn.mas_left);

            }];
            
            
            return cell;
        }else{
            WFEmptyCell * cell = [WFEmptyCell cellWithTableView:tableView];
            return cell;
        }
    }else if (indexPath.row == 6) {
        if(self.indx == 0){
            //已支付
            WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView];
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 15, 14.5, 15)];
            [cell.leftLabel setText:@"Pagado:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
            if(self.leftModel){
                [cell.rightLabel setText:[NSString stringWithFormat:@"$ %@",self.leftModel.gang] TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
            }else{
                [cell.rightLabel setText:@"" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
            }
            return cell;
        }else{
            WFEmptyCell * cell = [WFEmptyCell cellWithTableView:tableView];
            return cell;
        }
        
    }else if (indexPath.row == 7) {
        
        if(self.indx == 0){
            if (self.beOverdue == YES) {
                WFEmptyCell * cell = [WFEmptyCell cellWithTableView:tableView];
                return cell;
            } else {
                //减免金额
                WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView];
                [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 15, 14.5, 15)];
                [cell.leftLabel setText:@"Cantidad reducida:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
                if (self.leftModel) {
                    
                    [cell.rightLabel setText:[NSString stringWithFormat:@"$ %@",self.leftModel.shortly] TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
                } else {
                    
                    [cell.rightLabel setText:@"" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
                }
                [cell upLineFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
                return cell;
            }
        }else{
            //展期订单应还日期：
            WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView identifier:@"2Line"];
            UIEdgeInsets padding = UIEdgeInsetsMake(10, 15, 14.5, 15);
            [cell upLabelFrameWithInsets:padding];
            [cell.leftLabel setText:@"Fecha de vencimiento después de la extensión" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
            [cell.rightLabel setText:self.rightModel.talk TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
            cell.leftLabel.numberOfLines = 2;
            [cell.leftLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@(padding.left));
                make.top.equalTo(@(padding.top));
                make.bottom.equalTo(@(-padding.bottom));
                make.width.lessThanOrEqualTo(@(200));

            }];
            return cell;
            
        }
        
        
    }else if (indexPath.row == 8){
        if (self.indx == 0) {
            //本次需支付账单
            WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView];
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 15, 14.5, 15)];
            [cell.leftLabel setText:@"Pago en total:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
            if (self.leftModel) {
                [cell.rightLabel setText:[NSString stringWithFormat:@"$ %@",self.leftModel.tt] TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
            } else {

                [cell.rightLabel setText:@"" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
            }
            return cell;
        } else {
            //逾期费
            WFThreeBtnCell * cell = [WFThreeBtnCell cellWithTableView:tableView];
            [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) height:46.5-7.5];
            if(self.beOverdue == YES){
                
                [cell.leftBtn setText:@"Cuentas pendientes durante la prórroga:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13] forState:UIControlStateNormal];
                
                [cell.centerBtn setText:self.rightModel.qty TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13] forState:UIControlStateNormal];

            }else{
                [cell.leftBtn setText:@"Pago en total:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13] forState:UIControlStateNormal];

                if (self.rightModel) {
                    
                    [cell.centerBtn setText:self.rightModel.qty TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13] forState:UIControlStateNormal];

                } else {

                    
                    [cell.centerBtn setText:@"" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13] forState:UIControlStateNormal];

                }
            }
            
            [cell.rightBtn setImage:[UIImage imageNamed:@"tixingtishi"] forState:UIControlStateNormal];
            [cell.rightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            UIEdgeInsets  padding  = UIEdgeInsetsMake(14.5, 15, 7.5, 0);
            [cell.leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@(padding.left));
                make.top.equalTo(@(padding.top));
                make.bottom.equalTo(@(-padding.bottom));

            }];
            
            [cell.rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(@(-padding.right));
                make.centerY.equalTo(cell.leftBtn);
                make.width.equalTo(@(45));

            }];
            [cell.centerBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
              
                make.centerY.equalTo(cell.leftBtn);
                make.right.equalTo(cell.rightBtn.mas_left);

            }];
            
            [cell setClickBtnBlock:^(NSInteger index) {
                if(index == 2){
                    
                    ThreeLabelAlert * alert = [[ThreeLabelAlert alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth - 60, 200) withType:self.beOverdue];
                    
                    WFCustomAlertView *  AlertView = [[WFCustomAlertView alloc] initWithContentView:alert];
                    [AlertView setClickBGDismiss:YES];
                    [AlertView show];
                 
                }
            }];
            
            
            return cell;
        }
      
    }
//    {
//        if (self.indx == 0) {
//            //本次需支付账单
//            WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView];
//            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 15, 14.5, 15)];
//            [cell.leftLabel setText:@"Pago en total:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
//            if (self.leftModel) {
//                [cell.rightLabel setText:[NSString stringWithFormat:@"$ %@",self.leftModel.tt] TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
//            } else {
//
//                [cell.rightLabel setText:@"" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
//            }
//            return cell;
//        } else {
//            //展期需支付账单
//            WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView];
//            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 15, 14.5, 15)];
//            if(self.beOverdue == YES){
//
//                [cell.leftLabel setText:@"Cuentas pendientes durante la prórroga:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
//                [cell.rightLabel setText:self.rightModel.qty TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
//            }else{
//
//                [cell.leftLabel setText:@"Pago en total:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
//                if (self.rightModel) {
//
//                    [cell.rightLabel setText:[NSString stringWithFormat:@"$ %@",self.rightModel.qty] TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
//                } else {
//
//                    [cell.rightLabel setText:@"" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
//                }
//            }
//            return cell;
//        }
//
//
//
//    }
    else if (indexPath.row == 9) {
        //分割线
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView identifier:@"line"];
        cell.label.text = @"";
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 0, 0, 0)];
        cell.BGView.backgroundColor = BColor_Hex(@"#F1F1F1", 1);
        return cell;
    }else if (indexPath.row == 10) {
        //展示：请选择您的还款方式
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
        cell.label.text = @"Por favor seleccione su método de pago";
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#1B1200"];
        cell.label.font = [UIFont boldSystemFontOfSize:15];
        cell.label.textAlignment = NSTextAlignmentLeft;
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(20, 15, 20, 15)];
        return cell;
    }else if (indexPath.row == 11) {

        //展示：还款方式
        WFLeftRightBtnCell * cell = [WFLeftRightBtnCell cellWithTableView:tableView];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15) height:50];
        [cell upBtnsFrameWithEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 15)];
        
        PayTypeModel * model = self.payModelArr[self.PayIndx];
        [cell.leftBtn setTitle:model.merchandise forState:UIControlStateNormal];
        [cell.leftBtn setTitleColor:[UIColor jk_colorWithHexString:@"#1B1200"]  forState:UIControlStateNormal];
        cell.leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [cell.rightBtn setImage:[UIImage imageNamed:@"xiaJian"] forState:UIControlStateNormal];
        cell.leftBtn.userInteractionEnabled = NO;
        cell.rightBtn.userInteractionEnabled = NO;
        
        cell.BGView.layer.cornerRadius = 25;
        cell.BGView.layer.masksToBounds = YES;
        cell.BGView.layer.borderWidth = 0.5;
        cell.BGView.layer.borderColor = BColor_Hex(@"#CCCCCC", 1).CGColor;
        
        return cell;
        
    }else {
        //去还款按钮
        WFBtnCell * cell = [WFBtnCell cellWithTableView:tableView];
        [cell.btn setTitle:@"Pagar" forState:UIControlStateNormal];
        cell.btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        WF_WEAKSELF(weakself);
        [cell setClickBtnBlock:^{
            PayVC * vc = [[PayVC alloc] init];
            
            PayTypeModel * payModel = weakself.payModelArr[weakself.PayIndx];
            vc.fraction = payModel.fraction;
            if (weakself.indx == 0) {
                
                vc.repayId = weakself.leftModel.prairie;
                vc.repaymentType = @"10";
            } else {
                vc.repayId = weakself.rightModel.prairie;
                vc.repaymentType = @"20";
            }
            vc.rated = weakself.rated;
            
            [weakself.navigationController pushViewController:vc animated:YES];
        }];
        [cell.btn addLinearGradientwithSize:CGSizeMake(self.view.jk_width - 30, 50) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:13];
        [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(20, 15, 20, 15) height:50];
        return cell;
    }
  
    return [UITableViewCell new];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 11){
        NSMutableArray * titleArr = [NSMutableArray array];
        for (PayTypeModel * model in self.payModelArr) {
//            PMPickerModel * PickerModel = [PMPickerModel new];
//            PickerModel.title = model.merchandise;
//            PickerModel.ID = model.fraction;
            [titleArr addObject:model.merchandise];
        }
        
        [self sutupAlertView:@"" withArr:titleArr];
    }
    
}



#pragma mark -- init
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, WF_ScreenWidth, WF_ScreenHeight - WF_NavigationHeight - 70)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor  = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

-(PMOrderTopView *)topView{
    if(_topView == nil){
        _topView = [[PMOrderTopView alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, 70)];
        [_topView selectIndx:0];
    }
    return _topView;
}

-(void)sutupAlertView:(NSString*)title withArr:(NSArray*)arr{
    [self.view endEditing:YES];
//    weakify(self)
    
    
//    JKPickerViewAppearance *alert=[[JKPickerViewAppearance alloc] initWithPickerViewTilte:title withData:arr pickerCompleteBlock:^(id  _Nonnull responseObjct,NSInteger indx) {
//        strongify(self);
//        self.PayIndx = indx;
//        [self.tableView reloadData];
//
//    }];
//    [alert show] ;
    weakify(self);
    PoPBottomView * BottomView = [PoPBottomView new];
    BottomView.titles = arr;
    SLFCommentsPopView * popView = [SLFCommentsPopView commentsPopViewWithFrame:CGRectMake(0, 0, WF_ScreenWidth, WF_ScreenHeight) contentView:BottomView contentViewNeedScroView:NO];
    [popView showWithTitileStr:@""];
    
    BottomView.selectBlock = ^(NSString * _Nonnull responseObjct, NSInteger indx) {
        strongify(self);
        
        self.PayIndx = indx;
        [self.tableView reloadData];
        [popView dismiss];
    };
}


//获取借款详情
-(void)GETLoanDetail{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
  
    if(self.rated && self.rated.length){
        pars[@"rated"] = self.rated;
    }
    NSString *url=[NSString stringWithFormat:@"%@%@",GET_Loan_Detail,self.repayId];
    WF_WEAKSELF(weakself);

    [self show];
    [PMBaseHttp get:url parameters:pars success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"retail"] intValue]==200) {
            NSDictionary * shame = responseObject[@"shame"];
            weakself.leftModel = [RepayModel mj_objectWithKeyValues:shame];
            if(!weakself.payModelArr){
                
                [weakself GETMerchantPass:weakself.leftModel.demanding];
            }else{
                [weakself dismiss];
            }
            
            [weakself.tableView reloadData];
        }else{
            [weakself dismiss];
            [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
    } failure:^(NSError * _Nonnull error) {
        [weakself dismiss];
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        
    }];
}

//获取展期详情
-(void)GETRepayBillDetail{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
  

    [self show];
    WF_WEAKSELF(weakself);
    [PMBaseHttp get:[NSString stringWithFormat:GET_Repay_Bill_Detail,self.repayId] parameters:pars success:^(id  _Nonnull responseObject) {
        [weakself dismiss];
        if ([responseObject[@"retail"] intValue]==200) {
            NSDictionary * shame = responseObject[@"shame"];
            weakself.rightModel = [RepayModel mj_objectWithKeyValues:shame];
            
            if(!weakself.payModelArr){
                [weakself GETMerchantPass:weakself.rightModel.demanding];
            }
            [weakself.tableView reloadData];
            
        }else{
            [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
    } failure:^(NSError * _Nonnull error) {
        [weakself dismiss];
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        
    }];
}



//获取商户对应支持通道
-(void)GETMerchantPass:(NSString *)demanding{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
  

    WF_WEAKSELF(weakself);
    [PMBaseHttp get:GET_Merchant_Pass parameters:pars success:^(id  _Nonnull responseObject) {
        [weakself dismiss];
        if ([responseObject[@"retail"] intValue]==200) {
            NSArray * sports = responseObject[@"shame"][@"sports"];
            weakself.payModelArr = [PayTypeModel mj_objectArrayWithKeyValuesArray:sports];
            [weakself.tableView reloadData];
            
        }else{
            [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
    } failure:^(NSError * _Nonnull error) {
        [weakself dismiss];
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        
    }];
}




//获取优惠卷
-(void)GETCouponUrl{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
    pars[@"eg"] = [NSString stringWithFormat:@"%d",1];
    pars[@"patricia"] = @"100";
    pars[@"prairie"] = self.repayId;
    WF_WEAKSELF(weakself);
    [self show];
    [PMBaseHttp get:GET_Coupon_Url parameters:pars success:^(id  _Nonnull responseObject) {
        [weakself dismiss];
        if ([responseObject[@"retail"] intValue]==200) {
            NSArray * dataList = responseObject[@"shame"][@"approaches"];
            if (dataList.count) {
                weakself.cuponArr = [CuponModel mj_objectArrayWithKeyValuesArray:dataList];
                [weakself sutupAlertView];
            }
            
        }else{
            [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
    } failure:^(NSError * _Nonnull error) {
        [weakself dismiss];
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        
    }];
    
}

//优惠卷弹出框选择
-(void)sutupAlertView{
    [self.view endEditing:YES];
    
    
    NSMutableArray * arr = [NSMutableArray array];
    
    for (CuponModel * dataModel in  self.cuponArr) {
        [arr addObject:dataModel.readers];
    }
    
//    weakify(self);
//    JKPickerViewAppearance *alert=[[JKPickerViewAppearance alloc] initWithPickerViewTilte:@"" withData:arr pickerCompleteBlock:^(id  _Nonnull responseObjct,NSInteger indx) {
//        strongify(self);
//        self.cuponIndx = indx;
//
//        [self.tableView reloadData];
//
//    }];
//    [alert show] ;
    
    weakify(self);
    PoPBottomView * BottomView = [PoPBottomView new];
    BottomView.titles = arr;
    SLFCommentsPopView * popView = [SLFCommentsPopView commentsPopViewWithFrame:CGRectMake(0, 0, WF_ScreenWidth, WF_ScreenHeight) contentView:BottomView contentViewNeedScroView:NO];
    [popView showWithTitileStr:@""];
    
    BottomView.selectBlock = ^(NSString * _Nonnull responseObjct, NSInteger indx) {
        strongify(self);
        self.cuponIndx = indx;
        
        [self.tableView reloadData];
        [popView dismiss];
    };
}


@end
