//
//  ThreeLabelAlert.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/10.
//  逾期费说明气泡浮窗

#import "WFBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThreeLabelAlert : WFBaseView

//type 0: 逾期费说明气泡浮窗 1:展（分）期费说明气泡浮窗
- (instancetype)initWithFrame:(CGRect)frame withType:(NSInteger)type;

@property (copy, nonatomic)void(^clickBtnBlock)(void);
@end

NS_ASSUME_NONNULL_END
