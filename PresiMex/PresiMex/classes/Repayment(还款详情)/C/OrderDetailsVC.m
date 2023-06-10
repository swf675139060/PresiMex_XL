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

@interface OrderDetailsVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/

@property (nonatomic, strong) PMOrderTopView *topView;


@property (nonatomic, strong) NSMutableArray *leftArr;

@property (nonatomic, strong) NSMutableArray *rightArr;

@property (nonatomic, assign) BOOL beOverdue;//是否逾期

@property (nonatomic, assign) NSInteger indx;

@end

@implementation OrderDetailsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tempView addSubview:self.topView];
    WF_WEAKSELF(weakself);
    [self.topView setClickLeftBtnBlock:^{
        weakself.indx = 0;
        [weakself.tableView reloadData];
        
        
    }];
    [self.topView setClickRightBtnBlock:^{
        weakself.indx = 1;
        [weakself.tableView reloadData];
        
    }];
    [self.tempView addSubview:self.tableView];
    self.navTitleLabel.text = @"Lista de facturas";
    
    [self GETUserOder];
    
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
        [cell.rightLabel setText:@"Producto" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
        return cell;
    }else if (indexPath.row == 1) {
        WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 15, 7.5, 15)];
        [cell.leftLabel setText:@"Principal:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
        [cell.rightLabel setText:@"Principal:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
        return cell;
    }else if (indexPath.row == 2) {
        WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 15, 7.5, 15)];
        [cell.leftLabel setText:@"Fecha de vencimiento:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
        [cell.rightLabel setText:@"Fecha de vencimiento:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
        return cell;
    }else if (indexPath.row == 3) {
        WFLeftRightLabelCell * cell = [WFLeftRightLabelCell bottomLineCellWithTableView:tableView];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 15, 14.5, 15)];
        cell.bottomLine.hidden = NO;
        [cell.leftLabel setText:@"Días de mora:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
        [cell.rightLabel setText:@"Días de mora:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
        [cell upLineFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
        return cell;
    }else if (indexPath.row == 4) {
        WFThreeBtnCell * cell = [WFThreeBtnCell cellWithTableView:tableView];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) height:46.5-7.5];

        [cell.leftBtn setText:@"Cargo por mora:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13] forState:UIControlStateNormal];
        [cell.centerBtn setText:[NSString stringWithFormat:@"$%@",@"000"] TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13] forState:UIControlStateNormal];
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
            WFThreeBtnCell * cell = [WFThreeBtnCell cellWithTableView:tableView];
            [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) height:46.5-7.5];

            [cell.leftBtn setText:@"cupón:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13] forState:UIControlStateNormal];
            [cell.centerBtn setText:[NSString stringWithFormat:@"$%@",@"000"] TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13] forState:UIControlStateNormal];
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
            
            
            return cell;
        }else{
            WFEmptyCell * cell = [WFEmptyCell cellWithTableView:tableView];
            return cell;
        }
    }else if (indexPath.row == 6) {
        if(self.indx == 0){
            WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView];
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 15, 14.5, 15)];
            [cell.leftLabel setText:@"Pagado:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
            [cell.rightLabel setText:@"Pagado:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
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
                WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView];
                [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 15, 14.5, 15)];
                [cell.leftLabel setText:@"Cantidad reducida:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
                [cell.rightLabel setText:@"Cantidad reducida:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
                [cell upLineFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
                return cell;
            }
        }else{
            WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView identifier:@"2Line"];
            UIEdgeInsets padding = UIEdgeInsetsMake(10, 15, 14.5, 15);
            [cell upLabelFrameWithInsets:padding];
            [cell.leftLabel setText:@"Fecha de vencimiento después de la extensión" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
            [cell.rightLabel setText:@"10-03-2023" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
            cell.leftLabel.numberOfLines = 2;
            [cell.leftLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@(padding.left));
                make.top.equalTo(@(padding.top));
                make.bottom.equalTo(@(-padding.bottom));
                make.width.lessThanOrEqualTo(@(200));

            }];
            return cell;
            
        }
        
        
    }else if (indexPath.row == 8) {
        if (self.indx == 0) {
            WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView];
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 15, 14.5, 15)];
            [cell.leftLabel setText:@"Pago en total:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
            [cell.rightLabel setText:@"$ 1,300" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
            return cell;
        } else {
            
            WFLeftRightLabelCell * cell = [WFLeftRightLabelCell cellWithTableView:tableView];
            [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 15, 14.5, 15)];
            if(self.beOverdue == YES){
                
                [cell.leftLabel setText:@"Cuentas pendientes durante la prórroga:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
                [cell.rightLabel setText:@"$ 1,300" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
            }else{
                
                [cell.leftLabel setText:@"Pago en total:" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:13]];
                [cell.rightLabel setText:@"$ 1,300" TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont boldSystemFontOfSize:13]];
            }
            return cell;
        }
       
        
        
    }else if (indexPath.row == 9) {
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView identifier:@"line"];
        cell.label.text = @"";
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 0, 0, 0)];
        cell.BGView.backgroundColor = BColor_Hex(@"#F1F1F1", 1);
        return cell;
    }else if (indexPath.row == 10) {
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
        cell.label.text = @"Por favor seleccione su método de pago";
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#1B1200"];
        cell.label.font = [UIFont boldSystemFontOfSize:15];
        cell.label.textAlignment = NSTextAlignmentLeft;
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(20, 15, 20, 15)];
        return cell;
    }else if (indexPath.row == 11) {

        WFLeftRightBtnCell * cell = [WFLeftRightBtnCell cellWithTableView:tableView];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15) height:50];
        [cell upBtnsFrameWithEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 15)];
        [cell.leftBtn setTitle:@"VA" forState:UIControlStateNormal];
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
        WFBtnCell * cell = [WFBtnCell cellWithTableView:tableView];
        [cell.btn setTitle:@"Pagar" forState:UIControlStateNormal];
        cell.btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        WF_WEAKSELF(weakself);
        [cell setClickBtnBlock:^{
            PayVC * vc = [[PayVC alloc] init];
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
//    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    
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

-(NSMutableArray *)leftArr{
    if(_leftArr == nil){
        _leftArr = [NSMutableArray array];
    }
    return _leftArr;
}

-(NSMutableArray *)rightArr{
    if(_rightArr == nil){
        _rightArr = [NSMutableArray array];
    }
    return _rightArr;
}


//获取用户订单接口
-(void)GETUserOder{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
  
    if (self.indx) {
        pars[@"cos"] = @"0";
    } else {
        pars[@"cos"] = @"1";
    }
    WF_WEAKSELF(weakself);
    [PMBaseHttp get:GET_User_Oder parameters:pars success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"retail"] intValue]==200) {
            NSDictionary * shame = responseObject[@"shame"];
            
            
        }else{
            [weakself.view showTip:responseObject[@"entire"]];
        }
        
        
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

@end
