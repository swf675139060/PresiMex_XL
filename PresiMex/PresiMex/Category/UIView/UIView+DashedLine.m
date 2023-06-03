//
//  UIView+DashedLine.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/3.
//

#import "UIView+DashedLine.h"

@implementation UIView (DashedLine)

- (void)drawDashedLineFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint withColor:(UIColor *)color dashLengths:(NSArray<NSNumber *> *)dashLengths {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, 2);
    CGFloat lengths[dashLengths.count];
    for (int i = 0; i < dashLengths.count; i++) {
        lengths[i] = [dashLengths[i] floatValue];
    }
    CGContextSetLineDash(context, 0, lengths, dashLengths.count);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextStrokePath(context);
}

@end
