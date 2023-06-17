//
//  OrderDetailsVC.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/5.
//  订单详情

#import "WFBaseViewController.h"
#import "RepayModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailsVC : WFBaseViewController

@property (nonatomic, strong) NSString * repayId;//还款计划ID

@property (nonatomic, assign) BOOL beOverdue;//是否逾期

@end

NS_ASSUME_NONNULL_END
