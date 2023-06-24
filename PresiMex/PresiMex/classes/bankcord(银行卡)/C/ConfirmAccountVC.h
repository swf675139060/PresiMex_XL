//
//  ConfirmAccountVC.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/17.
//

#import "WFBaseViewController.h"
#import "bankcardModel.h"
#import "OrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConfirmAccountVC : WFBaseViewController

//0  只修改账号 1重新借款（修改并弹框提交）
@property(assign, nonatomic) BOOL reLoan;

@property(strong, nonatomic) bankcardModel * bankModel;

//重新提交时传
@property(strong, nonatomic) OrderModel * orderModel;//  订单model


// 点击确认按钮
@property(copy, nonatomic)void(^clickConfirmBlock)(bankcardModel * bankModel);

@end

NS_ASSUME_NONNULL_END
