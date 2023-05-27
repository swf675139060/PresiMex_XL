//
//  WFCornerCell.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/27.
//  圆角的cell

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFCornerCell : UITableViewCell
@property(strong, nonatomic) UIView * BGView;

+(instancetype)cellWithTableView:(UITableView *)tableView;


-(void)upBGFrameWithInsets:(UIEdgeInsets )padding height:(CGFloat)height maskedCorners:(CACornerMask)maskedCorners cornerRadius:(CGFloat )cornerRadius;
@end

NS_ASSUME_NONNULL_END
