//
//  WFNavigationController.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/8.
//

#import "WFNavigationController.h"


@interface WFNavigationController ()

@end

@implementation WFNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear: animated];
//    
////    self.navigationBar.translucent = NO;
////    self.navigationBar.backgroundColor = [UIColor redColor];
////    self.navigationBar.barTintColor = [UIColor redColor];
//}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 非根控制器
        // 设置返回按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_Icon"] style:UIBarButtonItemStylePlain target:self action:@selector(WFNvigationBarLeftButtonItemClick)];
        viewController.navigationItem.leftBarButtonItem.tag = 1;
    }
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 这个方法才是真正执行跳转
    [super pushViewController:viewController animated:animated];
}

- (void)WFNvigationBarLeftButtonItemClick
{
    [self popViewControllerAnimated:YES];
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
