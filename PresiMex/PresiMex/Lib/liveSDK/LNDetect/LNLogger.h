//
//  LNLogger.h
//  YOLOv5NCNN
//
//  Created by Benjamin Wang on 2022/9/22.
//  Copyright © 2022 TENG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetectorTypes.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LNLoggerSaveResultAPICompletion)(BOOL success);
typedef void(^LNLoggerSaveImgResultAPICompletion)(BOOL success, NSString* _Nullable ossId);

@interface LNLogger : NSObject

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, copy) NSString *bestOssId;

+ (instancetype)sharedInstance;
- (void)callLogAPI:(NSString *)action log:(NSString *)log userID:(NSString *)userID livenessID:(NSString *)livenessID;
- (void)callSaveResultAPI:(NSDictionary *)resultDict code:(LNDetectionResultCode)code userID:(NSString *)userID livenessID:(NSString *)livenessID completion:(LNLoggerSaveResultAPICompletion)completionCallback;
- (void)callSaveImgAPI:(NSString *)data userID:(NSString *)userID livenessID:(NSString *)livenessID;
- (void)callSaveBestImgAPI:(NSString *)data userID:(NSString *)userID livenessID:(NSString *)livenessID completion:(LNLoggerSaveImgResultAPICompletion)completionCallback;

@end

@interface LNLogger (Private)

- (NSString *)errorCodeToString:(LNDetectionResultCode)code;

@end

NS_ASSUME_NONNULL_END
