//
//  PayVC.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/6.
//

#import "WFBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PayVC : WFBaseViewController

//付款方式文字 0:va 1:store
@property(strong, nonatomic) NSString * fraction;


//还款ID
@property(strong, nonatomic) NSString * repayId;

//1还款,2展期
@property(strong, nonatomic) NSString * repaymentType;

//优惠券ID
@property(strong, nonatomic) NSString * rated;



@property(strong, nonatomic) NSString * nu;//产品命


@end

NS_ASSUME_NONNULL_END
