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
//#import "PMAddBankViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    [self getCrashLog];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"PrivacyVC"]) {
        self.window.rootViewController = [[WFTabBarController alloc] init];
    }else {
        self.window.rootViewController = [[PrivacyVC alloc] init];
//        self.window.rootViewController = [[DKGuideViewController alloc] init];
    }
//    [self initLiveSDK];
    [self.window makeKeyAndVisible];
    
    
    //打开app客户端
    PMDeviceModel * model =[PMDeviceModel sharedInstance];
    
    PMLocationManager * LocationManager  = [PMLocationManager sharedInstance];
    __weak typeof(model) weakModel = model;
    [LocationManager creatLocation:^(BOOL isLocation) {
        [weakModel GetDate];
        [[PMDotManager sharedInstance] POSTDotDevType:20 value:weakModel];
    }];
    
    
    //APP启动页
    PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_app_start content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
    [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
    
//    NSArray * aa = @[];
//    NSString * bb = aa[4];
    return YES;
}




void uncaughtExceptionHandler(NSException *exception) {
    NSString *exceptionLevel = @"Error"; // 设置异常级别为 "Error"
    NSString *exceptionType = [NSString stringWithFormat:@"%@", exception];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    NSString *exceptionTime = [dateFormatter stringFromDate:[NSDate date]];
    NSArray *callStack = [exception callStackSymbols];
    NSString *exceptionDetail = [NSString stringWithFormat:@"Exception: %@\n\nCall Stack:\n%@", exceptionType, [callStack componentsJoinedByString:@"\n"]];
    
    NSDictionary * crashDic = @{@"ksnsg8a":exceptionLevel,@"kvb7ks":exceptionType,@"vjsks9aso":[PMACQInfoModel GetTimestampString],@"mbchsu1zw":exceptionDetail};
    
   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:crashDic forKey:@"crashDic"];
    

}

-(void)getCrashLog{
    
   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * crashDic =[defaults  objectForKey:@"crashDic"];
    
    if(crashDic && [crashDic isKindOfClass:[NSDictionary class]]){
        
        [[PMDotManager sharedInstance] POSTDotCrashDic:crashDic];
        [self deleteLog];
    }
  
}


-(void)deleteLog{
//    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"crash.log"];
//    NSError *error;
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    if (![fileManager removeItemAtPath:filePath error:&error]) {
//        NSLog(@"Error deleting crash report file: %@", error);
//    }
    
    
    
   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"crashDic"];
}
@end
