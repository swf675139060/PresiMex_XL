//
//  FaceUtil.h
//  YOLOv5NCNN
//
//  Created by Benjamin Wang on 2022/9/7.
//  Copyright © 2022 TENG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FaceInfo.h"
#import "DetectorTypes.h"

NS_ASSUME_NONNULL_BEGIN

@interface FaceUtil : NSObject

+ (LNFaceSize)faceSize:(FaceInfo)faceInfo targetSizeWidth:(double)width targetSizeHeight:(double)height;
+ (BOOL)isFaceCenter:(FaceInfo)faceInfo targetSizeWidth:(double)width targetSizeHeight:(double)height;
+ (BOOL)isEyeOpen:(FaceInfo)faceInfo;
+ (double)faceWidth:(FaceInfo)faceInfo;
+ (double)faceHeight:(FaceInfo)faceInfo;
+ (NSArray *)faceLandmarks:(FaceInfo)faceInfo;
+ (FaceInfo)nullFaceInfo;

@end

NS_ASSUME_NONNULL_END
