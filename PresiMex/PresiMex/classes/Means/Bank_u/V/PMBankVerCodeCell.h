//
//  PMBankVerCodeCell.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/23.
//  修改银行卡发送验证码

#import "WFBaseViewCell.h"
#import "PMQuestionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PMBankVerCodeCell : WFBaseViewCell

@property (nonatomic, strong) UIButton *btn;

-(void)setCellWithModel:(PMQuestionModel*)model btnTitle:(NSString *)btnTitle;
// 按钮是否是数字的背景
-(void)setBtnBGType:(BOOL)number;

@property (nonatomic, copy) void(^endInputBlock) (NSString *title, NSString *text);

@property (nonatomic, copy) void(^clickSendBlock) (void);
@end

NS_ASSUME_NONNULL_END
