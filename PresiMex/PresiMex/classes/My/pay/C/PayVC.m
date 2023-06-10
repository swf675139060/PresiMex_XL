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

@interface PayVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/

@end

@implementation PayVC



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tempView addSubview:self.tableView];
    self.navTitleLabel.text = @"OXXO Cash";
    
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
        [cell.rightLabel setText:@"$ 2,500" TextColor:BColor_Hex(@"#1B1200", 1) Font:[UIFont boldSystemFontOfSize:15]];
        [cell upLineFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
        return cell;
    }else if (indexPath.row == 1) {
        WFLeftTBLbaelRightBtnCell * cell = [WFLeftTBLbaelRightBtnCell cellWithTableView:tableView];
        [cell.topLabel setText:@"Referencia：" TextColor:BColor_Hex(@"#7C7C7C", 1) Font:[UIFont systemFontOfSize:13]];
        [cell.bottomLabel setText:@"XXXXXXXXXXXXXXXXXXXX" TextColor:BColor_Hex(@"#1B1200", 1) Font:[UIFont systemFontOfSize:15]];
        
        [cell.btn addLinearGradientwithSize:CGSizeMake(85, 33) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:5];
        [cell.btn setText:@"Copiar" TextColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
        [cell.btn setImage:[UIImage imageNamed:@"fuzhi"] forState:UIControlStateNormal];
        cell.btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [cell.btn bringSubviewToFront:cell.btn.imageView];
        cell.bottomLine.hidden = NO;
        [cell upLabelsFrameWithInsets:UIEdgeInsetsMake(16, 15, 17, 10) centerSpac:14];
        
        [cell upBtnFrameWithInsets:UIEdgeInsetsMake(16, 0, 34, 15) size:CGSizeMake(85, 33)];
        [cell upLineFrameWithInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
        
        return cell;
        
    }else if (indexPath.row == 2) {
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
        cell.label.text = @"código de barras de pago：";
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#7C7C7C"];
        cell.label.font = [UIFont boldSystemFontOfSize:13];
        cell.label.textAlignment = NSTextAlignmentLeft;
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(16, 15, 20, 15)];
        return cell;
    }else if (indexPath.row == 3) {
        WFImageCell * cell = [WFImageCell cellWithTableView:tableView];
        [cell.imgV sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:nil];
        cell.bottomLine.hidden = NO;
        cell.imgV.backgroundColor = [UIColor redColor];
        [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(0, 0, 24, 0) height:65];
        return cell;
    } else {
        WFTopBtnBottomTwoLabelCell * cell = [WFTopBtnBottomTwoLabelCell cellWithTableView:tableView];
        [cell.btn setImage:[UIImage imageNamed:@"pago"] forState:UIControlStateNormal];
//        [cell.btn setBackgroundColor:[UIColor redColor]];
        [cell.label1 setText:@"El código de pago es válido durante 6 horas, organice el pago lo antes posible." TextColor:BColor_Hex(@"#7C7C7C", 1) Font:[UIFont systemFontOfSize:11]];
        
        [cell.label2 setText:@"El código de pago \n es válido durante 6 \n horas, organice el pago lo antes posible." TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:12]];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(40, 16, 30, 16)];
        cell.BGView.layer.cornerRadius = 10;
        cell.btn.backgroundColor = [UIColor whiteColor];
    
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
@end
