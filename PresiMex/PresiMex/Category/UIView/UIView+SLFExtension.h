//
//  UIView+SLFExtension.h
//  WZPlatformKit
//
//  Created by SLFeedback on 2022/12/5.
//

/**
 * UIView 扩展的视图布局的属性
 */
#import <UIKit/UIKit.h>

@interface UIView (SLFExtension)
@property (assign, nonatomic) CGFloat slf_x;
@property (assign, nonatomic) CGFloat slf_y;
@property (assign, nonatomic) CGFloat slf_w;
@property (assign, nonatomic) CGFloat slf_h;
@property (assign, nonatomic) CGSize slf_size;
@property (assign, nonatomic) CGPoint slf_origin;
@property (assign, nonatomic) CGFloat slf_centerX;
@property (assign, nonatomic) CGFloat slf_centerY;

@property (nonatomic, assign, readonly) CGFloat slf_right ;
@property (nonatomic, assign, readonly) CGFloat slf_bottom ;
/** layer borderWidth */
@property (nonatomic, assign) CGFloat slf_borderWidth ;
/** layer borderColor */
@property(nonatomic, strong) UIColor *slf_borderColor ;
/** layer cornerRadius */
@property (nonatomic, assign) CGFloat slf_cornerRadius ;


/**
 *  当前view的controller
 *
 *  @return UIViewController
 */
- (UIViewController *)viewController;
@end
