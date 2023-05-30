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
@end

NS_ASSUME_NONNULL_END
