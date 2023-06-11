//
//  UIView+LinearGradient.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/20.
//  添加变色的背景色

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LinearGradient)



- (void)addLinearGradientwithSize:(CGSize )Size withColors:(NSArray *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint maskedCorners:(CACornerMask)maskedCorners cornerRadius:(CGFloat)cornerRadius;


- (void)addLinearGradientwithSize:(CGSize )Size maskedCorners:(CACornerMask)maskedCorners cornerRadius:(CGFloat)cornerRadius;

- (void)deletaLinearGradient;

//通过颜色生成带颜色和圆角的图片
+ (UIImage *)gradientImageWithSize:(CGSize)size startColor:(UIColor *)startColor endColor:(UIColor *)endColor cornerRadius:(CGFloat)cornerRadius;
@end

NS_ASSUME_NONNULL_END
