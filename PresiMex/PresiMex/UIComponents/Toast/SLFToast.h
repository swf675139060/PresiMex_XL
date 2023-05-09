//
//  SLFToast.h
//  SLFeedback
//
//  Created by wyzeww on 2022/12/22.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface SLFToast : MBProgressHUD

/**
 初始化统一样式Toast
 @param view 加载的视图
 @param content toast文案
 */
+(SLFToast *)showWithView:(UIView *)view content:(NSString *)content;

/**
 初始化统一样式Toast
 @param view 加载的视图
 @param content toast文案
 @param delay 显示时长
 */
+(SLFToast *)showWithView:(UIView *)view content:(NSString *)content afterDelay:(NSTimeInterval)delay;

/**
 初始化统一样式Toast（window）
 @param content toast文案
 */
+(SLFToast *)showContent:(NSString *)content;

/**
 初始化统一样式Toast（window）
 @param content toast文案
 @param delay 显示时长
 */
+(SLFToast *)showWithContent:(NSString *)content afterDelay:(NSTimeInterval)delay;

@end

NS_ASSUME_NONNULL_END
