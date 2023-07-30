//
//  topLabelBottmBtnAlert.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/15.
//

#import "WFBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface topLabelBottmBtnAlert : WFBaseView

- (instancetype)initWithFrame:(CGRect)frame withConttent:(NSString *)Conttent btnTitel:(NSString *)btnTitle;


@property (copy, nonatomic)void(^clickBtnBlock)(void);
//设置成发送验证码三次的样式
-(void)setOPTtype;
@end

NS_ASSUME_NONNULL_END
