//
//  DKGuideViewController.m
//  Dana Disini
//
//  Created by swf on 2021/5/31.
//

#import "DKGuideViewController.h"
#import "AppDelegate.h"
#import "WFTabbarController.h"

@interface DKGuideViewController ()

@property (nonatomic, strong) UIScrollView *scrollView; //滚动试图
@property (nonatomic,strong) UIButton *button; /**< 按钮*/

@end

@implementation DKGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.scrollView];
    
    [self.view addSubview:self.button];
}

#pragma mark -- dk_buttonClick
- (void)dk_buttonClick
{
    //设置已经启动过
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLaunched"];
    
    AppDelegate *deletage = (AppDelegate *)[UIApplication sharedApplication].delegate;
    deletage.window.rootViewController = [[WFTabBarController alloc] init];
}

#pragma mark -- init
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;

        _scrollView.contentSize = CGSizeMake(_scrollView.jk_width*3, _scrollView.jk_height);
        
        NSArray<NSString *> *names = @[@"guide_01", @"guide_02", @"guide_03"];
        for (int i = 0; i < names.count; i ++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*_scrollView.jk_width, 0, _scrollView.jk_width, _scrollView.jk_height)];
            imageView.backgroundColor = [UIColor whiteColor];
            UIImage *image = [UIImage imageNamed:names[i]];
            image = [image stretchableImageWithLeftCapWidth:image.size.width-1 topCapHeight:image.size.height-1];
            imageView.image = image;
//            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.clipsToBounds = YES;
            [_scrollView addSubview:imageView];
        }
    }
    
    return _scrollView;
}

- (UIButton *)button
{
    if (!_button) {
        _button = [[UIButton alloc] initWithFrame:CGRectMake((self.view.jk_width-120)/2.0, self.view.jk_height - WF_BottomSafeAreaHeight -120, 120, 40)];
        [_button setTitle:WFLocalizedString(@"进入") forState:UIControlStateNormal];
        [_button setBackgroundImage:[UIImage jk_imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor colorNamed:@"blueColor"] forState:UIControlStateNormal];
        _button.layer.cornerRadius = _button.jk_height/2.0;
        _button.layer.masksToBounds = YES;
        _button.layer.borderColor = [UIColor colorNamed:@"blueColor"].CGColor;
        _button.layer.borderWidth = 1.0;
        [_button addTarget:self action:@selector(dk_buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button;
}

@end
