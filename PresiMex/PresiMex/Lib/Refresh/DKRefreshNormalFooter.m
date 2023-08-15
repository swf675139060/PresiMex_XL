//
//  DKRefreshNormalFooter.m
//  Dana Disini
//
//  Created by swf on 2021/5/18.
//

#import "DKRefreshNormalFooter.h"

@implementation DKRefreshNormalFooter

- (void)prepare
{
    [super prepare];
    
    //根据下拉比例修改透明度
    [self setAutomaticallyChangeAlpha:YES];
}

@end
