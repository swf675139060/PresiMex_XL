//
//  BlinkPoints.m
//  YOLOv5NCNN
//
//  Created by Benjamin Wang on 2022/9/5.
//  Copyright © 2022 TENG. All rights reserved.
//

#import "BlinkPoints.h"

@interface BlinkPoints ()
@property(nonatomic, assign, readonly) CGPoint p1;
@property(nonatomic, assign, readonly) CGPoint p2;
@property(nonatomic, assign, readonly) CGPoint p3;
@property(nonatomic, assign, readonly) CGPoint p4;
@property(nonatomic, assign, readonly) CGPoint p5;
@property(nonatomic, assign, readonly) CGPoint p6;
@property(nonatomic, assign, readonly) double ear;
@property (nonatomic, assign) float x1;
@property (nonatomic, assign) float y1;
@property (nonatomic, assign) float x2;
@property (nonatomic, assign) float y2;
@property (nonatomic, assign) float prob;
@property (nonatomic, assign) float *landmarks;
@end

@implementation BlinkPoints

- (instancetype)initWithX1:(float)x1 y1:(float)y1 x2:(float)x2 y2:(float)y2 prob:(float)prob landmarks:(float *)landmarks {
    if (self = [super init]) {
        _x1 = x1;
        _y1 = y1;
        _x2 = x2;
        _y2 = y2;
        _prob = prob;
        _landmarks = landmarks;
        _ear = [self calculateEar];
    }
    return self;
}


- (CGPoint)p1 {
    return CGPointMake(_landmarks[35 * 2], _landmarks[35 * 2 + 1]);
}

- (CGPoint)p2 {
    return CGPointMake(_landmarks[41 * 2], _landmarks[41 * 2 + 1]);
}

- (CGPoint)p3 {
    return CGPointMake(_landmarks[42 * 2], _landmarks[42 * 2 + 1]);
}

- (CGPoint)p4 {
    return CGPointMake(_landmarks[39 * 2], _landmarks[39 * 2 + 1]);
}

- (CGPoint)p5 {
    return CGPointMake(_landmarks[37 * 2], _landmarks[37 * 2 + 1]);
}

- (CGPoint)p6 {
    return CGPointMake(_landmarks[36 * 2], _landmarks[36 * 2 + 1]);
}

- (BOOL)isClose {
    return self.ear < 0.2;
}

- (BOOL)isStrictClose {
    return self.ear < 0.15;
}

- (BOOL)isOpen {
    return self.ear > 0.2;
}

- (BOOL)isWeakOpen {
    return self.ear > 0.1;
}

- (float)distanceP1:(CGPoint)p1 p2:(CGPoint)p2 {
    float xDistance = p2.x - p1.x;
    float yDistance = p2.y - p1.y;
    return sqrtf((xDistance * xDistance) + (yDistance * yDistance));
}

- (float)calculateEar {
    float part1 = [self distanceP1:self.p2 p2:self.p6];
    float part2 = [self distanceP1:self.p3 p2:self.p5];
    float part3 = [self distanceP1:self.p1 p2:self.p4];
    return (part1 + part2) / (2 * part3);
}

@end
