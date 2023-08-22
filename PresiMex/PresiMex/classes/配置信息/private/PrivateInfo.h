//
//  PrivateInfo.h
//  Dana Disini
//
//  Created by swf on 2021/5/28.
//

#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>
#import <CoreLocation/CoreLocation.h>

#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>

#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PrivateInfo : NSObject

/// 通讯录授权状态
+ (CNAuthorizationStatus )contactAuthorStatus;

// 请求通讯录权限
//+ (void)requestContactAuthor;

/// 照片授权状态
+ (PHAuthorizationStatus )PhotoStatus;

/// 请求照片授权
+ (void)requestPhotoAuthor:(void (^)(PHAuthorizationStatus status)) statusBlock;

/// 照相机授权状态
+ (AVAuthorizationStatus )MediaStatus;

/// 请求照相机授权
+ (void)requestMediaStatusAuthor:(void (^)(BOOL status)) statusBlock;


/// 定位授权状态
+ (CLAuthorizationStatus )LocationStatus;

/// 请求定位授权状态
+ (void)requestLocationAuthor;


+ (void)requestIDFA:(void (^)(BOOL status)) statusBlock;


///// 上传隐私数据
///// @param success 成功回调
///// @param failure 失败回调
//+ (void)uploadPrivateInfo:(CLLocation *)location success:(void(^)(id result))success failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
