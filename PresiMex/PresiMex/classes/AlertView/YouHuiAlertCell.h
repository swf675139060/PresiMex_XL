//
//  YouHuiAlertCell.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/7/1.
//

#import <UIKit/UIKit.h>
#import "WFBaseView.h"
#import "CuponModel.h"
@class YouHuiAlertCellItem;

NS_ASSUME_NONNULL_BEGIN

@interface YouHuiAlertCell : UITableViewCell

@property (strong, nonatomic)YouHuiAlertCellItem * item0;

@property (strong, nonatomic)YouHuiAlertCellItem * item1;

@property (strong, nonatomic)YouHuiAlertCellItem * item2;


+(instancetype)cellWithTableView:(UITableView *)tableView;


-(void)upDateWithArr:(NSArray *)arr;


@end

@interface YouHuiAlertCellItem: WFBaseView


@property(strong, nonatomic) UILabel * label;

@end

NS_ASSUME_NONNULL_END
