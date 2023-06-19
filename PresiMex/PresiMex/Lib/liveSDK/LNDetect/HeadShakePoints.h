//
//  HeadShakePoints.h
//  YOLOv5NCNN
//
//  Created by Benjamin Wang on 2022/9/6.
//  Copyright © 2022 TENG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeadShakePoints : NSObject

@property(nonatomic, assign, readonly) double diffX;
@property(nonatomic, assign, readonly) double diffXRatio;
@property(nonatomic, assign, readonly) double crossDegree;

- (instancetype)initWithX1:(float)x1 y1:(float)y1 x2:(float)x2 y2:(float)y2 prob:(float)prob landmarks:(float *)landmarks;
- (BOOL)isShakeLeft:(BOOL)left;

@end

NS_ASSUME_NONNULL_END
