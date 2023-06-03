//
//  WFFourLabelCell.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/30.
//   ---------------------------------------
//   |                  |                  |
//   |      label1      |      label2     |
//   |                  |                  |
//   |      label3      |      label4     |
//   |                  |                  |
//   ---------------------------------------


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFFourLabelCell : UITableViewCell

@property(strong, nonatomic) UIView * BGView;
@property(strong, nonatomic) UILabel * label1;
@property(strong, nonatomic) UILabel * label2;
@property(strong, nonatomic) UILabel * label3;
@property(strong, nonatomic) UILabel * label4;

+(instancetype)cellWithTableView:(UITableView *)tableView;



-(void)upBGFrameWithInsets:(UIEdgeInsets )padding;

-(void)upLabelsFrameWithInsets:(UIEdgeInsets )padding spacing:(CGFloat)spacing;

-(void)upDataWithModel:(id)model;



@end

NS_ASSUME_NONNULL_END
