//
//  AuthWaitingStoreAlert.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/25.
//  等待中弹出去评价的弹窗

#import "WFBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AuthWaitingStoreAlert : WFBaseView

//引导评价 等待中弹出去评价的弹窗
- (instancetype)initWithFrame:(CGRect)frame;


@property (copy, nonatomic)void(^clickBtnBlock)(void);
@property (assign, nonatomic) NSInteger storeCount;


-(void)uptime:(NSInteger)time;

// 隐藏星星
-(void)hiddenStore;
@end

NS_ASSUME_NONNULL_END
