//
//  LNLogger.m
//  YOLOv5NCNN
//
//  Created by Benjamin Wang on 2022/9/22.
//  Copyright © 2022 TENG. All rights reserved.
//

#import "LNLogger.h"
#import "LNDetector.h"
#import "AFNetworking/AFNetworking.h"

@interface LNLogger ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation LNLogger

+ (instancetype)sharedInstance
{
    static LNLogger *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LNLogger alloc] init];
        // Perform other initialisation...
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    }
    return self;
}

- (void)callLogAPI:(NSString *)action log:(NSString *)log userID:(NSString *)userID livenessID:(NSString *)livenessID {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss SSS"];
        NSString *dateString = [[formatter stringFromDate:date] stringByAppendingString:@"000"];
        
        NSDictionary *param = @{
            @"livenessId": livenessID,
            @"action": action,
            @"log": log,
            @"userId": userID,
            @"time": dateString,
            @"sdkType": @"ios",
            @"sdkVersion": LNSDKVersion
        };
        NSDictionary *headers = @{
            @"app-name": LNAppName,
            @"partner-code": LNPartnerCode,
            @"partner-key": LNPartnerKey
        };
        [self.manager POST:@"https://datacenter.xintai.mx/api/img/mxSdk/log/save" parameters:param headers:headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    });
}

- (void)callSaveResultAPI:(NSDictionary *)resultDict code:(LNDetectionResultCode)code userID:(NSString *)userID livenessID:(NSString *)livenessID completion:(LNLoggerSaveResultAPICompletion)completionCallback {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    NSDictionary *ext_info = @{
        @"code": @(code),
        @"errorMsg":[self errorCodeToString:code]
    };
    NSString *bestOssId = _bestOssId;
    if (bestOssId.length <=0) bestOssId = @"";
    NSDictionary *params = @{
        @"userId": userID,
        @"livenessId": livenessID,
        @"data": resultDict,
        @"ext_info": ext_info,
        @"bestImageOssId": bestOssId
    };
    NSDictionary *headers = @{
        @"app-name": LNAppName,
        @"partner-code": LNPartnerCode,
        @"partner-key": LNPartnerKey
    };
    [self.manager POST:@"https://datacenter.xintai.mx/api/img/mxSdk/save" parameters:params headers:headers progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"json: %@", responseObject);
        completionCallback(YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *httpResponse = task.response;
        if (httpResponse.statusCode == 200) {
            completionCallback(YES);
        } else {
            completionCallback(NO);
        }
    }];
}

- (void)callSaveBestImgAPI:(NSString *)data userID:(NSString *)userID livenessID:(NSString *)livenessID
            completion:(LNLoggerSaveImgResultAPICompletion)completionCallback{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSDictionary *param = @{
            @"livenessId": livenessID,
            @"img": data,
            @"license": @"114514",
            @"userId": userID,
            @"sdkType": @"ios",
            @"sdkVersion": LNSDKVersion,
            @"imageType": @"BEST"
        };
        NSDictionary *headers = @{
            @"app-name": LNAppName,
            @"partner-code": LNPartnerCode,
            @"partner-key": LNPartnerKey,
            @"Accept": @"application/json",
            @"Content-Type": @"application/json"
        };
        [self.manager POST:@"https://datacenter.xintai.mx/api/img/mxSdk/save-img" parameters:param headers:headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"json: %@", responseObject);
            NSDictionary *data = responseObject[@"data"];
            NSString *bestOssId = data[@"ossId"];
            NSLog(@"%@", bestOssId);
            
            completionCallback(YES, bestOssId);
            self.bestOssId = bestOssId;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error: %@", error);
            completionCallback(NO, NULL);
        }];
    });
}

- (void)callSaveImgAPI:(NSString *)data userID:(NSString *)userID livenessID:(NSString *)livenessID{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSDictionary *param = @{
            @"livenessId": livenessID,
            @"img": data,
            @"license": @"114514",
            @"userId": userID,
            @"sdkType": @"ios",
            @"sdkVersion": LNSDKVersion,
            @"imageType": @"OPTIONAL"
        };
        NSDictionary *headers = @{
            @"app-name": LNAppName,
            @"partner-code": LNPartnerCode,
            @"partner-key": LNPartnerKey,
            @"Accept": @"application/json",
            @"Content-Type": @"application/json"
        };
        [self.manager POST:@"https://datacenter.xintai.mx/api/img/mxSdk/save-img" parameters:param headers:headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"json: %@", responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error: %@", error);
        }];
    });
}

- (NSString *)errorCodeToString:(LNDetectionResultCode)code {
    switch(code) {
        case LNDetectionResultErrorNoFace: return @"No Face";
        case LNDetectionResultErrorTimeOut: return @"Time Out";
        case LNDetectionResultErrorMultipleAction: return @"Multiple Action";
        case LNDetectionResultErrorUserCancel: return @"User Cancel";
        case LNDetectionResultErrorModelInitFailed: return @"Model Init Failed";
        case LNDetectionResultErrorNetworkError: return @"Network Error";
        case LNDetectionResultErrorMultipleFace: return @"Multiple Face";
        case LNDetectionResultErrorInitFailed: return @"Init Failed";
        case LNDetectionResultErrorDetectionFailed: return @"Detection Failed";
        default:return @"";
    };
}

@end
