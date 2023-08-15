//
//  AccesoPermisosView.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/7/8.
//

#import "AccesoPermisosView.h"
#import "WFLabelCell.h"
#import "WFBtnCell.h"


@interface AccesoPermisosView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/

@end

@implementation AccesoPermisosView

-(void)setTitles:(NSArray *)titles{
    _titles = titles;
    [self.tableView reloadData];
    
}

-(void)buildSubViews{
    
    self.urlString = H5_permission;
    CGFloat height = MIN(500, WF_ScreenHeight - WF_NavigationHeight);
    
    self.frame = CGRectMake(0, 0, WF_ScreenWidth, height);
    [self addSubview:self.webView];
    [self addSubview:self.tableView];
    
    //加载
    [self loadRequest];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.top.equalTo(self.webView.mas_bottom);
    }];

}


#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WFBtnCell * cell = [WFBtnCell cellWithTableView:tableView];
    [cell.btn setTitle:@"OK" forState:UIControlStateNormal];
    cell.btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    WF_WEAKSELF(weakself);
    [cell setClickBtnBlock:^{
        if(weakself.selectBlock){
            weakself.selectBlock();
        }
    }];
    [cell.btn addLinearGradientwithSize:CGSizeMake(self.jk_width - 30, 50) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:13];
    [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(15, 15, 25, 15) height:50];
    return cell;

    
}



#pragma mark -- init


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
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, self.jk_height - 90) configuration:config];

        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        if (@available(iOS 13.0, *)) self.webView.scrollView.automaticallyAdjustsScrollIndicatorInsets = NO;
        
    }
    return _webView;
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor  = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    return _tableView;
}

@end
