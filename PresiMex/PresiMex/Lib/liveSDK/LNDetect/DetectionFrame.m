//
//  DetectionFrame.m
//  YOLOv5NCNN
//
//  Created by Benjamin Wang on 2022/9/7.
//  Copyright © 2022 TENG. All rights reserved.
//

#import "DetectionFrame.h"
#import "FaceUtil.h"

@interface DetectionFrame ()
@property (nonatomic, assign) int frameNumber;
@property (nonatomic, assign) LNDetectionType detectionType;
@end

@implementation DetectionFrame

- (instancetype)initWithImage:(UIImage *)image detectionType:(LNDetectionType)detectionType frameNumber:(int)frameNumber {
    if (self = [super init]) {
        _image = image;
        _detectionType = detectionType;
        _frameNumber = frameNumber;
        _faceInfo = [FaceUtil nullFaceInfo];
    }
    return self;
}

- (BOOL)hasFace {
    if (self.faceInfo.x1 == [FaceUtil nullFaceInfo].x1 && self.faceInfo.x2 == [FaceUtil nullFaceInfo].x2
        && self.faceInfo.y1 == [FaceUtil nullFaceInfo].y1 && self.faceInfo.y2 == [FaceUtil nullFaceInfo].y2
        && self.faceInfo.prob == [FaceUtil nullFaceInfo].prob && self.faceInfo.landmarks == [FaceUtil nullFaceInfo].landmarks) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)isFaceCenter {
    if ([self hasFace] == NO) {
        return NO;
    }
    return [FaceUtil isFaceCenter:self.faceInfo targetSizeWidth:self.image.size.width targetSizeHeight:self.image.size.height];
}

- (BOOL)isEyeOpen {
    if ([self hasFace] == NO) {
        return NO;
    }
    return [FaceUtil isEyeOpen:self.faceInfo];
}

- (LNFaceSize)getFaceSize {
    return [FaceUtil faceSize:self.faceInfo targetSizeWidth:self.image.size.width targetSizeHeight:self.image.size.height];
}

@end
