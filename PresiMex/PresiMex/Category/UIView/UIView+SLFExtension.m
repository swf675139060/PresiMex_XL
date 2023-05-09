//
//  UIView+SLFExtension.m
//  SLFeedback
//
//  Created by SLFeedback on 2022/12/5.
//

#import "UIView+SLFExtension.h"
#import <objc/runtime.h>


@implementation UIView (SLFExtension)

- (void)setSlf_x:(CGFloat)slf_x
{
    CGRect frame = self.frame;
    frame.origin.x = slf_x;
    self.frame = frame;
}

- (CGFloat)slf_x
{
    return self.frame.origin.x;
}

- (void)setSlf_y:(CGFloat)slf_y
{
    CGRect frame = self.frame;
    frame.origin.y = slf_y;
    self.frame = frame;
}

- (CGFloat)slf_y
{
    return self.frame.origin.y;
}

- (void)setSlf_w:(CGFloat)slf_w
{
    CGRect frame = self.frame;
    frame.size.width = slf_w;
    self.frame = frame;
}

- (CGFloat)slf_w
{
    return self.frame.size.width;
}

- (void)setSlf_h:(CGFloat)slf_h
{
    CGRect frame = self.frame;
    frame.size.height = slf_h;
    self.frame = frame;
}

- (CGFloat)slf_h
{
    return self.frame.size.height;
}

- (void)setSlf_size:(CGSize)slf_size
{
    CGRect frame = self.frame;
    frame.size = slf_size;
    self.frame = frame;
}

- (CGSize)slf_size
{
    return self.frame.size;
}

- (void)setSlf_origin:(CGPoint)slf_origin
{
    CGRect frame = self.frame;
    frame.origin = slf_origin;
    self.frame = frame;
}

- (CGPoint)slf_origin
{
    return self.frame.origin;
}

- (void)setSlf_centerX:(CGFloat)slf_centerX
{
    CGPoint center = self.center;
    center.x = slf_centerX;
    self.center = center;
}
- (CGFloat)slf_centerX
{
    return self.center.x;
}

- (void)setSlf_centerY:(CGFloat)slf_centerY
{
    CGPoint center = self.center;
    center.y = slf_centerY;
    self.center = center;
}
- (CGFloat)slf_centerY
{
    return self.center.y;
}

- (CGFloat)slf_right
{
    return self.slf_x + self.slf_w;
}
- (CGFloat)slf_bottom
{
    return self.slf_y + self.slf_h;
}
- (void)setSlf_borderWidth:(CGFloat)slf_borderWidth
{
    self.layer.borderWidth = slf_borderWidth;
}
- (CGFloat)slf_borderWidth
{
    return self.layer.borderWidth;
}

- (void)setSlf_borderColor:(UIColor *)slf_borderColor
{
    self.layer.borderColor = slf_borderColor.CGColor;
}

- (UIColor *)slf_borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setSlf_cornerRadius:(CGFloat)slf_cornerRadius
{
    self.layer.cornerRadius = slf_cornerRadius;
    [self.layer setMasksToBounds:YES];
}
- (CGFloat)slf_cornerRadius
{
    return self.layer.cornerRadius;
}

@end
