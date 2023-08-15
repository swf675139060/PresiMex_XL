//
//  HomeNoAuthView.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/10.
//

#import "HomeNoAuthView.h"
#import "WFLeftRightBtnCell.h"
#import "WFLabelCell.h"
#import "WFSliderCell.h"
#import "WFThreeBtnCell.h"
#import "HomeSectionView.h"
#import "WFBtnCell.h"
#import "WFImageCell.h"
#import "HomeDayCell.h"
#import "FlowPathCell.h"
#import "KeFuAlert.h"

#import "PMCertificationCoreViewController.h"

@interface HomeNoAuthView ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UIImageView *bgImageView;
@end

@implementation HomeNoAuthView

-(void)buildSubViews{
    [self addSubview:self.tableView];
    self.tableView.backgroundView = self.bgImageView;
}

-(void)addBgImageView{
    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
//        make.top.equalTo(self).offset(-88);
        make.bottom.equalTo(cell.contentView);
        
    }];
}
#pragma mark -- UITableViewDelegate,UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        
    return 9;
        
  
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
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        WFLeftRightBtnCell * cell = [WFLeftRightBtnCell cellWithTableView:tableView];
        [cell upBtnsFrameWithEdgeInsets:UIEdgeInsetsMake(15, 16, 0, 16)];
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
        WFLabelCell * cell  = [WFLabelCell cellWithTableView:tableView identifier:@"1"];
        cell.label.textAlignment = NSTextAlignmentLeft;
        [cell.label setText:@"Al finalizar la verificación, podrá acceder a un crédito de hasta $30,000." TextColor:BColor_Hex(@"#7C7C7C", 1) Font:[UIFont systemFontOfSize:13]];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(5.5, 15, 16, 15)];
      
        return cell;
        
        
    }else if (indexPath.row == 2){
        WFLabelCell * cell  = [WFLabelCell cornerCellWithTableView:tableView];
        cell.label.textAlignment = NSTextAlignmentLeft;
        [cell.label setText:@"Hasta" TextColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:13]];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15) maskedCorners: kCALayerMinXMinYCorner | kCALayerMinXMinYCorner cornerRadius:15];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 15, 5, 15)];
        [cell.BGView addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth-30, 33) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner cornerRadius:15];
        
        
        return cell;
        
        
    }else if (indexPath.row == 3){
        WFLabelCell * cell  = [WFLabelCell cellWithTableView:tableView identifier:@"22"];
        cell.label.textAlignment = NSTextAlignmentCenter;
        [cell.label setText:[NSString stringWithFormat:@"30,000"] TextColor:[UIColor whiteColor] Font:[UIFont boldSystemFontOfSize:25]];
        
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(2, 15, 5, 15)];
        
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
        [cell.BGView addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth-30, 37) maskedCorners:kCALayerMinXMinYCorner cornerRadius:0.1];
        
        
        return cell;
        
        
    }else if (indexPath.row == 4){
        WFSliderCell * cell  = [WFSliderCell cellWithTableView:tableView];
        
        
        cell.slider.userInteractionEnabled = NO;
        cell.slider.maximumValue = 30000;
        cell.slider.minimumValue = 500;
        cell.slider.value = 30000;
        
        [cell.slider trackRectForBounds:CGRectMake(0, 0, WF_ScreenWidth - 30, 8)];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15) height:25];
        [cell upSliderFrameWithInsets:UIEdgeInsetsMake(8, 15, 0, 15) height:16];
        [cell.BGView addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth-30, 25) maskedCorners:kCALayerMinXMinYCorner cornerRadius:0.1];
        WF_WEAKSELF(weakself);
        cell.sliderChangeBlock = ^(NSInteger number) {
//            weakself.changeValue = number;
            
            NSIndexPath * IndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
            [weakself.tableView reloadRowsAtIndexPaths:@[IndexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        return cell;
        
        
    }else if (indexPath.row == 5){
        WFThreeBtnCell * cell = [WFThreeBtnCell cellWithTableView:tableView];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15) height:24.5];
        [cell upBtnsFrameWithInsets:UIEdgeInsetsMake(10, 15, 13.5, 15)];
        [cell.BGView addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth-30, 25) maskedCorners:kCALayerMinXMinYCorner cornerRadius:0.1];
        
        [cell.centerBtn setText:@"" TextColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
        
        
        [cell.leftBtn setText:@"$500" TextColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
        [cell.rightBtn setText:@"$30,000" TextColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
        return cell;
        
    }else if (indexPath.row == 6){
        HomeDayCell * cell = [HomeDayCell cellWithTableView:tableView];
        cell.leftItem.topLabel.text = @"Plazo";
        cell.leftItem.bottomLabel.text = @"91días - 210días";
        cell.rightItem.topLabel.text = @"Tasa de interés";
        cell.rightItem.bottomLabel.text = @"0.05%/día";
        return cell;
    }else if (indexPath.row == 7){
        WFBtnCell * cell = [WFBtnCell cellWithTableView:tableView];
        
        
        if([PMAccountTool isLogin]){
            [cell.btn setTitle:@"Autenticar" forState:UIControlStateNormal];
        }else{
            [cell.btn setTitle:@"Iniciar Sesión" forState:UIControlStateNormal];
        }
        cell.btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        WF_WEAKSELF(weakself);
        [cell setClickBtnBlock:^{
            if(weakself.clickBock){
                weakself.clickBock();
            }
        }];
        [cell.btn addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth - 30, 50) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:13];
        [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(0, 15, 35, 15) height:50];
        return cell;
    }else{
        FlowPathCell * cell = [FlowPathCell cellWithTableView:tableView];
      
        return cell;
        
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


-(void)showKeFuAlert{
    KeFuAlert * alert = [[KeFuAlert alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth - 60, 217)] ;
    alert.type = 1;
    WFCustomAlertView *  AlertView = [[WFCustomAlertView alloc] initWithContentView:alert];
    [AlertView setClickBGDismiss:YES];
    [AlertView show];
}

#pragma mark -- init
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, self.jk_height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor  = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

-(UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = [UIImage imageNamed:@"homeBG"];
        _bgImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _bgImageView;
}


@end
