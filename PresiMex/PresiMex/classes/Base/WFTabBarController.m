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
    homeNVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"home" image:[[UIImage imageNamed:@"tabbar_home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    //我的
    MyViewController *userVC = [[MyViewController alloc] init];
    WFNavigationController *userNVC = [[WFNavigationController alloc] initWithRootViewController:userVC];
    userNVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"my" image:[[UIImage imageNamed:@"tabbar_user_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_user"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    self.viewControllers = @[homeNVC ,userNVC];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
