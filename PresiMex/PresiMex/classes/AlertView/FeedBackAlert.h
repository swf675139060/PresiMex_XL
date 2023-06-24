//
//  FeedBackAlert.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/3.
//  连个label一个按钮

#import "WFBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedBackAlert : WFBaseView
//type 1: 成功 0 失败
- (instancetype)initWithFrame:(CGRect)frame withType:(NSInteger)type;

@property (copy, nonatomic)void(^clickBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
