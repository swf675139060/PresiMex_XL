//
//  UIView+SLFExtension.m
//  PesiMex
//
//  Created by PesiMex on 2022/12/5.
//

#import "UIView+SLFExtension.h"
#import <objc/runtime.h>


@implementation UIView (SLFExtension)

- (void)setSwf_x:(CGFloat)swf_x
{
    CGRect frame = self.frame;
    frame.origin.x = swf_x;
    self.frame = frame;
}

- (CGFloat)swf_x
{
    return self.frame.origin.x;
}

- (void)setSwf_y:(CGFloat)swf_y
{
    CGRect frame = self.frame;
    frame.origin.y = swf_y;
    self.frame = frame;
}

- (CGFloat)swf_y
{
    return self.frame.origin.y;
}

-(void)setSwf_w:(CGFloat)swf_w{
    CGRect frame = self.frame;
    frame.size.width = swf_w;
    self.frame = frame;
}


- (CGFloat)swf_w
{
    return self.frame.size.width;
}

- (void)setSwf_h:(CGFloat)swf_h
{
    CGRect frame = self.frame;
    frame.size.height = swf_h;
    self.frame = frame;
}

- (CGFloat)swf_h
{
    return self.frame.size.height;
}

- (void)setSwf_size:(CGSize)swf_size
{
    CGRect frame = self.frame;
    frame.size = swf_size;
    self.frame = frame;
}

- (CGSize)swf_size
{
    return self.frame.size;
}

- (void)setSwf_origin:(CGPoint)swf_origin
{
    CGRect frame = self.frame;
    frame.origin = swf_origin;
    self.frame = frame;
}

- (CGPoint)swf_origin
{
    return self.frame.origin;
}

- (void)setSwf_centerX:(CGFloat)swf_centerX
{
    CGPoint center = self.center;
    center.x = swf_centerX;
    self.center = center;
}
- (CGFloat)swf_centerX
{
    return self.center.x;
}

- (void)setSwf_centerY:(CGFloat)swf_centerY
{
    CGPoint center = self.center;
    center.y = swf_centerY;
    self.center = center;
}
- (CGFloat)swf_centerY
{
    return self.center.y;
}

- (CGFloat)swf_right
{
    return self.swf_x + self.swf_w;
}
- (CGFloat)swf_bottom
{
    return self.swf_y + self.swf_h;
}

- (void)setSwf_borderWidth:(CGFloat)swf_borderWidth
{
    self.layer.borderWidth = swf_borderWidth;
}
- (CGFloat)swf_borderWidth
{
    return self.layer.borderWidth;
}
-(void)setSwf_borderColor:(UIColor *)swf_borderColor{
    self.layer.borderColor = swf_borderColor.CGColor;
}


- (UIColor *)swf_borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setSwf_cornerRadius:(CGFloat)swf_cornerRadius
{
    self.layer.cornerRadius = swf_cornerRadius;
    [self.layer setMasksToBounds:YES];
}
- (CGFloat)swf_cornerRadius
{
    return self.layer.cornerRadius;
}


/**
 *  当前view的controller
 *
 *  @return UIViewController
 */
-(UIViewController *)viewController
{
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass:[UIViewController class]])
            return (UIViewController *)responder;
    
    return nil;
}
@end
