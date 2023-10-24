//
//  WFWebViewController.m
//  Dana Disini
//
//  Created by swf on 2021/5/15.
//

#import "WFWebViewController.h"
#import "MD5Utils.h"

@interface WFWebViewController ()<WKNavigationDelegate,WKUIDelegate>


@end

@implementation WFWebViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self.tempView addSubview:self.webView];
    
    //进度条
    [self.tempView addSubview:self.progressView];
    
    //加载
    [self loadRequest];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    _webView.frame = self.tempView.bounds;
    
    //计算y 轴坐标
    CGFloat originY = 0;
    //如果状态栏没有隐藏
    if (![UIApplication sharedApplication].statusBarHidden) {
        originY = 0;
    }
    //如果navigationBar 没有隐藏
    if (!self.navigationController.navigationBarHidden) {
        originY += CGRectGetHeight(self.navigationController.navigationBar.frame);
    }
    
    _progressView.frame = CGRectMake(0, originY, CGRectGetWidth(self.view.frame), 2.5);
    
    //scrollView contentInset
    UIEdgeInsets insets = UIEdgeInsetsMake(originY, 0, WF_BottomSafeAreaHeight, 0);
    _webView.scrollView.contentInset = insets;
    _webView.scrollView.scrollIndicatorInsets = insets;
}

-(void)dealloc
{
    //移除监听
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView removeObserver:self forKeyPath:@"title"];
    
    
}

#pragma data - WKNavigationDelegate
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (error.code == NSURLErrorCancelled) {
        return;
    }
    
    if (error.code == 911) {
        
    }
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (error.code == NSURLErrorCancelled) {
        return;
    }
    
    if (error.code == 911) {
        
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    //如果是安卓下载文件
    if ([[navigationAction.request.URL absoluteString] hasSuffix:@".apk"]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    //如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        
        if (self.navigationController) {
            WFWebViewController *webVC = [[WFWebViewController alloc] init];
            webVC.urlString = [navigationAction.request.URL absoluteString];
            webVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webVC animated:YES];
            
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }else {
            [webView loadRequest:navigationAction.request];
        }
    }
    
    //如果不是http https www
    NSString *absoluteString = [navigationAction.request.URL absoluteString];
    if (![absoluteString hasPrefix:@"http://"] && ![absoluteString hasPrefix:@"https://"] && ![absoluteString hasPrefix:@"www"]) {
        
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL options:@{} completionHandler:nil];

        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark -- UIDelegate
-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    
    if (navigationAction.targetFrame == nil) {

        if (self.navigationController) {

            WFWebViewController *webVC = [[WFWebViewController alloc] init];
            webVC.urlString = [navigationAction.request.URL absoluteString];
            webVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webVC animated:YES];
        }else {
            [webView loadRequest:navigationAction.request];
        }
    }
    
    return nil;
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:webView.title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    //确定按钮
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }];
    [alertController addAction:action];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:webView.title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    //确定按钮
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }];
    [alertController addAction:action];
    
    //取消
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:webView.title message:prompt preferredStyle:UIAlertControllerStyleAlert];
    
    //文本输入框
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = defaultText;
    }];
    
    //确定按钮
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields.firstObject.text);
    }];
    [alertController addAction:action];
    
    //取消
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -- WKWebView 监听
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    //进度
    if([keyPath isEqualToString:@"estimatedProgress"])
    {
        CGFloat progress = [change[NSKeyValueChangeNewKey] floatValue];
        [self.progressView setProgress:progress animated:YES];
        
        if (progress == 1.0) {
            __weak typeof(self) weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
   
                [weakSelf.progressView setProgress:0.0 animated:NO];
            });
        }
        
        return;
    }
    
    //title
    if ([keyPath isEqualToString:@"title"]) {
        NSString *title = change[NSKeyValueChangeNewKey];
        if (!self.navTitleLabel.text) {
            self.navTitleLabel.text = title;
        }
        
        return;
    }
}

/// 加载请求
- (void)loadRequest
{
    if (!self.urlString || self.urlString.length == 0) return;

    NSURL *url = [NSURL URLWithString:[self.urlString stringByAddingPercentEscapesUsingEncoding:kCFStringEncodingUTF8]];
        
    
    if (url) {
        [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
}

#pragma mark--懒加载
-(WKWebView*)webView
{
    if (!_webView) {

        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        WKPreferences *preferences = [[WKPreferences alloc] init];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        config.selectionGranularity = YES;
        config.allowsInlineMediaPlayback = YES;
        config.preferences = preferences;
        
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];

        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
                
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        if (@available(iOS 13.0, *)) self.webView.scrollView.automaticallyAdjustsScrollIndicatorInsets = NO;
        
        //监听网页 进度
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        //监听网页标题
        [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _webView;
}

-(UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] init];
        _progressView.trackTintColor = [UIColor clearColor];
        _progressView.progressTintColor = [UIColor colorNamed:@"blueColor"];
        [_progressView setProgress:0.0 animated:YES];
    }
    
    return _progressView;
}


@end
