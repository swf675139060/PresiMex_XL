//
//  WFLabelCell.h
//  RVIHome
//
//  Created by shenWenFeng on 2023/4/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFLabelCell : UITableViewCell

@property(strong, nonatomic) UIView * BGView;
@property(strong, nonatomic) UILabel * label;
@property(strong, nonatomic) UIView * bottomLine;

+(instancetype)cellWithTableView:(UITableView *)tableView;


+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;



-(void)upBGFrameWithInsets:(UIEdgeInsets )padding;

-(void)upLabelFrameWithInsets:(UIEdgeInsets )padding;

-(void)setLabelText:(NSString *)text;





//创建有圆角的cell
+(instancetype)cornerCellWithTableView:(UITableView *)tableView;

-(void)upBGFrameWithInsets:(UIEdgeInsets )padding maskedCorners:(CACornerMask)maskedCorners cornerRadius:(CGFloat)cornerRadius;
@end

NS_ASSUME_NONNULL_END
