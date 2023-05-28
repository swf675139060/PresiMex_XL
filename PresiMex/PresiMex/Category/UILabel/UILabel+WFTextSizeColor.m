//
//  UILabel+WFTextSizeColour.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/27.
//

#import "UILabel+WFTextSizeColor.h"

@implementation UILabel (WFTextSizeColor)

-(void)setText:(NSString *)text TextColor:(UIColor *)textColor Font:(UIFont *)font{
    self.text = text;
    self.textColor = textColor;
    self.font = font;
}

@end
