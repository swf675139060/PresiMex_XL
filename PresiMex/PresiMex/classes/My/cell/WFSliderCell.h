//
//  WFSliderCell.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/29.
//

#import <UIKit/UIKit.h>
#import "WFSlider.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFSliderCell : UITableViewCell

@property(strong, nonatomic) UIView * BGView;
@property(strong, nonatomic) WFSlider * slider;
@property(strong, nonatomic) UIView * sliderBG;


@property(copy, nonatomic)void(^sliderChangeBlock)(NSInteger number);

@property(copy, nonatomic)void(^sliderEndBlock)(NSInteger number);

+(instancetype)cellWithTableView:(UITableView *)tableView;



-(void)upBGFrameWithInsets:(UIEdgeInsets )padding height:(CGFloat)height;

-(void)upSliderFrameWithInsets:(UIEdgeInsets )padding height:(CGFloat)height;

-(void)setSliderValue:(CGFloat )sliderValue;

@end

NS_ASSUME_NONNULL_END
