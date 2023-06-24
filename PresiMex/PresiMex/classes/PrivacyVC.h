//
//  PrivacyVC.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/23.
//

#import "WFBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PrivacyVC : WFBaseViewController

@property (nonatomic,strong) WKWebView *webView; /**< webView */
@property (nonatomic,strong) UIProgressView *progressView; /**< 进度条view */
@end

NS_ASSUME_NONNULL_END
