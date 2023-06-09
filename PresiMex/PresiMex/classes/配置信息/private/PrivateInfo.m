//
//  PrivateInfo.m
//
//
//  Created by swf on 2021/5/28.
//

#import "PrivateInfo.h"
//#import "DKDes.h"

@implementation PrivateInfo

/// 通讯录授权状态
+ (CNAuthorizationStatus )contactAuthorStatus
{
    return [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
}

/// 请求通讯录权限
+ (void)requestContactAuthor
{
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    
    if (status == CNAuthorizationStatusNotDetermined) {
        CNContactStore *store = [[CNContactStore alloc] init];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
        }];
    }
}



/// 照片授权状态
+ (PHAuthorizationStatus )PhotoStatus
{
    return [PHPhotoLibrary authorizationStatus];
}

/// 请求照片授权
+ (void)requestPhotoAuthor
{
    PHAuthorizationStatus photoStatus = [PHPhotoLibrary authorizationStatus];
    if (photoStatus == PHAuthorizationStatusNotDetermined) {
        // 尚未请求照片访问权限，需要请求权限
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                // 用户已经授权访问照片，可以执行访问操作
            } else {
                // 用户拒绝了访问权限请求，需要提示用户并且提供设置选项
            }
        }];
    }
}

/// 照相机授权状态
+ (AVAuthorizationStatus )MediaStatus
{
    AVAuthorizationStatus cameraStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    return cameraStatus;
}

/// 请求照相机授权
+ (void)requestMediaStatusAuthor
{
    
    AVAuthorizationStatus cameraStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (cameraStatus == AVAuthorizationStatusNotDetermined) {
        // 尚未请求摄像机访问权限，需要请求权限
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                // 用户已经授权访问摄像机，可以执行访问操作
            } else {
                // 用户拒绝了访问权限请求，需要提示用户并且提供设置选项
            }
        }];
    }
}

/// 定位授权状态
+ (CLAuthorizationStatus )LocationStatus{
    CLAuthorizationStatus locationStatus = [CLLocationManager authorizationStatus];
    return locationStatus;
}

/// 请求照定位授权
+ (void)requestLocationAuthor{
    CLAuthorizationStatus locationStatus = [CLLocationManager authorizationStatus];
    if (locationStatus == kCLAuthorizationStatusNotDetermined) {
        // 尚未请求定位访问权限，需要请求权限
        CLLocationManager *locationManager = [[CLLocationManager alloc] init];
        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [locationManager requestWhenInUseAuthorization];
        }
    }
}

/// 上传隐私数据
/// @param success 成功回调
/// @param failure 失败回调
//+ (void)uploadPrivateInfo:(CLLocation *)location success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure
//{
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setValue:[self getContacts] forKey:@"contacts"];
//
//    if (location) {
//        [dict setValue:@(location.coordinate.longitude) forKey:@"longitude"];
//        [dict setValue:@(location.coordinate.latitude) forKey:@"latitude"];
//    }
//
//    [DKNetworking POST:DFURL.Post_Prive_Data parameters:dict.copy progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        if (success) {
//            success(responseObject);
//        }
//    } requestFailured:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

///// 获取通讯录
//+ (NSString *)getContacts
//{
//    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
//
//    if (status != CNAuthorizationStatusAuthorized) {
//        return @"";
//    }
//
//    NSMutableArray<NSDictionary *> *contacts = [NSMutableArray array];
//
//    // 获取指定的字段,并不是要获取所有字段，需要指定具体的字段
//    NSArray *keysToFetch = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
//    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
//    CNContactStore *contactStore = [[CNContactStore alloc] init];
//
//    [contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
//
//        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//
//        //拼接姓名
//        NSString *nameStr = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
//
//        [dict setValue:nameStr forKey:@"name"];
//
//        NSArray *phoneNumbers = contact.phoneNumbers;
//
//        if (phoneNumbers.count > 0) {
//            CNLabeledValue *labeledValue = phoneNumbers[0];
//
//            if (labeledValue) {
//                CNPhoneNumber *phoneNumber = labeledValue.value;
//                if (phoneNumber && nameStr.length > 0) {
//                    NSString *phone = [[[phoneNumber.stringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] stringByReplacingOccurrencesOfString:@" " withString:@""]  stringByReplacingOccurrencesOfString:@"-" withString:@""];
//
//                    [dict setValue:phone forKey:@"mobile"];
//                    [contacts addObject:dict.copy];
//               }
//            }
//        }
//    }];
//    return [DKDes encrypt:[contacts yy_modelToJSONString]];
//}

@end
