//
//  HeadShakePoints.m
//  YOLOv5NCNN
//
//  Created by Benjamin Wang on 2022/9/6.
//  Copyright © 2022 TENG. All rights reserved.
//

#import "HeadShakePoints.h"

@interface HeadShakePoints ()
@property(nonatomic, assign, readonly) CGPoint noseTop;
@property(nonatomic, assign, readonly) CGPoint noseBottom;
@property(nonatomic, assign, readonly) CGPoint noseRight;
@property(nonatomic, assign, readonly) CGPoint noseLeft;
@property(nonatomic, assign, readonly) CGPoint cheekLeft;
@property(nonatomic, assign, readonly) CGPoint cheekRight;
@property(nonatomic, assign, readonly) CGPoint eyeCenterLeft;
@property(nonatomic, assign, readonly) CGPoint eyeCenterRight;
@property (nonatomic, assign) float x1;
@property (nonatomic, assign) float y1;
@property (nonatomic, assign) float x2;
@property (nonatomic, assign) float y2;
@property (nonatomic, assign) float prob;
@property (nonatomic, assign) float *landmarks;
@property (nonatomic, assign, readonly) double cutoff;
@end

@implementation HeadShakePoints

- (instancetype)initWithX1:(float)x1 y1:(float)y1 x2:(float)x2 y2:(float)y2 prob:(float)prob landmarks:(float *)landmarks {
    if (self = [super init]) {
        _x1 = x1;
        _y1 = y1;
        _x2 = x2;
        _y2 = y2;
        _prob = prob;
        _landmarks = landmarks;
        _cutoff = 0.02;
        _diffXRatio = [self calculateDiffXRatio];
        _crossDegree = [self calculateCrossDegree];
        _diffX = [self calculateDiffX];
    }
    return self;
}

- (BOOL)isShakeLeft:(BOOL)left {
    double rw = fabs(self.cheekRight.x - self.noseTop.x);
    double lw = fabs(self.cheekLeft.x - self.noseTop.x);
    if (left) {
        return (self.diffXRatio < -self.cutoff) && (lw > 2 * rw);
    } else {
        return (self.diffXRatio > self.cutoff) && (rw > 2 * lw);
    }
}

- (CGPoint)noseTop {
    return CGPointMake(_landmarks[72 * 2], _landmarks[72 * 2 + 1]);
}

- (CGPoint)noseBottom {
    return CGPointMake(_landmarks[80 * 2], _landmarks[80 * 2 + 1]);
}

- (CGPoint)noseRight {
    return CGPointMake(_landmarks[83 * 2], _landmarks[83 * 2 + 1]);
}

- (CGPoint)noseLeft {
    return CGPointMake(_landmarks[77 * 2], _landmarks[77 * 2 + 1]);
}

- (CGPoint)cheekLeft {
    return CGPointMake(_landmarks[1 * 2], _landmarks[1 * 2 + 1]);
}

- (CGPoint)cheekRight {
    return CGPointMake(_landmarks[17 * 2], _landmarks[17 * 2 + 1]);
}

- (CGPoint)eyeCenterRight {
    return CGPointMake(_landmarks[88 * 2], _landmarks[88 * 2 + 1]);
}

- (CGPoint)eyeCenterLeft {
    return CGPointMake(_landmarks[34 * 2], _landmarks[34 * 2 + 1]);
}

- (double)calculateDiffX {
    return fabs((self.cheekRight.x - self.noseBottom.x) / (self.cheekLeft.x - self.noseBottom.x));
}

- (double)calculateDiffXRatio {
    return (self.noseBottom.x - self.noseTop.x) / fabs(self.noseRight.x - self.noseLeft.x);
}

- (double)calculateCrossDegree {
    CGPoint h = CGPointMake(self.noseTop.x - self.noseBottom.x, self.noseTop.y - self.noseBottom.y);
    CGPoint w = CGPointMake(self.eyeCenterRight.x - self.eyeCenterLeft.x, self.eyeCenterRight.y - self.eyeCenterLeft.y);
    return (h.x * w.x + h.y * w.y) / ([self distanceP1:h p2:CGPointZero] * [self distanceP1:w p2:CGPointZero]);
}

- (float)distanceP1:(CGPoint)p1 p2:(CGPoint)p2 {
    float xDistance = p2.x - p1.x;
    float yDistance = p2.y - p1.y;
    return sqrtf((xDistance * xDistance) + (yDistance * yDistance));
}

@end
