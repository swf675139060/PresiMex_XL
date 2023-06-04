//
//  WFLeftImageTwolabelCell.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/3.
//   ---------------------------------------
//   |     ______                          |
//   |    |      |   label2                |
//   |    |      |                         |
//   |    |______|   label4                |
//   |                                     |
//   ---------------------------------------

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFLeftImageTwolabelCell : UITableViewCell


@property(strong, nonatomic) UIView * BGView;

@property(strong, nonatomic) UIImageView * imageV;

@property(strong, nonatomic) UILabel * topLabel;

@property(strong, nonatomic) UILabel * bottomLabel;


+(instancetype)cellWithTableView:(UITableView *)tableView;


//更新背景的边距
-(void)upBGFrameWithInsets:(UIEdgeInsets )padding;

-(void)upImageFrameWithInsets:(UIEdgeInsets )padding  height:(CGFloat)height;

-(void)upLabelsFrameWithInsets:(UIEdgeInsets )padding;

@end

NS_ASSUME_NONNULL_END
