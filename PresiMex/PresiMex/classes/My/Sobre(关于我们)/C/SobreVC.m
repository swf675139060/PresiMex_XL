//
//  SobreVC.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/27.
//  关于我们

#import "SobreVC.h"
#import "WFLabelCell.h"
#import "WFImageCell.h"
#import "WFBtnCell.h"
#import "WFCornerCell.h"

@interface SobreVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/


@end

@implementation SobreVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tempView addSubview:self.tableView];
    self.navTitleLabel.text = @"Sobre nosotros";
    
}


#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        WFImageCell * cell = [WFImageCell cellWithTableView:tableView];
        cell.imgV.image = [UIImage imageNamed:@"PPPP"];
        CGFloat imgVWidth = 75;
        [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(36, (WF_ScreenWidth - imgVWidth)/2, 19, (WF_ScreenWidth - imgVWidth)/2) height:75];
        return cell;
    }else if(indexPath.row == 1){
        WFImageCell * cell = [WFImageCell cellWithTableView:tableView];
        cell.imgV.image = [UIImage imageNamed:@"PresiMex"];
        cell.imgV.backgroundColor = [UIColor whiteColor];
        CGFloat imgVWidth = 92;
        [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(0, (WF_ScreenWidth - imgVWidth)/2, 20, (WF_ScreenWidth - imgVWidth)/2) height:18];
        return cell;
    }
    else if(indexPath.row == 2){
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
        cell.label.text = @"CashiMex es una plataforma de préstamos en línea que opera en México. Estamos comprometidos a brindar servicios de préstamo en línea convenientes y eficientes para usuarios mexicanos elegibles";
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#1B1200"];
        cell.label.font = [UIFont systemFontOfSize:13];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(0, 29, 0, 29)];
        return cell;
    }else if (indexPath.row == 3){
        WFCornerCell * cell = [WFCornerCell cellWithTableView:tableView];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(20, 25, 0, 25) height:14 maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner cornerRadius:7];
        cell.BGView.backgroundColor = [UIColor jk_colorWithHexString:@"#FCFCFB"];
        return cell;
    }else if (indexPath.row == 4){
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
        NSString * String = @"Sitio web oficial：";
        cell.label.text = String;
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#7C7C7C"];
        cell.label.font = [UIFont systemFontOfSize:12];
        
        cell.BGView.backgroundColor = [UIColor jk_colorWithHexString:@"#FCFCFB"];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 25, 0, 25)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(0, 14, 0, 14)];
        return cell;
    }else if (indexPath.row == 5){
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
        cell.label.text = @"XXXXXwww.cashimex.mx";
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#008DFC"];
        cell.label.font = [UIFont systemFontOfSize:12];
        cell.BGView.backgroundColor = [UIColor jk_colorWithHexString:@"#FCFCFB"];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 25, 0, 25)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 14, 0, 14)];
        return cell;

    }else if (indexPath.row == 6){
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
        NSString * String = @"Correo electrónico：";
        cell.label.text = String;
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#7C7C7C"];
        cell.label.font = [UIFont systemFontOfSize:12];
        
        cell.BGView.backgroundColor = [UIColor jk_colorWithHexString:@"#FCFCFB"];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 25, 0, 25)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(15, 14, 0, 14)];
        return cell;
    }else if (indexPath.row == 7){
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
        cell.label.text = @"service@cashimex.mx";
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#1B1200"];
        cell.label.font = [UIFont boldSystemFontOfSize:12];
        cell.BGView.backgroundColor = [UIColor jk_colorWithHexString:@"#FCFCFB"];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 25, 0, 25)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 14, 0, 14)];
        return cell;

    }else if (indexPath.row == 8){
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
        NSString * String = @"Domicilio social";
        cell.label.text = String;
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#7C7C7C"];
        cell.label.font = [UIFont systemFontOfSize:12];
        
        cell.BGView.backgroundColor = [UIColor jk_colorWithHexString:@"#FCFCFB"];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 25, 0, 25)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(15, 14, 0, 14)];
        return cell;
    }else if (indexPath.row == 9){
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
        cell.label.text = @"Patricio Sanz 1609 Piso8, Del Valle Sur, Benito Juárez, Ciudad de México, C.P. 03100.";
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#1B1200"];
        cell.label.font = [UIFont boldSystemFontOfSize:12];
        cell.BGView.backgroundColor = [UIColor jk_colorWithHexString:@"#FCFCFB"];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 25, 0, 25)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(10, 14, 0, 14)];
        return cell;

    }else if (indexPath.row == 10){
        WFCornerCell * cell = [WFCornerCell cellWithTableView:tableView];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 25, 0, 25) height:14 maskedCorners:kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:7];
        cell.BGView.backgroundColor = [UIColor jk_colorWithHexString:@"#FCFCFB"];
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
