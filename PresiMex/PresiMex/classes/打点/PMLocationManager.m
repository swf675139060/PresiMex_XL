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


//定位完成/失败
@property (nonatomic, assign)BOOL haveLocation;

@end

@implementation PMLocationManager



+ (PMLocationManager *)sharedInstance {
    static PMLocationManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void)creatLocation:(void (^)(BOOL isLocation)) LocationBlock{
    
    self.LocationBlock = LocationBlock;
    
    if(self.haveLocation){
        //定位过直接返回
        self.LocationBlock(YES);
        return;
    }
    
   
    CLAuthorizationStatus status = [PrivateInfo LocationStatus];

    if (status == AVAuthorizationStatusAuthorized || status == kCLAuthorizationStatusAuthorizedWhenInUse ||status == kCLAuthorizationStatusAuthorizedAlways) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startUpdatingLocation];
    }else{
        if (self.LocationBlock) {
            self.haveLocation = YES;
            self.LocationBlock(NO);
        }
    }
    
    
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = locations.lastObject;
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    self.longitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
    
    self.latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
    
    WF_WEAKSELF(weakself);
    [self getProvinceForLocation:location completionHandler:^(NSString *province, NSError *error) {
        if (province) {
            
            weakself.gpsAddressProvince = province;
        } else {
            
            weakself.gpsAddressProvince = @"";
        }
        [weakself locationCom];
        
    }];
    
    [self getCityForLocation:location completionHandler:^(NSString *province, NSError *error) {
        if (province) {
            
            weakself.gpsAddressCity = province;
        } else {
            
            weakself.gpsAddressCity = @"";
        }
        [weakself locationCom];
    }];
    [self getStreetForLocation:location completionHandler:^(NSString *province, NSError *error) {
        if (province) {
            weakself.gpsAddressStreet = province;
        } else {
            weakself.gpsAddressStreet = @"";
        }
        [weakself locationCom];
    }];
    
    [self.locationManager stopUpdatingLocation];
}

//定位信息是否完成
-(void)locationCom{
    if (self.gpsAddressStreet && self.gpsAddressCity  && self.gpsAddressProvince ) {
        if (self.LocationBlock && self.haveLocation == NO) {
            self.haveLocation = YES;
            self.LocationBlock(YES);
        }
    }
}


// 获取GPS地址街道
- (void)getStreetForLocation:(CLLocation *)location completionHandler:(void (^)(NSString *street, NSError *error))completionHandler {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            completionHandler(nil, error);
            return;
        }
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks.firstObject;
            NSString *street = placemark.thoroughfare;
            completionHandler(street, nil);
        } else {
            completionHandler(nil, nil);
        }
    }];
}

// 获取GPS地址省份
- (void)getProvinceForLocation:(CLLocation *)location completionHandler:(void (^)(NSString *province, NSError *error))completionHandler {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            completionHandler(nil, error);
            return;
        }
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks.firstObject;
            NSString *administrativeArea = placemark.administrativeArea;
            completionHandler(administrativeArea, nil);
        } else {
            completionHandler(nil, nil);
        }
    }];
}

// 获取GPS地址城市
- (void)getCityForLocation:(CLLocation *)location completionHandler:(void (^)(NSString *city, NSError *error))completionHandler {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            completionHandler(nil, error);
            return;
        }
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks.firstObject;
            NSString *city = placemark.locality ? placemark.locality : placemark.administrativeArea;
            completionHandler(city, nil);
        } else {
            completionHandler(nil, nil);
        }
    }];
}

@end
