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

- (void)deletaLinearGradient{
    for (CALayer *layer in self.layer.sublayers) {
        if ([layer isKindOfClass:[CAGradientLayer class]]) {
            [layer removeFromSuperlayer];
            break;
        }
    }
}


+ (UIImage *)gradientImageWithSize:(CGSize)size startColor:(UIColor *)startColor endColor:(UIColor *)endColor cornerRadius:(CGFloat)cornerRadius {
    // 创建一个图形上下文，并设置大小
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    // 创建一个渐变层，并设置其位置和颜色
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.cornerRadius = cornerRadius;
    
    // 将渐变层绘制到图形上下文中
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 获取绘制后的图像
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束图形上下文
    UIGraphicsEndImageContext();
    
    // 返回生成的图片
    return image;
}
@end
