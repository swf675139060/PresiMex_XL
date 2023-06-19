//
//  LNDetector.m
//  YOLOv5NCNN
//
//  Created by Benjamin Wang on 2022/9/6.
//  Copyright © 2022 TENG. All rights reserved.
//

#import "LNDetector.h"
#import "DetectionFrame.h"
#import "LNBlockingQueue.h"
#import "HeadShakePoints.h"
#import "BlinkPoints.h"
#import "MouthPoints.h"
#import "FaceUtil.h"
#import "LNLogger.h"
#include "Scrfd.h"

#define LNDetectionMinRequireStillTS  1.0f
#define LNDetectionTimeOut 20.0f
#define LNDetectionFaceReadyTimeOut 20.0f
#define LNDetectionWaitingNextActionTS 2.0f

NSString *LNAppName;
NSString *LNPartnerCode;
NSString *LNPartnerKey;
NSString *LNSDKVersion = @"1.0";

@implementation NSMutableArray (Shuffle)
// Fisher-Yates shuffle
- (void)shuffle
{
    for (NSUInteger i = self.count; i > 1; i--)
        [self exchangeObjectAtIndex:i - 1 withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
}
@end

@interface LNDetector ()
@property (nonatomic, assign) LNDetectionType detectionType;
@property (nonatomic, assign) LNActionStatus actionStatus;
@property (nonatomic, assign) LNWarnCode warnCode;
@property (nonatomic, assign) LNPoseType poseType;
@property (nonatomic, assign) BOOL waitingNextAction;
@property (nonatomic, assign) BOOL detecting;
@property (nonatomic, strong) LNBlockingQueue *frameQueue;
@property (nonatomic, assign) NSTimeInterval currentStillStartTS;
@property (nonatomic, assign) NSTimeInterval currentPosePrepareStartTS;
@property (nonatomic, assign) int currentFrameNumber;
@property (nonatomic, strong) NSMutableArray *detectOrder;
@property (nonatomic) dispatch_queue_t imageEnqueueQueue;
@property (nonatomic, strong) NSMutableDictionary *resultDict;
@property (nonatomic, assign) float currentFaceProb;
@property (nonatomic, assign) FaceInfo currentFaceInfo;
@property (nonatomic, assign) NSString *bestOssId;
@property (nonatomic, assign) NSString *bestImgBase64;
@property (nonatomic, assign) NSString *cropImgBase64;
@property Scrfd *scrfd;
@end

@implementation LNDetector

+ (void)setAppName:(NSString *)appName partnerCode:(NSString *)partnerCode partnerKey:(NSString *)partnerKey {
    LNAppName = appName;
    LNPartnerCode = partnerCode;
    LNPartnerKey = partnerKey;
}

- (instancetype)initWithDelegate:(id<LNDetectorDelegate>)delegate userID:(nonnull NSString *)userID livenessID:(nonnull NSString *)livenessID {
    if (self = [super init]) {
        _frameQueue = [[LNBlockingQueue alloc] init];
        _scrfd = new Scrfd(false);
        if (_scrfd->initFailed == true) {
            return nil;
        }
        _userID = userID;
        _livenessID = livenessID;
        _poseType = LNPoseTypeNone;
        _detectionType = LNDetectionTypeNone;
        _actionStatus = LNActionStatusFaceNoDefine;
        _warnCode = LNWarnCodeOKDefault;
        _delegate = delegate;
        _imageEnqueueQueue = dispatch_queue_create("imageEnqueueQueue", DISPATCH_QUEUE_SERIAL);
        _resultDict = [[NSMutableDictionary alloc] init];
        _detectOrder = [[NSMutableArray alloc] initWithObjects:@(LNDetectionTypeBlink), @(LNDetectionTypeMouth), @(LNDetectionTypePosYaw), nil];
        [_detectOrder shuffle];
        [_detectOrder addObject:@(LNDetectionTypeDone)];
    }
    return self;
}

- (void)dealloc {
    delete self.scrfd;
    NSLog(@"Detector dealloc");
}

- (void)cancel {
    self.detecting = NO;
    [self cleanup];
}

- (void)enqueueDetectImage:(UIImage *)image {
    if (self.detecting == NO) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.imageEnqueueQueue, ^{
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.currentFrameNumber += 1;
        DetectionFrame *frame = [[DetectionFrame alloc] initWithImage:image detectionType:strongSelf.detectionType frameNumber:strongSelf.currentFrameNumber];
        [strongSelf.frameQueue enqueue:frame];
    });
}

- (void)detect {
    if (self.detecting == YES) {
        return;
    }
    self.detecting = YES;
    _currentPosePrepareStartTS = [[NSDate date] timeIntervalSince1970];
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        __strong typeof(self) strongSelf = weakSelf;
        while (strongSelf.detecting) {
            if (strongSelf.waitingNextAction) {
                continue;
            }
            if (strongSelf.detectionType == LNDetectionTypeDone) {
                strongSelf.detecting = NO;
                [[LNLogger sharedInstance] callLogAPI:@"Detector" log:@"活体检测成功" userID:strongSelf.userID livenessID:strongSelf.livenessID];
                [strongSelf.delegate detectorDetectionSuccess:LNDetectionTypeDone resultDict:strongSelf.resultDict code:LNDetectionResultSuccess bestImgBase64:strongSelf.cropImgBase64];
                [strongSelf cleanup];
                break;
            }
            NSTimeInterval costTS = fabs([[NSDate date] timeIntervalSince1970] - strongSelf.currentPosePrepareStartTS);
            switch (strongSelf.actionStatus) {
                case LNActionStatusFaceNoDefine:
                case LNActionStatusFaceInit:
                case LNActionStatusFaceCheckSize:
                case LNActionStatusFaceIsReady:
                case LNActionStatusFaceMotionReady:
                case LNActionStatusFaceCaptureReady:
                case LNActionStatusFaceCenterReady:
                {
                    [strongSelf.delegate detectorDetectionTimeout:LNDetectionFaceReadyTimeOut - costTS resultDict:strongSelf.resultDict];
                    if (costTS > LNDetectionFaceReadyTimeOut) {
                        [strongSelf.delegate detectorDetectionFailed:LNDetectionFailedTypeTimeout resultDict:strongSelf.resultDict code:LNDetectionResultErrorTimeOut];
                        strongSelf.detecting = NO;
                        [[LNLogger sharedInstance] callLogAPI:@"Detector" log:[NSString stringWithFormat:@"%d准备超时", strongSelf.actionStatus] userID:strongSelf.userID livenessID:strongSelf.livenessID];
                        [strongSelf cleanup];
                        break;
                    }
                    break;
                }
                case LNActionStatusFaceYaw:
                case LNActionStatusFaceMouth:
                case LNActionStatusFaceBlink:
                {
                    if (costTS > LNDetectionTimeOut) {
                        [strongSelf.delegate detectorDetectionFailed:LNDetectionFailedTypeTimeout resultDict:strongSelf.resultDict code:LNDetectionResultErrorTimeOut];
                        strongSelf.detecting = NO;
                        [[LNLogger sharedInstance] callLogAPI:@"Detector" log:[NSString stringWithFormat:@"%d动作超时", strongSelf.actionStatus] userID:strongSelf.userID livenessID:strongSelf.livenessID];
                        [strongSelf cleanup];
                        break;
                    }
                    break;
                }
                default:
                    break;
            }
            DetectionFrame *frame = [strongSelf nextFrame];
            if (frame == nil || frame.image == nil || frame.detectionType != strongSelf.detectionType) {
                continue;
            }
            std::vector<FaceInfo> faceInfo = strongSelf.scrfd->detect_scrfd(frame.image);
            if (faceInfo.size() > 0) {
                frame.faceInfo = faceInfo[0];
            } else {
                NSLog(@"did not found face");
            }
            if ([frame hasFace] == NO) {
                // face missing after enter detection procedure, callback detection failed and stop detection.
                if (strongSelf.actionStatus == LNActionStatusFaceYaw || strongSelf.actionStatus == LNActionStatusFaceMouth || strongSelf.actionStatus == LNActionStatusFaceBlink
                    || strongSelf.actionStatus == LNActionStatusFaceStillReady || strongSelf.actionStatus == LNActionStatusFaceMotionReady) {
                    [strongSelf detectionFailed:LNDetectionFailedTypeFaceMissing];
                    strongSelf.detecting = NO;
                    [[LNLogger sharedInstance] callLogAPI:@"Detector" log:@"FACEMISSING" userID:strongSelf.userID livenessID:strongSelf.livenessID];
                    [strongSelf cleanup];
                    break;
                }
            }
            switch (strongSelf.actionStatus) {
                case LNActionStatusFaceNoDefine:
                {
                    strongSelf.warnCode = LNWarnCodeFaceMissing;
                    if ([frame hasFace]) {
                        strongSelf.actionStatus = LNActionStatusFaceInit;
                        [[LNLogger sharedInstance] callLogAPI:@"Detector" log:@"检测到人脸" userID:strongSelf.userID livenessID:strongSelf.livenessID];
                    }
                    break;
                }
                case LNActionStatusNoFace:
                {
                    strongSelf.warnCode = LNWarnCodeFaceMissing;
                    strongSelf.actionStatus = LNActionStatusFaceNoDefine;
                    break;
                }
                case LNActionStatusMultipleFace:
                {
                    strongSelf.warnCode = LNWarnCodeFaceMultiple;
                    break;
                }
                case LNActionStatusFaceInit:
                {
                    strongSelf.warnCode = LNWarnCodeOKDefault;
                    if (faceInfo.size() == 0) {
                        strongSelf.actionStatus = LNActionStatusNoFace;
                        [[LNLogger sharedInstance] callLogAPI:@"Detector" log:@"人脸丢失" userID:strongSelf.userID livenessID:strongSelf.livenessID];
                    } else if (faceInfo.size() > 1) {
                        strongSelf.actionStatus = LNActionStatusMultipleFace;
                        [[LNLogger sharedInstance] callLogAPI:@"Detector" log:@"检测到多个人脸" userID:strongSelf.userID livenessID:strongSelf.livenessID];
                    } else {
                        strongSelf.actionStatus = LNActionStatusFaceCheckSize;
                        [[LNLogger sharedInstance] callLogAPI:@"Detector" log:@"检测到1个人脸" userID:strongSelf.userID livenessID:strongSelf.livenessID];
                    }
                    break;
                }
                case LNActionStatusFaceCheckSize:
                {
                    if ([frame getFaceSize] == LNFaceSizeCorrect) {
                        strongSelf.actionStatus = LNActionStatusFaceIsReady;
                        [[LNLogger sharedInstance] callLogAPI:@"Detector" log:@"人脸大小合适" userID:strongSelf.userID livenessID:strongSelf.livenessID];
                    } else if ([frame getFaceSize] == LNFaceSizeSmall) {
                        strongSelf.warnCode = LNWarnCodeFaceSmall;
                    } else {
                        strongSelf.warnCode = LNWarnCodeFaceLarge;
                    }
                    break;
                }
                case LNActionStatusFaceIsReady:
                {
                    if ([frame isFaceCenter]) {
                        strongSelf.actionStatus = LNActionStatusFaceCenterReady;
                        [[LNLogger sharedInstance] callLogAPI:@"Detector" log:@"人脸位置合适" userID:strongSelf.userID livenessID:strongSelf.livenessID];
                    } else {
                        strongSelf.warnCode = LNWarnCodeFaceNotCenter;
                    }
                    break;
                }
                case LNActionStatusFaceCenterReady:
                {
                    if ([frame isEyeOpen]) {
                        strongSelf.actionStatus = LNActionStatusFaceStillReady;
                        strongSelf.warnCode = LNWarnCodeFaceNotStill;
                        strongSelf.currentStillStartTS = [[NSDate date] timeIntervalSince1970];
                        [[LNLogger sharedInstance] callLogAPI:@"Detector" log:@"保持动作开始检测" userID:strongSelf.userID livenessID:strongSelf.livenessID];
                    } else {
                        strongSelf.warnCode = LNWarnCodeEyeOcclusion;
                    }
                    break;
                }
                case LNActionStatusFaceStillReady:
                {
                    if (self.bestImgBase64 == nil) {
                        NSData *imageData = UIImagePNGRepresentation(frame.image);
                        NSString *base64String = [imageData base64EncodedStringWithOptions:0];
                        strongSelf.bestImgBase64 = base64String;
                        strongSelf.currentFaceProb = [strongSelf caculateScore:frame];
                        strongSelf.currentFaceInfo = frame.faceInfo;
                    } else {
                        if ([strongSelf caculateScore:frame] > strongSelf.currentFaceProb) {
                            NSData *imageData = UIImagePNGRepresentation(frame.image);
                            NSString *base64String = [imageData base64EncodedStringWithOptions:0];
                            strongSelf.currentFaceProb = [strongSelf caculateScore:frame];
                            strongSelf.currentFaceInfo = frame.faceInfo;
                            strongSelf.bestImgBase64 = base64String;
                        }
                    }
                    if ([frame isFaceCenter] == NO || [frame isEyeOpen] == NO) {
                        strongSelf.warnCode = LNWarnCodeEyeOcclusion;
                        strongSelf.currentStillStartTS = [[NSDate date] timeIntervalSince1970];
                    } else if ([[NSDate date] timeIntervalSince1970] - strongSelf.currentStillStartTS < LNDetectionMinRequireStillTS) {
                        strongSelf.warnCode = LNWarnCodeFaceNotStill;
                    } else {
//                        val mp = dr.faceBoxBitmap
//                                                    if (mp != null){
//                                                        val face = dr.getFaceInfo()
//                                                        val left = (max(face.left - face.width * 0.2, 1.0)).toInt()
//                                                        val top = (max(face.top - face.height * 0.2, 1.0)).toInt()
//                                                        val width = (min(1.4 * face.width, mp.width.toDouble() - 1)).toInt()
//                                                        val height = (min(1.4 * face.height, mp.height.toDouble() - 1)).toInt()
//                                                        val saveBmp = Bitmap.createBitmap(mp, left, top, width, height)
//                                                        dr.faceBoxBitmap = saveBmp
//                                                    }
//                                                    faceInfos["Best"] = dr.wrapInfo(true)
//                                                    LivenessResult.livenessBitmap = dr.faceBoxBitmap
                        strongSelf.warnCode = LNWarnCodeFaceCapture;
                        strongSelf.actionStatus = LNActionStatusFaceCaptureReady;
                    }
                    break;
                }
                case LNActionStatusFaceCaptureReady:
                {
                    strongSelf.warnCode = LNWarnCodeFaceCapture;
                    strongSelf.actionStatus = LNActionStatusFaceMotionReady;
                    [[LNLogger sharedInstance] callLogAPI:@"Detector" log:@"准备动作检测" userID:strongSelf.userID livenessID:strongSelf.livenessID];
                    
                    NSData *bestImgData = [[NSData alloc] initWithBase64EncodedString:self.bestImgBase64 options:0];
                    FaceInfo faceInfo = self.currentFaceInfo;
                    FaceInfo *bestFaceInfo = &faceInfo;
                    UIImage *cropImg = [self cropBestImg:bestImgData faceBox:bestFaceInfo];
                    NSData *cropImgData = UIImageJPEGRepresentation(cropImg, 0.8f);
                    NSString * cropImgBase64 = [cropImgData base64EncodedStringWithOptions:0];
                    
                    [[LNLogger sharedInstance] callSaveBestImgAPI:cropImgBase64  userID:strongSelf.userID livenessID:strongSelf.livenessID completion:^(BOOL success, NSString* bestOssId) {
                            if (success && bestOssId.length > 0) {
                                self.bestOssId = bestOssId;
                                self.cropImgBase64 = cropImgBase64;
                            }
                        }];
                    
                    self.resultDict[@"Best"] = @{
                        @"landmarks": [FaceUtil faceLandmarks:frame.faceInfo],
                        @"boxWidth": @640,
                        @"boxHeight": @640
                    };
                    
                    break;
                }
                case LNActionStatusFaceMotionReady:
                {
                    strongSelf.warnCode = LNWarnCodeFaceInAction;
                    strongSelf.currentPosePrepareStartTS = [[NSDate date] timeIntervalSince1970];
                    [strongSelf.delegate detectorWillStartDetectType:strongSelf.detectionType];
                    [[LNLogger sharedInstance] callLogAPI:@"Detector" log:[NSString stringWithFormat:@"动作%@", [strongSelf detectionTypeString]] userID:strongSelf.userID livenessID:strongSelf.livenessID];
                    switch (strongSelf.detectionType) {
                        case LNDetectionTypePosYaw:
                            strongSelf.actionStatus = LNActionStatusFaceYaw;
                            break;
                        case LNDetectionTypeMouth:
                            strongSelf.actionStatus = LNActionStatusFaceMouth;
                            break;
                        case LNDetectionTypeBlink:
                            strongSelf.actionStatus = LNActionStatusFaceBlink;
                        default:
                            break;
                    }
                    break;
                }
                case LNActionStatusFaceBlink:
                {
                    [strongSelf checkBlink:frame];
                    break;
                }
                case LNActionStatusFaceMouth:
                {
                    [strongSelf checkOpenMouth:frame];
                    break;
                }
                case LNActionStatusFaceYaw:
                {
                    [strongSelf checkHeadShake:frame];
                    break;
                }
                default:
                    break;
            }
            
            switch (strongSelf.warnCode) {
                case LNWarnCodeFaceMissing:
                case LNWarnCodeFaceSmall:
                case LNWarnCodeFaceLarge:
                case LNWarnCodeFaceNotCenter:
                case LNWarnCodeEyeOcclusion:
                case LNWarnCodeFaceNotStill:
                case LNWarnCodeOKCounting:
                {
                    [strongSelf.delegate detectorFrameDetected:frame warnCode:strongSelf.warnCode];
                    break;
                }
                case LNWarnCodeFaceCapture:
                {
                    [strongSelf.delegate detectorFaceReady];
                    break;
                }
                case LNWarnCodeErrorFaceMissing:
                {
                    [strongSelf.delegate detectorDetectionFailed:LNDetectionFailedTypeFaceMissing resultDict:strongSelf.resultDict code:LNDetectionResultErrorNoFace];
                    break;
                }
                case LNWarnCodeFaceInAction:
                {
                    NSTimeInterval costTS = fabs([[NSDate date] timeIntervalSince1970] - strongSelf.currentPosePrepareStartTS);
                    [strongSelf.delegate detectorFrameDetected:frame warnCode:strongSelf.warnCode];
                    [strongSelf.delegate detectorDetectionTimeout:LNDetectionTimeOut - costTS resultDict:strongSelf.resultDict];
                    break;
                }
                case LNWarnCodeOkActionDone:
                {
                    strongSelf.waitingNextAction = YES;
                    [strongSelf.delegate detectorFrameDetected:frame warnCode:strongSelf.warnCode];
                    if (strongSelf.detectionType == LNDetectionTypeDone) {
                        strongSelf.detecting = NO;
                        [[LNLogger sharedInstance] callLogAPI:@"Detector" log:@"活体检测成功" userID:strongSelf.userID livenessID:strongSelf.livenessID];
                        [strongSelf.delegate detectorDetectionSuccess:LNDetectionTypeDone resultDict:strongSelf.resultDict code:LNDetectionResultSuccess bestImgBase64:strongSelf.cropImgBase64];
                        [strongSelf cleanup];
                    } else {
                        [strongSelf.delegate detectorDetectionSuccess:strongSelf.detectionType resultDict:strongSelf.resultDict code:LNDetectionResultSuccess bestImgBase64:strongSelf.cropImgBase64];
                        [strongSelf detectNextDetectionType];
                    }
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, LNDetectionWaitingNextActionTS * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                        strongSelf.waitingNextAction = NO;
                    });
                    break;
                }
                default:
                    break;
            }
        }
    });
}

- (nullable DetectionFrame *)nextFrame {
    NSDate *date = [[NSDate date] dateByAddingTimeInterval:0.3];
    DetectionFrame *frame = [self.frameQueue dequeueElementWaitingUntilDate:date];
    return frame;
}

- (void)checkOpenMouth:(DetectionFrame *)frame {
    HeadShakePoints *headShake = [[HeadShakePoints alloc] initWithX1:frame.faceInfo.x1 y1:frame.faceInfo.y1 x2:frame.faceInfo.x2 y2:frame.faceInfo.y2 prob:frame.faceInfo.prob landmarks:frame.faceInfo.landmarks];
    MouthPoints *mouth = [[MouthPoints alloc] initWithX1:frame.faceInfo.x1 y1:frame.faceInfo.y1 x2:frame.faceInfo.x2 y2:frame.faceInfo.y2 prob:frame.faceInfo.prob landmarks:frame.faceInfo.landmarks];
    switch (self.poseType) {
        case LNPoseTypeNone:
            if (fabs(headShake.crossDegree) < 0.05) {
                self.resultDict[@"MOUTH_READY"] = @{
                    @"landmarks": [FaceUtil faceLandmarks:frame.faceInfo],
                    @"boxWidth": @640,
                    @"boxHeight": @640
                };
                self.poseType = LNPoseTypeMouthClose;
            }
            break;
        case LNPoseTypeMouthClose:{
            NSData *imageData = UIImagePNGRepresentation(frame.image);
            NSString *base64String = [imageData base64EncodedStringWithOptions:0];
            [[LNLogger sharedInstance] callSaveImgAPI:base64String userID:self.userID livenessID:self.livenessID];
            if ([mouth isClose]) {
                self.poseType = LNPoseTypeMouthOpen;
                self.resultDict[@"MOUTH_CLOSE"] = @{
                    @"landmarks": [FaceUtil faceLandmarks:frame.faceInfo],
                    @"boxWidth": @640,
                    @"boxHeight": @640
                };
            }
        }
        break;
        case LNPoseTypeMouthOpen:
            if ([mouth isOpen]) {
                self.poseType = LNPoseTypeNone;
                self.actionStatus = LNActionStatusFaceMotionReady;
                self.warnCode = LNWarnCodeOkActionDone;
                self.resultDict[@"MOUTH_OPEN"] = @{
                    @"landmarks": [FaceUtil faceLandmarks:frame.faceInfo],
                    @"boxWidth": @640,
                    @"boxHeight": @640
                };
            }
            break;
        default:
            break;
    }
}

- (void)checkBlink:(DetectionFrame *)frame {
    HeadShakePoints *headShake = [[HeadShakePoints alloc] initWithX1:frame.faceInfo.x1 y1:frame.faceInfo.y1 x2:frame.faceInfo.x2 y2:frame.faceInfo.y2 prob:frame.faceInfo.prob landmarks:frame.faceInfo.landmarks];
    BlinkPoints *blink = [[BlinkPoints alloc] initWithX1:frame.faceInfo.x1 y1:frame.faceInfo.y1 x2:frame.faceInfo.x2 y2:frame.faceInfo.y2 prob:frame.faceInfo.prob landmarks:frame.faceInfo.landmarks];
    switch (self.poseType) {
        case LNPoseTypeNone:
            [NSThread sleepForTimeInterval:0.2];
            //if (fabs(headShake.crossDegree) < 0.05) {
                self.poseType = LNPoseTypeEyeOpen;
            //}
            break;
        case LNPoseTypeEyeOpen:
            [NSThread sleepForTimeInterval:0.2];
            //if ([blink isOpen]) {
                self.poseType = LNPoseTypeEyeClose;
            //}
            break;
        case LNPoseTypeEyeClose:
            [NSThread sleepForTimeInterval:0.2];
            //if ([blink isClose]) {
                self.poseType = LNPoseTypeNone;
                self.actionStatus = LNActionStatusFaceMotionReady;
                self.warnCode = LNWarnCodeOkActionDone;
            self.resultDict[@"EYE_CLOSE"] = @{
                @"landmarks": [FaceUtil faceLandmarks:frame.faceInfo],
                @"boxWidth": @640,
                @"boxHeight": @640
            };
            //}
            break;
        default:
            break;
    }
}

- (void)checkHeadShake:(DetectionFrame *)frame {
    HeadShakePoints *headShake = [[HeadShakePoints alloc] initWithX1:frame.faceInfo.x1 y1:frame.faceInfo.y1 x2:frame.faceInfo.x2 y2:frame.faceInfo.y2 prob:frame.faceInfo.prob landmarks:frame.faceInfo.landmarks];
    switch (self.poseType) {
        case LNPoseTypeNone:{
            NSData *imageData = UIImagePNGRepresentation(frame.image);
            NSString *base64String = [imageData base64EncodedStringWithOptions:0];
            [[LNLogger sharedInstance] callSaveImgAPI:base64String userID:self.userID livenessID:self.livenessID];
            if (fabs(headShake.crossDegree) < 0.05 || (headShake.diffX > 0.8 && headShake.diffX < 1.2)) {
                self.poseType = LNPoseTypeHeadMiddle;
                self.resultDict[@"HEAD_READY"] = @{
                    @"landmarks": [FaceUtil faceLandmarks:frame.faceInfo],
                    @"boxWidth": @640,
                    @"boxHeight": @640
                };
            }}
            break;
        case LNPoseTypeHeadMiddle:
            if (headShake.diffX < 0.7) {
                self.poseType = LNPoseTypeNone;
                self.actionStatus = LNActionStatusFaceMotionReady;
                self.warnCode = LNWarnCodeOkActionDone;
                self.resultDict[@"HEAD_RIGHT"] = @{
                    @"landmarks": [FaceUtil faceLandmarks:frame.faceInfo],
                    @"boxWidth": @640,
                    @"boxHeight": @640
                };
            } else if (headShake.diffX > 1.3) {
                self.poseType = LNPoseTypeNone;
                self.actionStatus = LNActionStatusFaceMotionReady;
                self.warnCode = LNWarnCodeOkActionDone;
                self.resultDict[@"HEAD_LEFT"] = @{
                    @"landmarks": [FaceUtil faceLandmarks:frame.faceInfo],
                    @"boxWidth": @640,
                    @"boxHeight": @640
                };
            }
        default:
            break;
    }
}

- (void)detectNextDetectionType {
    if (self.detectOrder.count > 1) {
        [self.detectOrder removeObjectAtIndex:0];
    }
    _currentPosePrepareStartTS = [[NSDate date] timeIntervalSince1970];
    self.poseType = LNPoseTypeNone;
}

- (void)detectionFailed:(LNDetectionFailedType)failedType {
    [self.delegate detectorDetectionFailed:failedType resultDict:self.resultDict code:LNDetectionResultErrorNoFace];
}

- (float)caculateScore:(DetectionFrame *)frame {
    float score = 0;
    float faceRatio = 0.5f;
    float positionRatio = 0.5f;
    float faceScore = 0;
    float positionScore = 0;
    
    faceScore += (frame.faceInfo.prob - 0.5f) * 2 * faceRatio;
    float p1x = frame.faceInfo.landmarks[1 * 2] - frame.faceInfo.landmarks[17 * 2];
    float p1y = frame.faceInfo.landmarks[1 * 2 + 1] - frame.faceInfo.landmarks[17 * 2 + 1];
    float dr1 = fabs(p1x) / hypot(p1x, p1y);
    float directionScore1 = (dr1 - 0.95f) * 20 * 0.2f;
    
    float p2x = frame.faceInfo.landmarks[71 * 2] - frame.faceInfo.landmarks[72 * 2];
    float p2y = frame.faceInfo.landmarks[71 * 2 + 1] - frame.faceInfo.landmarks[72 * 2 + 1];
    float dr2 = fabs(p2x)/ hypot(p2x, p2y);
    float directionScore2 = (0.1f - dr2) * 20 * 0.15f;
    
    score = faceScore + directionScore1 + directionScore2;
    
    return score;
}

- (UIImage*)cropBestImg:(NSData *)data faceBox:(FaceInfo *)face {
    UIImage *original = [UIImage imageWithData:data];
    
    float cw = 0.5f * (face->x1 + face->x2);
    float ch = 0.5f * (face->y1 + face->y2);
    float faceWidth = fmax(fabs(face->x2 - face->x1), fabs(face->y1 - face->y2));
    float faceHeight = fmax(fabs(face->x2 - face->x1), fabs(face->y1 - face->y2));
    
    NSArray *ratioList = @[
        [[NSNumber alloc] initWithFloat:2 * (original.size.width - cw) / faceWidth],
        [[NSNumber alloc] initWithFloat:2 * (original.size.height - ch) / faceHeight],
        [[NSNumber alloc] initWithFloat:2 * cw / faceWidth],
        [[NSNumber alloc] initWithFloat:2 * ch / faceHeight]
    ];
    float ratio = ((NSNumber *)[ratioList valueForKeyPath:@"@min.self"]).floatValue;
    
    int left = floor(fmax(cw - faceWidth * ratio * 0.5f, 0.0f));
    int top = floor(fmax(ch - faceHeight * ratio * 0.5f, 0.0f));
    int width = floor(ratio * faceWidth);
    int height = floor(ratio * faceHeight);
    
    CGImageRef originalRef = [original CGImage];
    float resizeRatio = fmin(width / 640 - 0.01f, height / 640 - 0.01f);
    UIImage *faceImg = nil;
    if (resizeRatio > 1) {
        
    } else {
        CGRect rect = CGRectMake(left, top, width, height);
        CGImageRef faceImgRef = CGImageCreateWithImageInRect(originalRef, rect);
        faceImg = [UIImage imageWithCGImage:faceImgRef];
    }
    
    return faceImg;
}

- (void)cleanup {
    _currentFrameNumber = 0;
    _waitingNextAction = NO;
    _actionStatus = LNActionStatusFaceNoDefine;
    _poseType = LNPoseTypeNone;
    _warnCode = LNWarnCodeOKDefault;
    _currentFaceProb = 0.0f;
    [_frameQueue clean];
}

- (NSString *)detectionTypeString {
    switch (self.detectionType) {
        case LNDetectionTypeBlink:
            return @"眨眼";
        case LNDetectionTypeMouth:
            return @"张嘴";
        case LNDetectionTypePosYaw:
            return @"摇头";
        default:
            return @"";
    }
}
- (LNDetectionType)detectionType {
    if (self.detectOrder.count == 0) {
        return LNDetectionTypeNone;
    }
    NSNumber *number = [self.detectOrder objectAtIndex:0];
    LNDetectionType type = (LNDetectionType)[number unsignedIntValue];
    return type;
}

@end
