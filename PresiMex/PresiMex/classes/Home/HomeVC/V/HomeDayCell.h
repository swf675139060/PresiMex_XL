//
//  HomeDayCell.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/10.
//

#import <UIKit/UIKit.h>
#import "WFBaseView.h"

@class HomeDayCellItem;

NS_ASSUME_NONNULL_BEGIN

@interface HomeDayCell : UITableViewCell
@property(strong, nonatomic) UIView * BGView;
@property(strong, nonatomic) HomeDayCellItem * leftItem;
@property(strong, nonatomic) HomeDayCellItem * rightItem;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end


@interface HomeDayCellItem : WFBaseView



@property (nonatomic, strong) UIImageView *bgImageView;
@property(strong, nonatomic) UILabel * topLabel;
@property(strong, nonatomic) UILabel * bottomLabel;

@end

NS_ASSUME_NONNULL_END
