//
//  PMBaseHttp.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/27.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
NS_ASSUME_NONNULL_BEGIN

@interface PMBaseHttp : NSObject


/**
 *  开启网络监听
 */
+ (void)startNetWorkingMonitoring;

/**
 *获取网络状态
 */
+ (AFNetworkReachabilityStatus)getNetWorkingStatus;

//
+ (NSURLSessionDataTask*)get:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure;


/**
 *
 *
 *  格式 application/x-www-form-urlencoded
 *
 *  @param URLString url地址
 *  @param parameters 参数
 *  @param success   成功回调
 *  @param failure   失败回调
 */

+ (NSURLSessionDataTask*)post:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;


+ (NSURLSessionDataTask*)postJson:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

+ (void)uploadImg:(UIImage *)image parameter:(NSDictionary *)parameter success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


@end

NS_ASSUME_NONNULL_END
