//
//  BankConfrimAlert.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/24.
//  银行确认弹框

#import "WFBaseView.h"
#import "bankcardModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BankConfrimAlert : WFBaseView

@property(strong, nonatomic) bankcardModel * bankModel;

@property(strong, nonatomic) NSString * money;
//type 没用
- (instancetype)initWithFrame:(CGRect)frame withType:(NSInteger)type;

@property (copy, nonatomic)void(^clickBtnBlock)(NSInteger indx);
@end

NS_ASSUME_NONNULL_END
