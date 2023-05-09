//
//  WPKLoadingView.h
//  WZPlatformKit
//
//  Created by abc on 2019/4/30.
//  Copyright © 2019 Wyze. All rights reserved.
//

/**
 * 自定义loading加载 谨慎使用
 */
#import <UIKit/UIKit.h>

@interface SLFLoadingView : UIView
/** 一次动画所持续时长 默认2秒*/
@property(nonatomic,assign)NSTimeInterval duration;
/** 线条颜色*/
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat lineW;
/**
 开始动画
 */
- (void)starAnimation;

/**
 停止动画
 */
- (void)stopAnimation;

- (void)createUI;
@end
