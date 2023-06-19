//
//  BlinkPoints.h
//  YOLOv5NCNN
//
//  Created by Benjamin Wang on 2022/9/5.
//  Copyright © 2022 TENG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlinkPoints : NSObject

- (instancetype)initWithX1:(float)x1 y1:(float)y1 x2:(float)x2 y2:(float)y2 prob:(float)prob landmarks:(float *)landmarks;
- (BOOL)isClose;
- (BOOL)isStrictClose;
- (BOOL)isOpen;
- (BOOL)isWeakOpen;
@end

NS_ASSUME_NONNULL_END
