//
//  WFTabBarController.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/8.
//

#import "WFTabBarController.h"
#import "HomeViewController.h"
#import "MyViewController.h"

@interface WFTabBarController ()

@end

@implementation WFTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = [UIColor colorNamed:@"blueColor"];

    //首页
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    WFNavigationController *homeNVC = [[WFNavigationController alloc] initWithRootViewController:homeVC];
    homeNVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Préstamo" image:[[UIImage imageNamed:@"tabbar_home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    //我的
    MyViewController *userVC = [[MyViewController alloc] init];
    WFNavigationController *userNVC = [[WFNavigationController alloc] initWithRootViewController:userVC];
    userNVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@" Mi perfil" image:[[UIImage imageNamed:@"tabbar_user_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_user"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    self.viewControllers = @[homeNVC ,userNVC];
    
    if (@available(iOS 13.0, *)) {
            // iOS13 及以上#2C74F9
        self.tabBar.tintColor =[UIColor jk_colorWithHexString:@"#1B1200"];
        [self.tabBar setUnselectedItemTintColor:[UIColor jk_colorWithHexString:@"#CCCCCC"]];
     }else {
         // iOS13 以下
        UITabBarItem *item = [UITabBarItem appearance];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor jk_colorWithHexString:@"#CCCCCC"]} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor jk_colorWithHexString:@"#1B1200"]} forState:UIControlStateSelected];

    }
}



@end
