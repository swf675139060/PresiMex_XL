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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

// 在你的 UIViewController 子类中，重写 preferredStatusBarStyle 方法，以指定状态栏的样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
