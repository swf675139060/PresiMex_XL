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
@property (assign, nonatomic) CGFloat swf_x;
@property (assign, nonatomic) CGFloat swf_y;
@property (assign, nonatomic) CGFloat swf_w;
@property (assign, nonatomic) CGFloat swf_h;
@property (assign, nonatomic) CGSize swf_size;
@property (assign, nonatomic) CGPoint swf_origin;
@property (assign, nonatomic) CGFloat swf_centerX;
@property (assign, nonatomic) CGFloat swf_centerY;

@property (nonatomic, assign, readonly) CGFloat swf_right ;
@property (nonatomic, assign, readonly) CGFloat swf_bottom ;
/** layer borderWidth */
@property (nonatomic, assign) CGFloat swf_borderWidth ;
/** layer borderColor */
@property(nonatomic, strong) UIColor *swf_borderColor ;
/** layer cornerRadius */
@property (nonatomic, assign) CGFloat swf_cornerRadius ;


/**
 *  当前view的controller
 *
 *  @return UIViewController
 */
- (UIViewController *)viewController;
@end
