//
//  ConfirmAccountVC.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/17.
//

#import "ConfirmAccountVC.h"
#import "bankcardCell.h"
#import "WFLeftRightBtnCell.h"

@interface ConfirmAccountVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/


@end

@implementation ConfirmAccountVC



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tempView addSubview:self.tableView];
    self.navTitleLabel.text = @"Confirmacion de cuen";
    
    [self GETCouponUrl];
    
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
        [cell.leftBtn setTitle:@"Confirmar" forState:UIControlStateNormal];
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
           
            
        }];
        return cell;
    }
    
    
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
-(void)GETCouponUrl{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
//    pars[@"eg"] = [NSString stringWithFormat:@"%ld",self.eg];
//    pars[@"patricia"] = @"100";
    WF_WEAKSELF(weakself);
    [PMBaseHttp get:GET_Coupon_Url parameters:pars success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"retail"] intValue]==200) {
            NSDictionary * shame = responseObject[@"shame"];
            
            
        }else{
            
        }
        
        [weakself.tableView.mj_footer endRefreshing];
        
        
    } failure:^(NSError * _Nonnull error) {
        
        [weakself.tableView.mj_footer endRefreshing];
        
    }];
}

@end
