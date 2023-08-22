//
//  PMLocationManager.m
//  PresiMex
//
//  Created by shenwenfeng on 2023/7/23.
//

#import "PMLocationManager.h"
#import <CoreLocation/CoreLocation.h>
@interface PMLocationManager()<CLLocationManagerDelegate>

//定位完成/失败
@property (nonatomic, copy)void(^LocationBlock)(BOOL isLocation);

@property (nonatomic, strong) NSTimer *timer;


@end

@implementation PMLocationManager



+ (PMLocationManager *)sharedInstance {
    static PMLocationManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        
        sharedInstance.locationManager =[[CLLocationManager alloc] init];
        sharedInstance.locationManager.delegate = sharedInstance;
    });
    return sharedInstance;
}

-(void)creatShowAlert:(BOOL)show LocationBlock:(void (^)(BOOL isLocation)) LocationBlock{
    
    self.LocationBlock = LocationBlock;
    
    if(self.haveLocation){
        //定位过直接返回
        self.LocationBlock(YES);
        return;
    }
    
    
     CLAuthorizationStatus status = [PrivateInfo LocationStatus];
    if (show) {
        self.locationManager.delegate = self;
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startUpdatingLocation];
        
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(queryStatus) userInfo:nil repeats:YES];
    } else {
        
        if (status == AVAuthorizationStatusAuthorized || status == kCLAuthorizationStatusAuthorizedWhenInUse ||status == kCLAuthorizationStatusAuthorizedAlways) {
//            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
            [self.locationManager requestWhenInUseAuthorization];
            [self.locationManager startUpdatingLocation];
        }else{
            if (self.LocationBlock) {
                self.haveLocation = YES;
                self.haveSend = YES;
                self.LocationBlock(NO);
            }
        }
    }
   

    
    
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = locations.lastObject;
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    self.longitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
    
    self.latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
    
    WF_WEAKSELF(weakself);

    [self getStreetForLocation:location completionHandler:^(NSString *province, NSString *City, NSString *Street, NSError *error) {
      
        weakself.gpsAddressProvince = province;
        weakself.gpsAddressCity = City;
        weakself.gpsAddressStreet = Street;
        
        [weakself locationCom];
    }];
    
    [self.locationManager stopUpdatingLocation];
}

//定位信息是否完成
-(void)locationCom{
    if (self.gpsAddressStreet && self.gpsAddressCity  && self.gpsAddressProvince ) {
        if (self.LocationBlock && self.haveLocation == NO) {
            self.haveLocation = YES;
            self.haveSend = YES;
            self.LocationBlock(YES);
        }
    }
}


// 获取GPS地址街道
- (void)getStreetForLocation:(CLLocation *)location completionHandler:(void (^)(NSString *province, NSString *City, NSString *Street, NSError *error))completionHandler {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            completionHandler(nil,nil,nil, error);
            return;
        }
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks.firstObject;
            NSString *administrativeArea = placemark.administrativeArea;
            NSString *street = placemark.thoroughfare;
            NSString *city = placemark.locality ? placemark.locality : placemark.administrativeArea;
            if (!administrativeArea) {
                administrativeArea = @"";
            }
            if (!city) {
                city = @"";
            }
            if (!street) {
                street = @"";
            }
            
            completionHandler(administrativeArea,city,street, nil);
        } else {
            completionHandler(nil,nil,nil, nil);
        }
    }];
}


- (void)queryStatus {
//    // 在这里执行查询状态的操作
//    CLAuthorizationStatus locationStatus = [CLLocationManager authorizationStatus];
//     if (locationStatus != kCLAuthorizationStatusNotDetermined) {
//         self.locationManager.delegate = self;
//         [self.locationManager startUpdatingLocation];
//         [self.timer invalidate];
//         self.timer = nil;
//     }
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
            [self.locationManager stopUpdatingLocation];
            self.LocationBlock(YES);
            if (self.changeBlcok) {
                self.changeBlcok(YES);
            }
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
            
            [self.locationManager stopUpdatingLocation];
            self.LocationBlock(YES);
            if (self.changeBlcok) {
                self.changeBlcok(YES);
            }
            break;
        }
            // 获取前后台定位授权
        case kCLAuthorizationStatusAuthorizedAlways:
            //        case kCLAuthorizationStatusAuthorized: // 失效，不建议使用
        {
            NSLog(@"获取前后台定位授权");
            [self.locationManager startUpdatingLocation];
            if (self.changeBlcok) {
                self.changeBlcok(YES);
            }
            break;
        }
            // 获得前台定位授权
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"获得前台定位授权");
            [self.locationManager startUpdatingLocation];
            if (self.changeBlcok) {
                self.changeBlcok(YES);
            }
            break;
        }
        default:{
            
            if (self.changeBlcok) {
                self.changeBlcok(YES);
            }
            break;
        }
    }
}

//- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager{
//    CLAuthorizationStatus locationStatus = [CLLocationManager authorizationStatus];
//    switch (locationStatus) {
//            // 用户还未决定
//        case kCLAuthorizationStatusNotDetermined:
//        {
//            NSLog(@"用户还未决定");
//            break;
//        }
//            // 问受限
//        case kCLAuthorizationStatusRestricted:
//        {
//            NSLog(@"访问受限");
//            [self.locationManager stopUpdatingLocation];
//            self.LocationBlock(YES);
//            if (self.changeBlcok) {
//                self.changeBlcok(YES);
//            }
//            break;
//        }
//            // 定位关闭时和对此APP授权为never时调用
//        case kCLAuthorizationStatusDenied:
//        {
//            // 定位是否可用（是否支持定位或者定位是否开启）
//            if([CLLocationManager locationServicesEnabled])
//            {
//                NSLog(@"定位开启，但被拒");
//            }else
//            {
//                NSLog(@"定位关闭，不可用");
//            }
//            NSLog(@"被拒");
//
//            [self.locationManager stopUpdatingLocation];
//            self.LocationBlock(YES);
//            if (self.changeBlcok) {
//                self.changeBlcok(YES);
//            }
//            break;
//        }
//            // 获取前后台定位授权
//        case kCLAuthorizationStatusAuthorizedAlways:
//            //        case kCLAuthorizationStatusAuthorized: // 失效，不建议使用
//        {
//            NSLog(@"获取前后台定位授权");
//            [self.locationManager startUpdatingLocation];
//            if (self.changeBlcok) {
//                self.changeBlcok(YES);
//            }
//            break;
//        }
//            // 获得前台定位授权
//        case kCLAuthorizationStatusAuthorizedWhenInUse:
//        {
//            NSLog(@"获得前台定位授权");
//            [self.locationManager startUpdatingLocation];
//            if (self.changeBlcok) {
//                self.changeBlcok(YES);
//            }
//            break;
//        }
//        default:{
//
//            if (self.changeBlcok) {
//                self.changeBlcok(YES);
//            }
//            break;
//        }
//    }
//
//
//}

// 定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.locationManager stopUpdatingLocation];
        if(self.haveSend == NO){
            
            self.LocationBlock(YES);
        }
    });
}

-(CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}
@end
