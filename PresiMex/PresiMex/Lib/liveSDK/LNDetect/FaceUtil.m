//
//  FaceUtil.m
//  YOLOv5NCNN
//
//  Created by Benjamin Wang on 2022/9/7.
//  Copyright © 2022 TENG. All rights reserved.
//

#import "FaceUtil.h"
#import "BlinkPoints.h"

@implementation FaceUtil

+ (LNFaceSize)faceSize:(FaceInfo)faceInfo targetSizeWidth:(double)width targetSizeHeight:(double)height {
    double wRatio = [FaceUtil faceWidth:faceInfo] / width;
    double hRatio = [FaceUtil faceHeight:faceInfo] / height;
    if (wRatio > 0.95 || hRatio > 0.95) {
        return LNFaceSizeLarge;
    } else if (wRatio < 0.2 || hRatio < 0.4) {
        return LNFaceSizeSmall;
    } else {
        return LNFaceSizeCorrect;
    }
}

+ (BOOL)isFaceCenter:(FaceInfo)faceInfo targetSizeWidth:(double)width targetSizeHeight:(double)height {
    int points[] = {72, 73, 74, 86, 80};
    double maxX = 0.0;
    double minX = 0.0;
    for (int i = 0; i < 5; i++) {
        maxX = fmax(faceInfo.landmarks[points[i] * 2], maxX);
        minX = fmax(faceInfo.landmarks[points[i] * 2], minX);
    }
    if (fabs(maxX - 0.5 * height) >= 0.3 * height) {
        return NO;
    }
    
    double y = faceInfo.landmarks[80 * 2 + 1];
    if (fabs(y - 0.5 * width) >= 0.3 * width) {
        return NO;
    }
    
    return YES;
}

+ (BOOL)isEyeOpen:(FaceInfo)faceInfo {
    BlinkPoints *points = [[BlinkPoints alloc] initWithX1:faceInfo.x1 y1:faceInfo.y1 x2:faceInfo.x2 y2:faceInfo.y2 prob:faceInfo.prob landmarks:faceInfo.landmarks];
    return [points isWeakOpen];
}

+ (double)faceWidth:(FaceInfo)faceInfo {
    return fabs(faceInfo.x2 - faceInfo.x1);
}

+ (double)faceHeight:(FaceInfo)faceInfo {
    return fabs(faceInfo.y2 - faceInfo.y1);
}

+ (FaceInfo)nullFaceInfo {
    FaceInfo noFace = {0.0f, 0.0f, 0.0f, 0.0f, 0.0f, NULL};
    return noFace;
}

+ (NSArray *)faceLandmarks:(FaceInfo)faceInfo {
    if (faceInfo.landmarks == NULL) {
        return @[];
    }
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (int i=0; i<212; i++) {
        [result addObject:@(faceInfo.landmarks[i])];
    }
    return result;
}

@end
