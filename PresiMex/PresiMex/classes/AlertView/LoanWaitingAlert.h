//
//  LoanWaitingAlert.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/23.
//  借款处理中

#import "WFBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoanWaitingAlert : WFBaseView

//type 1:引导评价  0 不引导评价
- (instancetype)initWithFrame:(CGRect)frame withType:(NSInteger)type;


@property (copy, nonatomic)void(^clickBtnBlock)(void);

@property (copy, nonatomic)void(^clickCloseBtnBlock)(void);

@property (assign, nonatomic) NSInteger storeCount;;

@end

NS_ASSUME_NONNULL_END
