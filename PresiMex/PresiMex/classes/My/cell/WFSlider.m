//
//  WFSlider.m
//  PresiMex
//
//  Created by shenwenfeng on 2023/8/8.
//

#import "WFSlider.h"

@implementation WFSlider

// 控制slider的宽和高，这个方法才是真正的改变slider滑道的高的
- (CGRect)trackRectForBounds:(CGRect)bounds
{
    return CGRectMake(0, 0, CGRectGetWidth(self.frame), 8);
}

@end
