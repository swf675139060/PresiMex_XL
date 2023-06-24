//
//  AllFailAlert.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/24.
//  目前用户： 身份证、人脸 认证失败弹框

#import "WFBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AllFailAlert : WFBaseView

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title  content:(NSString *)content;

@property (copy, nonatomic)void(^clickBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
