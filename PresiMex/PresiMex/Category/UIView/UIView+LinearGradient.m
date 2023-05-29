//
//  UIView+LinearGradient.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/20.
//

#import "UIView+LinearGradient.h"

@implementation UIView (LinearGradient)



-(void)addLinearGradientwithSize:(CGSize )Size withColors:(NSArray *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint  maskedCorners:(CACornerMask)maskedCorners cornerRadius:(CGFloat)cornerRadius{
    CAGradientLayer *gradientLayer = nil;
    for (CALayer *layer in self.layer.sublayers) {
        if ([layer isKindOfClass:[CAGradientLayer class]]) {
            gradientLayer = (CAGradientLayer *)layer;
            break;
        }
    }
    if (gradientLayer == nil) {
        gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, Size.width, Size.height);
        gradientLayer.colors = colors;
        gradientLayer.startPoint = startPoint;
        gradientLayer.endPoint = endPoint;
        gradientLayer.maskedCorners = maskedCorners;
        gradientLayer.cornerRadius = cornerRadius;
        gradientLayer.masksToBounds = YES;
        [self.layer insertSublayer:gradientLayer atIndex:0];
    } else {
        gradientLayer.maskedCorners = maskedCorners;
        gradientLayer.cornerRadius = cornerRadius;
        gradientLayer.masksToBounds = YES;
        gradientLayer.colors = colors;
        gradientLayer.startPoint = startPoint;
        gradientLayer.endPoint = endPoint;
    }
}

- (void)addLinearGradientwithSize:(CGSize )Size maskedCorners:(CACornerMask)maskedCorners cornerRadius:(CGFloat)cornerRadius{
    
    
    NSArray *colors = @[(id)[UIColor jk_colorWithHexString:@"#FFB602"].CGColor, (id)[UIColor jk_colorWithHexString:@"#FC7500"].CGColor];
    [self addLinearGradientwithSize:Size withColors:colors startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0) maskedCorners:maskedCorners cornerRadius:cornerRadius];
    
}

@end
