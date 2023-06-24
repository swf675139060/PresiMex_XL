//
//  LoanFailAlert.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/23.
//

#import "WFBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoanFailAlert : WFBaseView

//type 没用
- (instancetype)initWithFrame:(CGRect)frame withType:(NSInteger)type;


@property (copy, nonatomic)void(^clickBtnBlock)(void);
@end

NS_ASSUME_NONNULL_END
