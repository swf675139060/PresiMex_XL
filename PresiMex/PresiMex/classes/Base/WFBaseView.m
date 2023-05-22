//
//  WFBaseView.m
//  HLUIKit
//
//  Created by panxin on 2019/9/19.
//  Copyright © 2019 panxin. All rights reserved.
//

#import "WFBaseView.h"

@interface WFBaseView ()

@property (nonatomic, assign) BOOL haveBuildSubViews;

@end

@implementation WFBaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self buildSubViews];
        self.haveBuildSubViews = YES;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildSubViews];
        self.haveBuildSubViews = YES;
        [self setSubViewsPosition];
    }
    return self;
}


- (void)buildSubViews
{
    
}

- (void)setSubViewsPosition
{
    
}

@end
