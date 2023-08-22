//
//  PrivacyVC.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/23.
//

#import "PrivacyVC.h"
#import "WFLeftRightBtnCell.h"
#import "WFBtnCell.h"
#import "WFTabBarController.h"

@interface PrivacyVC ()<WKNavigationDelegate,WKUIDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableViewBottom; /**< 底部视图*/


@property (nonatomic, assign) BOOL agree;

@end

@implementation PrivacyVC


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
//    self.agree = YES;
    self.backBtn.hidden = YES;
    [self.tempView addSubview:self.webView];
    [self.tempView addSubview:self.tableViewBottom];
    
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
    NSURL *url = [NSURL URLWithString:H5_privacy];
        
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
        CGFloat height = 9+50+13.5+14+10;
//        _tableViewBottom = [[UITableView alloc] initWithFrame:CGRectMake(0, WF_ScreenHeight - WF_NavigationHeight - height - WF_BottomSafeAreaHeight, WF_ScreenWidth, height + WF_BottomSafeAreaHeight)
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, WF_NavigationHeight, WF_ScreenWidth, WF_ScreenHeight - height - WF_NavigationHeight) configuration:config];

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
        _progressView.progressTintColor = [UIColor whiteColor];
        [_progressView setProgress:0.0 animated:YES];
    }
    
    return _progressView;
}




#pragma mark -- UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 2;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
   
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)  {
        
        WFLeftRightBtnCell * cell = [WFLeftRightBtnCell cellWithTableView:tableView];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(10, 5, 13.5, 15) height:17];
        [cell.leftBtn setTitle:@"" forState:UIControlStateNormal];
        if (self.agree) {
            [cell.leftBtn setImage:[UIImage imageNamed:@"gouxuan"] forState:UIControlStateNormal];
        } else {
            [cell.leftBtn setImage:[UIImage imageNamed:@"gouxuanNO"] forState:UIControlStateNormal];
        }
       
        NSString * Text = @"He leído y acepto el \"Acuerdo de privacidad\" anterior.";
        
        [cell.rightBtn setText:Text TextColor:BColor_Hex(@"#A8A8A8", 1) Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
        cell.rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:Text attributes: @{NSFontAttributeName:B_FONT_REGULAR(11),NSForegroundColorAttributeName: BColor_Hex(@"#A8A8A8", 1)}];
        
        NSRange range=[Text rangeOfString:@"Acuerdo de privacidad"];
        [attStr addAttributes:@{NSForegroundColorAttributeName: BColor_Hex(@"#A8A8A8", 1)} range:range];
        [cell.rightBtn setAttributedTitle:attStr forState:UIControlStateNormal];
        
        [cell.leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(0));
            make.top.equalTo(@(0));
            make.bottom.equalTo(@(0));
//            make.height.equalTo(@(17));
            make.width.equalTo(@(37));

        }];
        
        [cell.rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-15));
            make.top.equalTo(@(0));
            make.bottom.equalTo(@(0));
            make.left.equalTo(cell.leftBtn.mas_right);
            
        }];
        
        WF_WEAKSELF(weakself);
        [cell setClickBtnBlock:^(NSInteger indx) {
            if (indx == 0) {
                weakself.agree = !weakself.agree;
                [weakself.tableViewBottom reloadData];
            }
        }];
        return cell;
    }else{
//
        WFBtnCell * cell = [WFBtnCell cellWithTableView:tableView];
        [cell.btn setTitle:@"Confirmar" forState:UIControlStateNormal];
        cell.btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        WF_WEAKSELF(weakself);
        [cell setClickBtnBlock:^{
            if (weakself.agree) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"PrivacyVC"];
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                window.rootViewController = [[WFTabBarController alloc] init];
                
            } else {
                [weakself showTip:@"Acepte la política de privacidad. "];
            }
        }];
        
        [cell.btn addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth - 30, 50) withColors:@[(id)[UIColor jk_colorWithHexString:@"#FFB602"].CGColor,(id)[UIColor jk_colorWithHexString:@"#FC7500"].CGColor] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:13];
    
        [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(0, 15, 9, 15) height:50];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    
}

-(void)clickBtn{
    
}

#pragma mark -- init


- (UITableView *)tableViewBottom
{
    if (!_tableViewBottom) {
        CGFloat height = 9+50+13.5+14+10;
        _tableViewBottom = [[UITableView alloc] initWithFrame:CGRectMake(0, WF_ScreenHeight - WF_NavigationHeight - height - WF_BottomSafeAreaHeight, WF_ScreenWidth, height + WF_BottomSafeAreaHeight) style:UITableViewStyleGrouped];
        _tableViewBottom.tag = 1;
        _tableViewBottom.scrollEnabled = NO;
        _tableViewBottom.delegate = self;
        _tableViewBottom.dataSource = self;
        _tableViewBottom.backgroundColor  = [UIColor whiteColor];
        _tableViewBottom.tableFooterView = [[UIView alloc] init];
        _tableViewBottom.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableViewBottom.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableViewBottom jk_shadowWithColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1] offset:CGSizeMake(0,1) opacity:1 radius:5];
    }
    
    return _tableViewBottom;
}


@end
