//
//  SLFLoadingView.h
//  PesiMex
//
//  Created by swf on 2022/12/22.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface SLFLoadingHub : MBProgressHUD

/**
 初始化统一样式Loading
 @param view 加载的视图
 */
+(SLFLoadingHub *)showLoadingWithView:(UIView *)view;

/**
 初始化统一样式Loading（window）
 */
+(SLFLoadingHub *)showLoading;


@end

NS_ASSUME_NONNULL_END
