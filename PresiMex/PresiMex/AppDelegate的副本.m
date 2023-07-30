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
#import <UserNotifications/UserNotifications.h>
#import <AppsFlyerLib/AppsFlyerLib.h>
#import "Firebase.h"
#import "FirebaseMessaging.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate,FIRMessagingDelegate>


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
    
    if ([FIRApp defaultApp] == nil) {
        [FIRApp configure];
        [FIRMessaging messaging].delegate = self;
    }
    // Override point for customization after application launch.
    /** APPSFLYER INIT **/
    [AppsFlyerLib shared].appsFlyerDevKey = @"wYBVFjnrp84FxAUNLLzbz";
    [AppsFlyerLib shared].appleAppID = @"1615372217";
    /* Uncomment the following line to see AppsFlyer debug logs */
    [AppsFlyerLib shared].isDebug = true;
    [[AppsFlyerLib shared] logEvent: @"ios_pesoOnline_home" withValues:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
         selector:@selector(sendLaunch:)
         name:UIApplicationDidBecomeActiveNotification
         object:nil];
        if (@available(iOS 10, *)) {
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            center.delegate = self;
            [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            }];
        }
    
        else {
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        }
    
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[AppsFlyerLib shared]  logEvent: AFEventAddToWishlist withValues: @{
            AFEventParamPrice: @20,
            AFEventParamContentId: @"123456"
        }];
        [[AppsFlyerLib shared] startWithCompletionHandler:^(NSDictionary<NSString *,id> *dictionary, NSError *error) {
                if (error) {
                    NSLog(@"%@", error);
                    return;
                }
                if (dictionary) {
                    NSLog(@"%@", dictionary);
                    return;
                }
        }];
        [[AppsFlyerLib shared]  logEvent: @"ios_pesoOnline_Luch" withValues:nil];
        // 谷歌推送相关
        [self setUpFirebaseConfigure];
    
    
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

   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"crashDic"];
}




- (void)setUpFirebaseConfigure {
    // 初始化配置
    //[FIRApp configure];
//    [FIRMessaging messaging].delegate = self;
   
    // 注册接受远程通知
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
       
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
            }
        }];
    } else {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
}

#pragma mark - FIRMessagingDelegate
// 获取注册令牌
- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {

    NSLog(@"fcmToken->=%@", fcmToken);
    
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:fcmToken forKey:@"token"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FCMToken" object:nil userInfo:dataDict];
//
//    [[NSUserDefaults standardUserDefaults] setObject:fcmToken forKey:kFCMToken];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    // 登录状态
//    if (isLogin) {
//       // 上传token到服务器
//       ...
//    }
}

// Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
//- (void)messaging:(FIRMessaging *)messaging didReceiveMessage:(FIRMessagingRemoteMessage *)remoteMessage {
//    NSLog(@"Received data message: %@", remoteMessage.appData);
//}

// 接收通知消息
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSString *type = userInfo[@"type"];
    
    completionHandler(UIBackgroundFetchResultNewData);
    if(application.applicationState == UIApplicationStateInactive) {
       // 点击调转页面
       //...
    }
}

#pragma mark - UNUserNotificationCenterDelegate
// app处在前台收到推送消息执行的方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)) {
    NSDictionary *userInfo = notification.request.content.userInfo;
    NSLog(@"userInfo -> %@", userInfo);
    // type = 0，跳转...
    completionHandler(UNNotificationPresentationOptionAlert);
}

// ios 10以后系统，app处在后台，点击通知栏 app执行的方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    
    NSLog(@"userInfo -> %@", userInfo);
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
//        return;
    }
    // type = 0，跳转...
   // ...
    completionHandler();
}
// With "FirebaseAppDelegateProxyEnabled": NO
- (void)application:(UIApplication *)application
    didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [FIRMessaging messaging].APNSToken = deviceToken;
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
  NSLog(@"Unable to register for remote notifications: %@", error);
}
////#pragma mark  --branch
//-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
//  [[Branch getInstance] application:app openURL:url options:options];
//  return YES;
//}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler {
  // handler for Universal Links
  
  return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
  // handler for Push Notifications
  
}
//以下代码是推送的所有配置代码
//NSString *const kGCMMessageIDKey = @"gcm.message_id";
//
//- (BOOL)application:(UIApplication *)application
//    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//  // [START configure_firebase]
//  [FIRApp configure];
//  // [END configure_firebase]
//
//  // [START set_messaging_delegate]
//  [FIRMessaging messaging].delegate = self;
//  // [END set_messaging_delegate]
//
//  // Register for remote notifications. This shows a permission dialog on first run, to
//  // show the dialog at a more appropriate time move this registration accordingly.
//  // [START register_for_notifications]
//  if ([UNUserNotificationCenter class] != nil) {
//    // iOS 10 or later
//    // For iOS 10 display notification (sent via APNS)
//    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
//    UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
//        UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
//    [[UNUserNotificationCenter currentNotificationCenter]
//        requestAuthorizationWithOptions:authOptions
//        completionHandler:^(BOOL granted, NSError * _Nullable error) {
//          // ...
//        }];
//  } else {
//    // iOS 10 notifications aren't available; fall back to iOS 8-9 notifications.
//    UIUserNotificationType allNotificationTypes =
//    (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
//    UIUserNotificationSettings *settings =
//    [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
//    [application registerUserNotificationSettings:settings];
//  }
//
//  [application registerForRemoteNotifications];
//  // [END register_for_notifications]
//
//  return YES;
//}
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//  // If you are receiving a notification message while your app is in the background,
//  // this callback will not be fired till the user taps on the notification launching the application.
//  // TODO: Handle data of notification
//
//  // With swizzling disabled you must let Messaging know about the message, for Analytics
//  // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
//
//  // [START_EXCLUDE]
//  // Print message ID.
//  if (userInfo[kGCMMessageIDKey]) {
//    NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
//  }
//  // [END_EXCLUDE]
//
//  // Print full message.
//  NSLog(@"%@", userInfo);
//}
//
//// [START receive_message]
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//    fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//  // If you are receiving a notification message while your app is in the background,
//  // this callback will not be fired till the user taps on the notification launching the application.
//  // TODO: Handle data of notification
//
//  // With swizzling disabled you must let Messaging know about the message, for Analytics
//  // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
//
//  // [START_EXCLUDE]
//  // Print message ID.
//  if (userInfo[kGCMMessageIDKey]) {
//    NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
//  }
//  // [END_EXCLUDE]
//
//  // Print full message.
//  NSLog(@"%@", userInfo);
//
//  completionHandler(UIBackgroundFetchResultNewData);
//}
//// [END receive_message]
//
//// [START ios_10_message_handling]
//// Receive displayed notifications for iOS 10 devices.
//// Handle incoming notification messages while app is in the foreground.
//- (void)userNotificationCenter:(UNUserNotificationCenter *)center
//       willPresentNotification:(UNNotification *)notification
//         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
//  NSDictionary *userInfo = notification.request.content.userInfo;
//
//  // With swizzling disabled you must let Messaging know about the message, for Analytics
//  // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
//
//  // [START_EXCLUDE]
//  // Print message ID.
//  if (userInfo[kGCMMessageIDKey]) {
//    NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
//  }
//  // [END_EXCLUDE]
//
//  // Print full message.
//  NSLog(@"%@", userInfo);
//
//  // Change this to your preferred presentation option
//  completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionAlert);
//}
//
//// Handle notification messages after display notification is tapped by the user.
//- (void)userNotificationCenter:(UNUserNotificationCenter *)center
//didReceiveNotificationResponse:(UNNotificationResponse *)response
//         withCompletionHandler:(void(^)(void))completionHandler {
//  NSDictionary *userInfo = response.notification.request.content.userInfo;
//  if (userInfo[kGCMMessageIDKey]) {
//    NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
//  }
//
//  // With swizzling disabled you must let Messaging know about the message, for Analytics
//  // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
//
//  // Print full message.
//  NSLog(@"%@", userInfo);
//
//  completionHandler();
//}
//
//// [END ios_10_message_handling]
//
//// [START refresh_token]
//- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
//    NSLog(@"FCM registration token: %@", fcmToken);
//    // Notify about received token.
//    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:fcmToken forKey:@"token"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:
//     @"FCMToken" object:nil userInfo:dataDict];
//    // TODO: If necessary send token to application server.
//    // Note: This callback is fired at each app startup and whenever a new token is generated.
//}
//// [END refresh_token]
//
//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//  NSLog(@"Unable to register for remote notifications: %@", error);
//}
//
//// This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
//// If swizzling is disabled then this function must be implemented so that the APNs device token can be paired to
//// the FCM registration token.
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//  NSLog(@"APNs device token retrieved: %@", deviceToken);
//
//  // With swizzling disabled you must set the APNs device token here.
//  // [FIRMessaging messaging].APNSToken = deviceToken;
//}

@end
