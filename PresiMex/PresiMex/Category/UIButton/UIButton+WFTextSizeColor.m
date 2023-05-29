//
//  UIButton+WFTextSizeColor.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/29.
//

#import "UIButton+WFTextSizeColor.h"

@implementation UIButton (WFTextSizeColor)


-(void)setText:(NSString *)text TextColor:(UIColor *)textColor Font:(UIFont *)font forState:(UIControlState)state{
    [self setTitle:text forState:state];
    [self setTitleColor:textColor forState:state];
    self.titleLabel.font = font;
}


@end
