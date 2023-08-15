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

@property(strong,nonatomic)void(^changeBlcok)(BOOL change);


+ (PMLocationManager *)sharedInstance;

//定位完成/失败
@property (nonatomic, assign)BOOL haveLocation;
//是否发送过
@property (nonatomic, assign)BOOL haveSend;
-(void)creatShowAlert:(BOOL)show LocationBlock:(void (^)(BOOL isLocation)) LocationBlock;

@end

NS_ASSUME_NONNULL_END
