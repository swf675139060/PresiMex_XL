//
//  JKLocationManager.h
//  OPESO
//
//  Created by 白翔龙 on 2021/11/24.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^MoLocationSuccess) (double lat, double lng);
typedef void(^MoLocationFailed) (NSError *error);
@interface JKLocationManager : NSObject<CLLocationManagerDelegate>
{
    CLLocationManager *manager;
    MoLocationSuccess successCallBack;
    MoLocationFailed failedCallBack;
}
+ (JKLocationManager *) sharedGpsManager;

+ (void) getMoLocationWithSuccess:(MoLocationSuccess)success Failure:(MoLocationFailed)failure;

+ (void) stop;
+ (instancetype)manager NS_SWIFT_NAME(default());
//- (void)startLocationWithSuccessBlock:(void (^)(CLLocation *lo))successBlock failureBlock:(void (^)(NSError *error))failureBlock;
@property(nonatomic,copy)void (^locationM)(CLLocation *lo);
@end

NS_ASSUME_NONNULL_END
