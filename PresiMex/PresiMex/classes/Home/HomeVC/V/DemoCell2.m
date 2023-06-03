//
//  DemoCell2.m
//  RollingNotice
//
//  Created by qm on 2017/12/13.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "DemoCell2.h"

@interface DemoCell2 ()

@property (nonatomic, strong) UIButton *testBtn;



@end

@implementation DemoCell2

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

// cell 高度30
- (void)setupUI
{
    self.backgroundColor = [UIColor jk_colorWithHexString:@"#FC7500"];
    
    UIButton *testBtn = [[UIButton alloc] init];
    testBtn.frame = CGRectMake(15, 0, 11, 33);
    [testBtn setImage:[UIImage imageNamed:@"tongzhi"] forState:UIControlStateNormal];
    [self.contentView addSubview:testBtn];
    
  
    
    _customLab = [[UILabel alloc]initWithFrame:CGRectMake(36, 0, WF_ScreenWidth - 56, 33)];
    _customLab.textColor = [UIColor jk_colorWithHexString:@"#FFFFFF"];
    _customLab.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:_customLab];
}

@end
