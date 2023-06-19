//
//  FaceInfo.h
//  YOLOv5NCNN
//
//  Created by Benjamin Wang on 2022/9/7.
//  Copyright © 2022 TENG. All rights reserved.
//

#ifndef FaceInfo_h
#define FaceInfo_h

typedef struct FaceInfo {
    float x1;
    float y1;
    float x2;
    float y2;
    float prob;
    float *landmarks;
} FaceInfo;

#endif /* FaceInfo_h */
