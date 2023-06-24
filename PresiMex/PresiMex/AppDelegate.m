//
//  AppDelegate.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/5.
//白翔龙 

#import "AppDelegate.h"
#import "WFTabBarController.h"
#import "DKGuideViewController.h"
#import "PrivacyVC.h"
#import "LNDetector.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"PrivacyVC"]) {
        self.window.rootViewController = [[WFTabBarController alloc] init];
    }else {
        self.window.rootViewController = [[PrivacyVC alloc] init];
//        self.window.rootViewController = [[DKGuideViewController alloc] init];
    }
    [self initLiveSDK];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)initLiveSDK{
    
//    [LNDetector setAppName:@"sdkTest_App" partnerCode:@"sdkTest" partnerKey:@"iGTtb2nkljVR08lYbEkv"];

}



@end
