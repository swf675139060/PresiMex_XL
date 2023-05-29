//
//  WFSliderCell.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFSliderCell : UITableViewCell

@property(strong, nonatomic) UIView * BGView;
@property(strong, nonatomic) UISlider * slider;

+(instancetype)cellWithTableView:(UITableView *)tableView;



-(void)upBGFrameWithInsets:(UIEdgeInsets )padding;

-(void)upSliderFrameWithInsets:(UIEdgeInsets )padding  height:(CGFloat)height;

-(void)setSliderValue:(CGFloat )sliderValue;

@end

NS_ASSUME_NONNULL_END
