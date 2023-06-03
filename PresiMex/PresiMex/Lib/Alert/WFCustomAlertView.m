//
//  WFCustomAlertView.m
//
//  Created by swf on 2023/1/7.
//

#import "WFCustomAlertView.h"
@interface WFCustomAlertView()

/** 弹窗主内容view */
@property (nonatomic,strong) UIView   *contentView;


@end
@implementation WFCustomAlertView

- (instancetype)initWithContentView:(UIView *)contentView
 {
    if (self = [super init]) {
        
        self.contentView = contentView;
        [self sutUpView];
    }
    return self;
}

- (void)sutUpView{
    
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.85];
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
    }];
    [self addSubview:self.contentView];

}

- (void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}




#pragma mark - 移除此弹窗
/** 移除此弹窗 */
- (void)dismiss{
    [self removeFromSuperview];
}



@end
