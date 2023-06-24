//
//  PhotoTipAlert.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/24.
//  身份证、人脸识别弹窗

#import "WFBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoTipAlert : WFBaseView
//type 0 :正面 1背面 2人脸识别弹窗
- (instancetype)initWithFrame:(CGRect)frame withType:(NSInteger)type;
@property (copy, nonatomic)void(^clickBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
