//
//  SLFFailedHub.h
//  SLFeedback
//
//  Created by wyzeww on 2023/1/3.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface SLFFailedHub : MBProgressHUD

/**
 初始化统一样式Hub
 @param view 加载的视图
 @param content t文案
 @param delay 显示时长
 */
+(SLFFailedHub *)showWithView:(UIView *)view content:(NSString *)content afterDelay:(NSTimeInterval)delay;


/**
 初始化统一样式Hub（window）
 @param content 文案
 @param delay 显示时长
 */
+(SLFFailedHub *)showWithContent:(NSString *)content afterDelay:(NSTimeInterval)delay;

@end

NS_ASSUME_NONNULL_END
