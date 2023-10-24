//
//  WFjieKuanXieYiVC.m
//  PresiMex
//
//  Created by shenwenfeng on 2023/10/16.
//

#import "WFjieKuanXieYiVC.h"

@interface WFjieKuanXieYiVC ()

@end

@implementation WFjieKuanXieYiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitleLabel.text = @"Contratos de préstamo";
    
    // 创建WKWebView实例
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.tempView.frame.size.width, self.tempView.frame.size.height)];

    // 加载HTML字符串
    NSString *htmlString = self.htmlString;
//    // 对字符串进行编码转换
//     NSCharacterSet *allowedCharacterSet = [NSCharacterSet URLQueryAllowedCharacterSet];
//     NSString *encodedString = [htmlString stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
    
    [webView loadHTMLString:htmlString baseURL:nil];

    // 添加到视图中
    [self.tempView addSubview:webView];
    
}



@end
