//
//  MouthPoints.m
//  YOLOv5NCNN
//
//  Created by Benjamin Wang on 2022/9/5.
//  Copyright © 2022 TENG. All rights reserved.
//

#import "MouthPoints.h"

@interface MouthPoints()
@property(nonatomic, assign, readonly) CGPoint left;
@property(nonatomic, assign, readonly) CGPoint right;
@property(nonatomic, assign, readonly) CGPoint lipUpperOuter;
@property(nonatomic, assign, readonly) CGPoint lipUpperInner;
@property(nonatomic, assign, readonly) CGPoint lipLowerOuter;
@property(nonatomic, assign, readonly) CGPoint lipLowerInner;
@property(nonatomic, assign, readonly) CGPoint p64;
@property(nonatomic, assign, readonly) double diffRatio;
@property(nonatomic, assign, readonly) double lipRatio;
@property(nonatomic, assign, readonly) double crossDegree;
@property (nonatomic, assign) float x1;
@property (nonatomic, assign) float y1;
@property (nonatomic, assign) float x2;
@property (nonatomic, assign) float y2;
@property (nonatomic, assign) float prob;
@property (nonatomic, assign) float *landmarks;
@end

@implementation MouthPoints

- (instancetype)initWithX1:(float)x1 y1:(float)y1 x2:(float)x2 y2:(float)y2 prob:(float)prob landmarks:(float *)landmarks {
    if (self = [super init]) {
        _x1 = x1;
        _y1 = y1;
        _x2 = x2;
        _y2 = y2;
        _prob = prob;
        _landmarks = landmarks;
        _diffRatio = [self calculateDiffRatio];
        _lipRatio = [self calculateLipRatio];
        _crossDegree = [self calculateCrossDegree];
    }
    return self;
}

- (CGPoint)left {
    return CGPointMake(_landmarks[52 * 2], _landmarks[52 * 2 + 1]);
}

- (CGPoint)right {
    return CGPointMake(_landmarks[61 * 2], _landmarks[61 * 2 + 1]);
}

- (CGPoint)lipUpperOuter {
    return CGPointMake(_landmarks[71 * 2], _landmarks[71 * 2 + 1]);
}

- (CGPoint)lipUpperInner {
    return CGPointMake(_landmarks[62 * 2], _landmarks[62 * 2 + 1]);
}

- (CGPoint)lipLowerOuter {
    return CGPointMake(_landmarks[53 * 2], _landmarks[53 * 2 + 1]);
}

- (CGPoint)lipLowerInner {
    return CGPointMake(_landmarks[60 * 2], _landmarks[60 * 2 + 1]);
}

- (CGPoint)p64 {
    return CGPointMake(_landmarks[64 * 2], _landmarks[64 * 2 + 1]);
}

- (BOOL)isOpen {
    return _lipRatio > 1.7;
}

- (BOOL)isClose {
    return _crossDegree > 0.65 || _lipRatio < 0.8;
}

- (double)calculateDiffRatio {
    return fabs(self.left.x - self.right.x) / fabs(self.lipUpperOuter.y - self.lipLowerOuter.y);
}

- (double)calculateLipRatio {
    double h1 = fabs(self.lipUpperOuter.y - self.lipUpperInner.y);
    double h2 = fabs(self.lipLowerOuter.y - self.lipLowerInner.y);
    double h = fabs(self.lipUpperInner.y - self.lipLowerInner.y);
    return 2 * h / (h1 + h2);
}

- (double)calculateCrossDegree {
    CGPoint h = CGPointMake(self.p64.x - self.left.x, self.p64.y - self.left.y);
    CGPoint w = CGPointMake(self.right.x - self.left.x, self.right.y - self.left.y);
    return fabs((h.x * w.x + h.y * w.y) / ([self distanceP1:h p2:CGPointZero] * [self distanceP1:w p2:CGPointZero]));
}

- (float)distanceP1:(CGPoint)p1 p2:(CGPoint)p2 {
    float xDistance = p2.x - p1.x;
    float yDistance = p2.y - p1.y;
    return sqrtf((xDistance * xDistance) + (yDistance * yDistance));
}

@end
