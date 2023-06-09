//
//  UILabel+WFTextSizeColour.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (WFTextSizeColor)
-(void)setText:(NSString *)text TextColor:(UIColor *)textColor Font:(UIFont *)font;
+ (CGSize)sizeWithText:(NSString *)text fontSize:(CGFloat)size andMaxsize: (CGFloat)maxWidth;
+ (CGSize)sizeWithText:(NSString *)text fontSize:(UIFont*)font;
@end

NS_ASSUME_NONNULL_END
