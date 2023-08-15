//
//  DKRefreshNormalHeader.m
//  Dana Disini
//
//  Created by swf on 2021/5/18.
//

#import "DKRefreshNormalHeader.h"

@implementation DKRefreshNormalHeader

- (void)prepare
{
    [super prepare];
    
    //解决下拉刷新被头部放大视图则该bug
    self.layer.zPosition = 10000;
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
    //根据下拉比例修改透明度
    [self setAutomaticallyChangeAlpha:YES];
}

@end
