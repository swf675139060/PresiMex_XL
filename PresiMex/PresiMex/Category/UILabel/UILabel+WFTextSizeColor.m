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
+ (CGSize)sizeWithText:(NSString *)text fontSize:(CGFloat)size andMaxsize: (CGFloat)maxWidth {
    
    NSDictionary *arrts = @{NSFontAttributeName: [UIFont systemFontOfSize:size]};
    CGSize biggestSize = CGSizeMake(maxWidth, MAXFLOAT);
    
    return [text boundingRectWithSize:biggestSize options:NSStringDrawingUsesLineFragmentOrigin attributes:arrts context:nil].size;
}
+ (CGSize)sizeWithText:(NSString *)text fontSize:(UIFont*)font{
    
    NSMutableDictionary *arrts = [NSMutableDictionary dictionary];
    arrts[NSFontAttributeName] =font;
    return [text sizeWithAttributes:arrts];
}
@end
