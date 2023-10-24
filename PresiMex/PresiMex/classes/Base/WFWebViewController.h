//
//  WFWebViewController.h
//  Dana Disini
//
//  Created by swf on 2021/5/15.
//

#import "WFBaseViewController.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFWebViewController : WFBaseViewController

@property (nonatomic,strong) WKWebView *webView; /**< webView */
@property (nonatomic,strong) UIProgressView *progressView; /**< 进度条view */
@property (nonatomic,copy) NSString *urlString; /**< 加载链接 */


@property (nonatomic,assign) BOOL haveHeader; 


@end

NS_ASSUME_NONNULL_END
