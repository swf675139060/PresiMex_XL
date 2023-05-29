//
//  WFSliderCell.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/29.
//

#import "WFSliderCell.h"

@implementation WFSliderCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *ID = @"WFSliderCell";
    
    WFSliderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WFSliderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell creatSubView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


-(void)creatSubView{
    [self.contentView addSubview:self.BGView];
    
    [self.BGView addSubview:self.slider];
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
        
    }];
    
    
    UIEdgeInsets LBPadding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.BGView).with.insets(LBPadding);
        
    }];
    
}

-(UIView *)BGView{
    if(_BGView == nil){
        _BGView = [[UIView alloc] init];
    }
    return _BGView;
}

-(UISlider *)slider{
    if(_slider == nil){
        _slider = [[UISlider alloc] init];
        _slider.minimumValue = 0;
        _slider.maximumValue = 100;
    }
    return _slider;
}

//// 设置最大值
//- (CGRect)maximumValueImageRectForBounds:(CGRect)bounds
//{
//    return CGRectMake(0, 0, CGRectGetWidth(self.frame)/ 2, CGRectGetHeight(self.frame) / 2);
//}
//// 设置最小值
//- (CGRect)minimumValueImageRectForBounds:(CGRect)bounds
//{
//    return CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
//}
//
//// 控制slider的宽和高，这个方法才是真正的改变slider滑道的高的
//- (CGRect)trackRectForBounds:(CGRect)bounds
//{
//    return CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
//}
 
//// 改变滑块的触摸范围
//- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
//{
//    return CGRectInset([super thumbRectForBounds:bounds trackRect:rect value:value], 10, 10);
//}


-(void)upBGFrameWithInsets:(UIEdgeInsets )padding{
    [self.BGView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
    }];
}


-(void)upSliderFrameWithInsets:(UIEdgeInsets )padding height:(CGFloat)height{
    [self.slider mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.BGView).with.insets(padding);
        make.height.equalTo(@(height));
    }];
}

-(void)setSliderValue:(CGFloat )sliderValue{
    self.slider.value = sliderValue;
}


@end
