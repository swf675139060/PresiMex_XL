//
//  DetectionFrame.h
//  YOLOv5NCNN
//
//  Created by Benjamin Wang on 2022/9/7.
//  Copyright © 2022 TENG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DetectorTypes.h"
#import "FaceInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetectionFrame : NSObject
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) FaceInfo faceInfo;
@property (nonatomic, assign, readonly) LNDetectionType detectionType;
@property (nonatomic, assign, readonly) int frameNumber;

- (instancetype)initWithImage:(UIImage *)image detectionType:(LNDetectionType)detectionType frameNumber:(int)frameNumber;
- (BOOL)hasFace;
- (BOOL)isFaceCenter;
- (BOOL)isEyeOpen;
- (LNFaceSize)getFaceSize;

@end

NS_ASSUME_NONNULL_END
