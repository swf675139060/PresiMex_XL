////
////  JKLocationManager.m
////  OPESO
////
////  Created by 白翔龙 on 2021/11/24.
////
//
#import "JKLocationManager.h"
@interface JKLocationManager ()<CLLocationManagerDelegate>
/** 位置管理者 */
@property (nonatomic, strong) CLLocationManager *lM;

@end
@implementation JKLocationManager
//
//
+ (instancetype)manager {
    static JKLocationManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        manager.lM =[[CLLocationManager alloc] init];
        manager.lM.delegate = manager;
        [manager.lM requestWhenInUseAuthorization];
        [manager.lM startUpdatingHeading];
    });
    return manager;
}

- (CLLocationManager *)lM
{
    if (!_lM) {

        // 1. 创建位置管理者
        _lM = [[CLLocationManager alloc] init];
        // 1.1 代理, 通知, block
        _lM.delegate = self;

        // 每隔多米定位一次
//        _lM.distanceFilter = 100;
        /**
           kCLLocationAccuracyBestForNavigation // 最适合导航
           kCLLocationAccuracyBest; // 最好的
           kCLLocationAccuracyNearestTenMeters; // 10m
           kCLLocationAccuracyHundredMeters; // 100m
           kCLLocationAccuracyKilometer; // 1000m
           kCLLocationAccuracyThreeKilometers; // 3000m
         */
        // 精确度越高, 越耗电, 定位时间越长
        _lM.desiredAccuracy = kCLLocationAccuracyThreeKilometers;


        /** -------iOS8.0+定位适配-------- */

        if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
        {
            // 前台定位授权(默认情况下,不可以在后台获取位置, 勾选后台模式 location update, 但是 会出现蓝条)
            [_lM requestWhenInUseAuthorization];

        }
        [self.lM startUpdatingLocation];
        // 允许后台获取用户位置(iOS9.0)
//         if([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)
//         {
//             // 一定要勾选后台模式 location updates
//             _lM.allowsBackgroundLocationUpdates = YES;
//         }
    }
    return _lM;
}

#pragma mark - CLLocationManagerDelegate
/**
 *  更新到位置之后调用
 *
 *  @param manager   位置管理者
 *  @param locations 位置数组
 * is kind of
 */
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"定位到了%@",locations);
    CLLocation *currentLocation = [locations lastObject];
    if (self.locationM) {
        self.locationM(currentLocation);
    }
    [self.lM stopUpdatingLocation];
    CLLocationCoordinate2D coor = currentLocation.coordinate;
    //维度
    NSLog(@"coor.latitude==%f",coor.latitude);
    //经度
    NSLog(@"coor.longitude==%f",coor.longitude);

    //地理编码类
    //反编码  经纬度点-->地理位置信息
//    CLGeocoder *geoC = [[CLGeocoder alloc] init];
//    CLLocation *loc = [[CLLocation alloc] initWithLatitude:coor.latitude longitude:coor.longitude];

//    [geoC reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
////        if(error == nil)
////        {
//            NSLog(@"%@", placemarks);
//            [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                NSLog(@"%@", obj.name);
//                NSLog(@"%@", obj.locality);
//
//                [self.currPostBtn setTitle:[NSString stringWithFormat:@" %@",obj.locality ?: @""] forState:UIControlStateNormal];
//                [self.lM stopUpdatingLocation];
//            }];
//        }
   // }];
//    [self.lM stopUpdatingLocation];
}

/**
 *  授权状态发生改变时调用
 *
 *  @param manager 位置管理者
 *  @param status  状态
 */
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
            // 用户还未决定
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"用户还未决定");
            break;
        }
            // 问受限
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"访问受限");
            break;
        }
            // 定位关闭时和对此APP授权为never时调用
        case kCLAuthorizationStatusDenied:
        {
            // 定位是否可用（是否支持定位或者定位是否开启）
            if([CLLocationManager locationServicesEnabled])
            {
                NSLog(@"定位开启，但被拒");
            }else
            {
                NSLog(@"定位关闭，不可用");
            }
            NSLog(@"被拒");
            break;
        }
            // 获取前后台定位授权
        case kCLAuthorizationStatusAuthorizedAlways:
            //        case kCLAuthorizationStatusAuthorized: // 失效，不建议使用
        {
            NSLog(@"获取前后台定位授权");
            [self.lM startUpdatingLocation];

            break;
        }
            // 获得前台定位授权
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"获得前台定位授权");
            [self.lM startUpdatingLocation];
            break;
        }
        default:
            break;
    }
}

// 定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.lM stopUpdatingLocation];
    });
}
@end


