//
//  WFBaseViewController.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/8.
//

#import "WFBaseViewController.h"
#import "Toast+UIView.h"
#import "KeFuAlert.h"
@interface WFBaseViewController ()
@property (nonatomic, strong)UIView *hudView;

@property (nonatomic, strong)NSString *rightImage;


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
    
    self.rightImage = imgName;
    
    UIButton* button = [[UIButton alloc]init];
    [button addTarget:self action:@selector(rightItemAction) forControlEvents:(UIControlEventTouchUpInside)];
    button.frame = CGRectMake(WF_ScreenWidth-32-15, WF_StatusBarHeight+7, 32, 32);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentTrailing;
    [button setImage:[UIImage imageNamed:imgName] forState:(UIControlStateNormal)];
    [_navBarView addSubview:button];
}
-(void)rightItemAction{
    
    if ([self.rightImage isEqualToString:@"bai_kefu"]) {
        KeFuAlert * alert = [[KeFuAlert alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth - 60, 217)] ;
        alert.type = 1;
        WFCustomAlertView *  AlertView = [[WFCustomAlertView alloc] initWithContentView:alert];
        [AlertView setClickBGDismiss:YES];
        [AlertView show];
    } else {
        
    }
    
}

-(void)showKeFuAlert{
    KeFuAlert * alert = [[KeFuAlert alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth - 60, 217)] ;
    alert.type = 1;
    WFCustomAlertView *  AlertView = [[WFCustomAlertView alloc] initWithContentView:alert];
    [AlertView setClickBGDismiss:YES];
    [AlertView show];
}
-(void)show{
    
    [self dismiss];
    // 获取keyWindow
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    // 添加hud
    _hudView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, WF_ScreenHeight)];
    [_hudView setBackgroundColor:[UIColor colorWithWhite:0.2 alpha:0.2]];
    [window addSubview:_hudView];
    
    UIView *bg=[UIView new];
    [_hudView addSubview:bg];
    bg.frame=CGRectMake((WF_ScreenWidth-80)/2,WF_ScreenHeight/2, 80, 80);
    bg.backgroundColor=[UIColor colorWithWhite:0 alpha:0.8];
    bg.layer.cornerRadius=10;
    bg.layer.masksToBounds=YES;
    
    UIImageView *animationImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"peso_loading_img"]];
    [bg addSubview:animationImageView];
    animationImageView.frame=CGRectMake(20, 10, 40, 40);

    UILabel*load=[UILabel new];
    load.frame=CGRectMake(0, animationImageView.swf_bottom+5, 80, 20);
    load.text=@"loading..";
    load.textColor=[UIColor whiteColor];
    load.font=[UIFont systemFontOfSize:13];
    load.textAlignment=NSTextAlignmentCenter;
    [bg addSubview:load];
    


    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.autoreverses = NO;
    animation.fromValue    = [NSNumber numberWithFloat:0.f];
    animation.toValue      = [NSNumber numberWithFloat: M_PI *2];
    animation.duration     = 0.5; // 每秒10转，闪瞎你的眼
    animation.repeatCount  = MAXFLOAT; // 一直转
    animation.fillMode     = kCAFillModeForwards;
    [animationImageView.layer addAnimation:animation forKey:nil];
    

}


-(void)dismiss{
    // 遍历keyWindow上的CQHudView，一一移除
    for (UIView * view in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([view isEqual:_hudView]) {
            [view removeFromSuperview];
        }
    }
}

-(void)showTip:(NSString *)strMsg
{
    if (strMsg.length==0) {
        return;
    }
 [self.view makeToast: strMsg duration:1.5 position:@"center"];
    
}
@end
