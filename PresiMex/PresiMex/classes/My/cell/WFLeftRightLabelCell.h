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

+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;

+(instancetype)bottomLineCellWithTableView:(UITableView *)tableView;



-(void)upBGFrameWithInsets:(UIEdgeInsets )padding height:(CGFloat)height;

-(void)upLabelFrameWithInsets:(UIEdgeInsets )padding;
-(void)upLineFrameWithInsets:(UIEdgeInsets )padding;


@end

NS_ASSUME_NONNULL_END
