//
//  CommentsPopView.h
//  Douyin
//
//  Created by Tang TianCheng 
//  Copyright © 2018年 Qiao Shi. All rights reserved.
//  

#import <UIKit/UIKit.h>


@interface SLFCommentsPopView:UIView

/// 弹出框初始化
/// @param frame 黑色背景的尺寸
/// @param contentView 弹出框视图
/// @param needScroView  如果添加的view里有滑动控件传NO、反之传Yes
+ (instancetype)commentsPopViewWithFrame:(CGRect)frame contentView:(UIView *)contentView contentViewNeedScroView:(BOOL)needScroView;

/// 显示要显示的View
/// @param view 需要被显示在哪里
/// @param title 内容标题
- (void)showToView:(UIView *)view titileStr:(NSString *)title;

- (void)showWithTitileStr:(NSString *)title;

- (void)clickBGHiden:(BOOL)hiden;

/// 关闭
- (void)dismiss;

@end






