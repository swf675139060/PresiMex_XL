//
//  DetectorTypes.h
//  YOLOv5NCNN
//
//  Created by Benjamin Wang on 2022/9/7.
//  Copyright © 2022 TENG. All rights reserved.
//

#ifndef DetectorTypes_h
#define DetectorTypes_h

typedef enum LNDetectionResultCode: NSUInteger {
    LNDetectionResultErrorNoFace = 40000,
    LNDetectionResultErrorUserCancel = 40001,
    LNDetectionResultErrorModelInitFailed = 40002,
    LNDetectionResultErrorTimeOut = 40003,
    LNDetectionResultErrorMultipleFace = 40004,
    LNDetectionResultErrorMultipleAction = 40005,
    LNDetectionResultErrorInitFailed = 40006,
    LNDetectionResultErrorDetectionFailed = 40007,
    LNDetectionResultErrorNetworkError = 40008,
    LNDetectionResultSuccess = 200
} LNDetectionResultCode;

typedef enum LNFaceSize: NSUInteger {
    LNFaceSizeCorrect,
    LNFaceSizeLarge,
    LNFaceSizeSmall,
} LNFaceSize;

typedef enum LNDetectionType: NSUInteger {
    LNDetectionTypeNone,
    LNDetectionTypeBlink,
    LNDetectionTypeMouth,
    LNDetectionTypePosYaw,
    LNDetectionTypeAimless,
    LNDetectionTypeDone
} LNDetectionType;

typedef enum LNPoseType: NSUInteger {
    LNPoseTypeHeadMiddle,
    LNPoseTypeHeadLeft,
    LNPoseTypeHeadRight,
    LNPoseTypeMouthClose,
    LNPoseTypeMouthOpen,
    LNPoseTypeEyeClose,
    LNPoseTypeEyeOpen,
    LNPoseTypeNone
} LNPoseType;

typedef enum LNStageType: NSUInteger {
    LNStageTypeReady,
    LNStageTypeEyeReady,
    LNStageTypeEyeClose,
    LNStageTypeEyeOpen,
    LNStageTypeEyeOK,
    LNStageTypeHeadReady,
    LNStageTypeHeadLeft,
    LNStageTypeHeadRight,
    LNStageTypeHeadOK,
    LNStageTypeMouthReady,
    LNStageTypeMouthClose,
    LNStageTypeMouthOpen,
    LNStageTypeMouthOK
} LNStageType;

typedef enum LNActionStatus: NSUInteger {
    LNActionStatusNoFace,
    LNActionStatusMultipleFace,
    LNActionStatusFaceCheckSize,
    LNActionStatusFaceIsReady,
    LNActionStatusFaceCenterReady,
    LNActionStatusFaceStillReady,
    LNActionStatusFaceFrontAlready,
    LNActionStatusFaceCaptureReady,
    LNActionStatusFaceMotionReady,
    LNActionStatusFaceBlink,
    LNActionStatusFaceMouth,
    LNActionStatusFaceYaw,
    LNActionStatusFaceInit,
    LNActionStatusFaceNoDefine
} LNActionStatus;

typedef enum LNWarnCode: NSUInteger {
    LNWarnCodeFaceMissing,
    LNWarnCodeFaceLarge,
    LNWarnCodeFaceSmall,
    LNWarnCodeFaceNotCenter,
    LNWarnCodeFaceNotFrontal,
    LNWarnCodeFaceNotStill,
    LNWarnCodeFaceMultiple,
    LNWarnCodeEyeOcclusion,
    LNWarnCodeMouthOcclusion,
    LNWarnCodeFaceCapture,
    LNWarnCodeFaceInAction,
    LNWarnCodeOkActionDone,
    LNWarnCodeErrorFaceMissing,
    LNWarnCodeErrorFaceMultiple,
    LNWarnCodeErrorMuchMotion,
    LNWarnCodeOKCounting,
    LNWarnCodeOKDefault,
    LNWarnCodeWarnMotion,
    LNWarnCodeWarnLargeYaw
} LNWarnCode;

typedef enum LNDetectionFailedType: NSUInteger {
    LNDetectionFailedTypeTimeout,
    LNDetectionFailedTypeWeakLight,
    LNDetectionFailedTypeStrongLight,
    LNDetectionFailedTypeFaceMissing,
    LNDetectionFailedTypeMultipleFace,
    LNDetectionFailedTypeMuchMotion,
    LNDetectionFailedTypeUnauthorized,
    LNDetectionFailedTypeUnsupportDevice
} LNDetectionFailedType;

#endif /* DetectorTypes_h */
