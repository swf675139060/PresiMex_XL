//
//  PMAddBankViewController.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/6/3.
//

#import "WFBaseViewController.h"
#import "bankcardModel.h"
#import "OrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PMAddBankViewController : WFBaseViewController

// VCType 0: 添加，  1:修改
@property(assign, nonatomic) NSInteger VCType;

//0  只修改账号 1重新借款（修改并弹框提交）
@property(assign, nonatomic) BOOL reLoan;

@property(copy, nonatomic) void(^changeBlock)(bankcardModel  *bankModel);


//重新提交时传
@property(strong, nonatomic) OrderModel * orderModel;//  订单model


@end

NS_ASSUME_NONNULL_END
