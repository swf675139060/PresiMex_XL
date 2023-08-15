//
//  HomeDetailView.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/23.
//

#import "HomeDetailView.h"
#import "WFLeftRightBtnCell.h"
#import "WFLeftRightLabelCell.h"
#import "WFBtnCell.h"
#import "ConfirmAccountVC.h"

@interface HomeDetailView()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, assign) BOOL agree;

@end


@implementation HomeDetailView
- (void)buildSubViews{
    [super buildSubViews];
//    self.agree = YES;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self addSubview:self.tableView];
    
    [self GETBindUserAccount];
    
    WF_WEAKSELF(weakself);
    [self whenTapped:^{
        [weakself removeFromSuperview];
    }];
    [self.tableView whenTapped:^{
//        [weakself removeFromSuperview];
    }];
    
    
    PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_loan_detail content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
    [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];

    
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 6;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        WFBtnCell * cell = [WFBtnCell cellWithTableView1:tableView];
        [cell.btn setText:@"Modificar cuenta" TextColor:BColor_Hex(@"#FC7500", 1) Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
        cell.btn.layer.cornerRadius = 5;
        cell.btn.layer.masksToBounds = YES;
        cell.btn.layer.borderWidth = 0.5;
        cell.btn.layer.borderColor = BColor_Hex(@"#FC7500", 1).CGColor;
        WF_WEAKSELF(weakself);
        [cell setClickBtnBlock:^{
            
            if(weakself.clickBankBlock){
                weakself.clickBankBlock(weakself.bankModel);
                
                PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq03_loan_detail_change_bank_account content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
                [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
            }
        }];

        
        [cell.btn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-15));
            make.width.equalTo(@(110));
            make.height.equalTo(@(33));
            make.top.equalTo(@(15));
            make.bottom.equalTo(@(0));
        }];
        
        return cell;
    } else if (indexPath.row == 1) {
        WFLeftRightLabelCell * cell = [WFLeftRightLabelCell bottomLineCellWithTableView:tableView];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(20, 16, 20, 16)];
        [cell.leftLabel setText:@"Método de pago" TextColor:BColor_Hex(@"#1B1200", 1) Font:[UIFont boldSystemFontOfSize:15]];
        cell.bottomLine.hidden = NO;
        
        if(self.bankModel){
            if ([self.bankModel.diameter integerValue] == 1) {
                [cell.rightLabel setText:@"Tarjeta de débito" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:14]];
            } else {
                [cell.rightLabel setText:@"CLABE" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:14]];
            }
        }else{
            [cell.rightLabel setText:@"" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:14]];
        }
        
        return cell;
    } else if (indexPath.row == 2) {
        WFLeftRightLabelCell * cell = [WFLeftRightLabelCell bottomLineCellWithTableView:tableView];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(20, 16, 20, 16)];
        [cell.leftLabel setText:@"Banco" TextColor:BColor_Hex(@"#1B1200", 1) Font:[UIFont boldSystemFontOfSize:15]];
        
        cell.bottomLine.hidden = NO;
        if(self.bankModel){
            [cell.rightLabel setText:self.bankModel.marshall TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:14]];
        }else{
            [cell.rightLabel setText:@"" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:14]];
        }
        
        return cell;
    } else if (indexPath.row == 3) {
        WFLeftRightLabelCell * cell = [WFLeftRightLabelCell bottomLineCellWithTableView:tableView];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(20, 16, 20, 16)];
        [cell.leftLabel setText:@"Cuenta" TextColor:BColor_Hex(@"#1B1200", 1) Font:[UIFont boldSystemFontOfSize:15]];
        
        cell.bottomLine.hidden = NO;
        if(self.bankModel){
            [cell.rightLabel setText:self.bankModel.diploma TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:14]];
        }else{
            [cell.rightLabel setText:@"" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:14]];
        }
        
        return cell;
    }else if (indexPath.row == 4)  {
        
        WFLeftRightBtnCell * cell = [WFLeftRightBtnCell cellWithTableView:tableView];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(25, 5, 15, 5) height:17];
        [cell.leftBtn setTitle:@"" forState:UIControlStateNormal];
        if (self.agree) {
            [cell.leftBtn setImage:[UIImage imageNamed:@"gouxuan"] forState:UIControlStateNormal];
        } else {
            [cell.leftBtn setImage:[UIImage imageNamed:@"gouxuanNO"] forState:UIControlStateNormal];
        }
       
        NSString * Text = @"He leído y acepto el \"Contrato de Préstamo\".";
        
        [cell.rightBtn setText:Text TextColor:BColor_Hex(@"#A8A8A8", 1) Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
        cell.rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:Text attributes: @{NSFontAttributeName:B_FONT_REGULAR(11),NSForegroundColorAttributeName: BColor_Hex(@"#A8A8A8", 1)}];
        
        NSRange range=[Text rangeOfString:@"Contrato de Préstamo"];
        [attStr addAttributes:@{NSForegroundColorAttributeName: BColor_Hex(@"#008DFC", 1)} range:range];
        [cell.rightBtn setAttributedTitle:attStr forState:UIControlStateNormal];
        [cell.rightBtn sizeToFit];
        CGFloat width = cell.rightBtn.bounds.size.width;
        [cell.leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@((WF_ScreenWidth - width - 37)/2));
            make.top.equalTo(@(0));
            make.bottom.equalTo(@(0));
            make.width.equalTo(@(37));

        }];
        
        [cell.rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(@(0));
            make.bottom.equalTo(@(0));
            make.width.equalTo(@(width));
            make.left.equalTo(cell.leftBtn.mas_right);
            
        }];
        
        WF_WEAKSELF(weakself);
        [cell setClickBtnBlock:^(NSInteger indx) {
            if (indx == 0) {
                weakself.agree = !weakself.agree;
                [weakself.tableView reloadData];
                
                if (weakself.agree) {
                    PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq03_pay_type_confirm content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
                    [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
                }
            }else{
                
                WFWebViewController * vc = [[WFWebViewController alloc] init];
                vc.urlString = H5_loan;
                [self.jk_navigationController pushViewController:vc animated:YES];
                
                PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_pay_type content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
                 [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
            }
        }];
        return cell;
    }else{
        WFBtnCell * cell = [WFBtnCell cellWithTableView:tableView];
        [cell.btn setTitle:@"Confirmar" forState:UIControlStateNormal];
        cell.btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        WF_WEAKSELF(weakself);
        [cell setClickBtnBlock:^{
            if (weakself.agree) {
                if(weakself.clickNextBlock){
                    [weakself removeFromSuperview];
                    weakself.clickNextBlock(YES);
                }
                
            } else {
                [weakself showTip:@"Acepte la política de privacidad. "];
            }
            
            
            PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq03_loan_detail_confirm content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
            [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
            
        }];
        
        [cell.btn addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth - 30, 50) withColors:@[(id)[UIColor jk_colorWithHexString:@"#FFB602"].CGColor,(id)[UIColor jk_colorWithHexString:@"#FC7500"].CGColor] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:13];
    
        [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(0, 15, 15, 19) height:50];
        return cell;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, WF_ScreenHeight - 335 - WF_TabBarHeight, WF_ScreenWidth, 335) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor  = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}



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

////借款申请
//-(void)POSTLoanApply{
//    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
//
//    pars[@"detailed"] = self.homeModel.building;
//
//    NSMutableArray * duringArr = [NSMutableArray array];
//    for (PMHomeProductModel * model in self.homeModel.pledge) {
//
//        NSMutableDictionary * duringDic = [NSMutableDictionary dictionary];
//        duringDic[@"demanding"] = model.demanding;
//        duringDic[@"madison"] = model.flip;
//        [duringArr addObject:duringDic];
//    }
//    pars[@"during"] = duringArr;
//
//    WF_WEAKSELF(weakself);
//    [PMBaseHttp postJson:POST_Loan_Apply parameters:pars success:^(id  _Nonnull responseObject) {
//
//        if ([responseObject[@"retail"] intValue]==200) {
//            NSDictionary * shame = responseObject[@"shame"];
//
//
//        }else{
//        }
//
//
//
//    } failure:^(NSError * _Nonnull error) {
//
//    }];
//}



@end
