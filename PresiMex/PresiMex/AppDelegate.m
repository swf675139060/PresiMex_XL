//
//  AppDelegate.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/5.
//白翔龙 

#import "AppDelegate.h"
#import "WFTabBarController.h"
#import "DKGuideViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLaunched"]) {
        self.window.rootViewController = [[WFTabBarController alloc] init];
//    }else {
//        self.window.rootViewController = [[DKGuideViewController alloc] init];
//    }
    
    [self.window makeKeyAndVisible];
    return YES;
}



@end
