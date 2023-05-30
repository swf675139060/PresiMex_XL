//
//  WFBaseViewController.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/8.
//

#import "WFBaseViewController.h"

@interface WFBaseViewController ()

@end

@implementation WFBaseViewController

// 在你的 UIViewController 子类中，重写 preferredStatusBarStyle 方法，以指定状态栏的样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self setupNavBarSubView];
    
}



-(void)setupNavBarSubView{
    
    UIView *navBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,WF_ScreenWidth,WF_NavigationHeight)];
    [self.view addSubview:navBarView];
    _navBarView=navBarView;
    NSArray *colors = @[(id)[UIColor jk_colorWithHexString:@"#FAA83C"].CGColor, (id)[UIColor jk_colorWithHexString:@"#F36F1D"].CGColor];
    [navBarView addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth, WF_NavigationHeight) withColors:colors startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0) maskedCorners:kCALayerMinXMaxYCorner cornerRadius:0];
    self.tempView=[[UIView alloc]initWithFrame:CGRectMake(0, WF_NavigationHeight, WF_ScreenWidth, WF_ScreenHeight-WF_NavigationHeight)];
    [self.view addSubview:self.tempView];
    self.tempView.backgroundColor=[UIColor whiteColor];
    [self setBackBarButtonWithTheme:1];
    self.navTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(_backBtn.swf_right, WF_StatusBarHeight+12, WF_ScreenWidth-100, 20)];
    self.navTitleLabel.textColor=[UIColor whiteColor];
    self.navTitleLabel.font=B_FONT_MEDIUM(18);
    self.navTitleLabel.swf_centerX=WF_ScreenWidth/2;
    self.navTitleLabel.textAlignment=NSTextAlignmentCenter;
    [_navBarView addSubview:self.navTitleLabel];
}
-(void)setBackBarButtonWithTheme:(NSInteger)type{
    UIButton* button = [[UIButton alloc]init];
    button.titleLabel.font = B_FONT_REGULAR(16);
    [button addTarget:self action:@selector(leftItemAction) forControlEvents:(UIControlEventTouchUpInside)];
    button.frame = CGRectMake(15, WF_StatusBarHeight+7, 32, 32);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeading;
    NSString* imgName = @"";
    if (type == 0) {
        imgName = @"nav_back_hei";
    }else if (type == 1){
        imgName = @"back_Icon";
    }
    [button setImage:[UIImage imageNamed:imgName] forState:(UIControlStateNormal)];
    [_navBarView addSubview:button];
    _backBtn=button;
}
-(void)leftItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)hiddenLeftItem{
    UIBarButtonItem *temporaryBarButtonItem =[[UIBarButtonItem alloc]init];
    temporaryBarButtonItem.title = @"";
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
}
-(void)addRightBarButtonWithImag:(NSString*)imgName{
    
    UIButton* button = [[UIButton alloc]init];
    [button addTarget:self action:@selector(rightItemAction) forControlEvents:(UIControlEventTouchUpInside)];
    button.frame = CGRectMake(WF_ScreenWidth-32-15, WF_StatusBarHeight+7, 32, 32);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentTrailing;
    [button setImage:[UIImage imageNamed:imgName] forState:(UIControlStateNormal)];
    [_navBarView addSubview:button];
}
-(void)rightItemAction{
    
}
@end
