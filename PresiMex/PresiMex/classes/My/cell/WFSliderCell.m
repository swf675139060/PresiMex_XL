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
    
    [self.BGView addSubview:self.sliderBG];
    [self.BGView addSubview:self.slider];
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
        
    }];
    
    
    UIEdgeInsets LBPadding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.BGView).with.insets(LBPadding);
        
    }];
    
//    UIEdgeInsets sliderPadding = UIEdgeInsetsMake(0, 0, 0, 0);
//    [self.sliderBG mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.BGView).with.insets(LBPadding);
//
//    }];
    
}

-(UIView *)BGView{
    if(_BGView == nil){
        _BGView = [[UIView alloc] init];
    }
    return _BGView;
}

-(WFSlider *)slider{
    if(_slider == nil){
        _slider = [[WFSlider alloc] init];
        _slider.minimumValue = 0;
        _slider.maximumValue = 100;
        _slider.thumbTintColor = [UIColor jk_colorWithHexString:@"#FFB602"];
        _slider.minimumTrackTintColor = [UIColor whiteColor];
        [_slider setThumbImage:[UIImage imageNamed:@"Track"] forState:UIControlStateNormal];
        [_slider setThumbImage:[UIImage imageNamed:@"Track"] forState:UIControlStateHighlighted];
        
        [_slider addTarget:self action:@selector(sliderEventValueChanged:) forControlEvents:UIControlEventValueChanged];
        [_slider addTarget:self action:@selector(sliderEventValueEnd:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _slider;
}

-(UIView *)sliderBG{
    if(_sliderBG == nil){
        _sliderBG = [[UIView alloc] init];
        _sliderBG.backgroundColor = [UIColor whiteColor];
        _sliderBG.layer.cornerRadius = 4;
        _sliderBG.layer.masksToBounds = YES;
        
    }
    return _sliderBG;
}


-(void)upBGFrameWithInsets:(UIEdgeInsets )padding height:(CGFloat)height{
    [self.BGView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
        make.height.equalTo(@(height));
    }];
}


-(void)upSliderFrameWithInsets:(UIEdgeInsets )padding height:(CGFloat)height{
    [self.slider mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.BGView).with.insets(padding);
        make.height.equalTo(@(height));
    }];
}

-(void)sliderEventValueChanged:(UISlider *)slider{
    if(self.sliderChangeBlock){
        
        float value = roundf(slider.value / 100) * 100;
        self.sliderChangeBlock(value);
    }
}

-(void)sliderEventValueEnd:(UISlider *)slider{
    if(self.sliderEndBlock){
        
        float value = roundf(slider.value / 100) * 100;
        self.sliderEndBlock(value);
    }
}

-(void)setSliderValue:(CGFloat )sliderValue{
    self.slider.value = sliderValue;
}



@end
