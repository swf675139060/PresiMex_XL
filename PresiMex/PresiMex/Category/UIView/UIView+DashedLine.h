//
//  UIView+DashedLine.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/3.
//  画虚线

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (DashedLine)

- (void)drawDashedLineFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint withColor:(UIColor *)color dashLengths:(NSArray<NSNumber *> *)dashLengths;
@end

NS_ASSUME_NONNULL_END
