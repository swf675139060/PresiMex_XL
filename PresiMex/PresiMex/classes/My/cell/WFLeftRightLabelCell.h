//
//  WFLeftRightLabelCell.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFLeftRightLabelCell : UITableViewCell

@property(strong, nonatomic) UIView * BGView;
@property(strong, nonatomic) UILabel * leftLabel;
@property(strong, nonatomic) UILabel * rightLabel;
@property(strong, nonatomic) UIView * bottomLine;

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(instancetype)bottomLineCellWithTableView:(UITableView *)tableView;



-(void)upBGFrameWithInsets:(UIEdgeInsets )padding height:(CGFloat)height;

-(void)upLabelFrameWithInsets:(UIEdgeInsets )padding;



@end

NS_ASSUME_NONNULL_END
