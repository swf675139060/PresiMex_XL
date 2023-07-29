//
//  PMLocationManager.h
//  PresiMex
//
//  Created by shenwenfeng on 2023/7/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PMLocationManager : NSObject

@property (nonatomic, strong) CLLocationManager *locationManager;
@property(strong,nonatomic)NSString * longitude;//经度
@property(strong,nonatomic)NSString * latitude;//纬度


@property(strong,nonatomic)NSString * gpsAddressStreet;//ios系统字段，GPS地址街道
@property(strong,nonatomic)NSString * gpsAddressProvince;//ios系统字段，GPS地址省份
@property(strong,nonatomic)NSString * gpsAddressCity;//ios系统字段，GPS地址城市


+ (PMLocationManager *)sharedInstance;
-(void)creatLocation:(void (^)(BOOL isLocation)) LocationBlock;
@end

NS_ASSUME_NONNULL_END
