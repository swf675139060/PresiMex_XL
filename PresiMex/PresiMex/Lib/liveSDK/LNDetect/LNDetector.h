//
//  LNDetector.h
//  YOLOv5NCNN
//
//  Created by Benjamin Wang on 2022/9/6.
//  Copyright © 2022 TENG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DetectorTypes.h"
#import "DetectionFrame.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *LNAppName;
extern NSString *LNPartnerCode;
extern NSString *LNPartnerKey;
extern NSString *LNSDKVersion;

@protocol LNDetectorDelegate <NSObject>
- (void)detectorWillStartDetectType:(LNDetectionType)detectionType;
- (void)detectorDetectionSuccess:(LNDetectionType)successType resultDict:(NSDictionary *)resultDict  code:(LNDetectionResultCode)code bestImgBase64:(NSString *)best;
- (void)detectorDetectionFailed:(LNDetectionFailedType)failedType resultDict:(NSDictionary *)resultDict code:(LNDetectionResultCode)code;
- (void)detectorDetectionTimeout:(NSTimeInterval)interval resultDict:(NSDictionary *)resultDict;
- (void)detectorFrameDetected:(DetectionFrame *)frame warnCode:(LNWarnCode)warnCode;
- (void)detectorFaceReady;
@end

@interface LNDetector : NSObject
@property (nonatomic, assign, readonly) LNDetectionType detectionType;
@property (nonatomic, assign, readonly) LNActionStatus actionStatus;
@property (nonatomic, assign, readonly) LNWarnCode warnCode;
@property (nonatomic, assign, readonly) LNPoseType poseType;
@property (nonatomic, assign, readonly) BOOL detecting;
@property (nonatomic, weak) id<LNDetectorDelegate> delegate;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *livenessID;

+ (void)setAppName:(NSString *)appName partnerCode:(NSString *)partnerCode partnerKey:(NSString *)partnerKey;

- (nullable instancetype)initWithDelegate:(id<LNDetectorDelegate>)delegate userID:(NSString *)userID livenessID:(NSString *)livenessID;
- (void)detect;
- (void)enqueueDetectImage:(UIImage *)image;
- (void)cancel;

@end

NS_ASSUME_NONNULL_END
