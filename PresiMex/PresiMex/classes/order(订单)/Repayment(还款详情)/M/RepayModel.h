//
//  RepayModel.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RepayModel : NSObject

@property(strong, nonatomic) NSString * prairie;//还款订单ID
@property(strong, nonatomic) NSString * demanding;//产品Code
@property(strong, nonatomic) NSString * nu;//产品名称
@property(strong, nonatomic) NSString * transcripts;//本金
@property(strong, nonatomic) NSString * lower;//本金，用于展示，带千分位符
@property(strong, nonatomic) NSString * cook;//到期时间/应还款时间
@property(strong, nonatomic) NSString * luis;//逾期天数
@property(strong, nonatomic) NSString * evident;//逾期费(比索)
@property(strong, nonatomic) NSString * fifteen;//逾期费(比索)，用于展示，带千分位符
@property(strong, nonatomic) NSString * provide;//已支付金额(比索)
@property(strong, nonatomic) NSString * gang;//已支付金额(比索)，用于展示，带千分位符

@property(strong, nonatomic) NSString * shaw;//减免金额(比索)
@property(strong, nonatomic) NSString * shortly;//减免金额(比索)，用于展示，带千分位符
@property(strong, nonatomic) NSString * pgp;//应还款金额(比索)
@property(strong, nonatomic) NSString * tt;//应还款金额(比索)，用于展示，带千分位符
@property(strong, nonatomic) NSString * chef;//服务费率/天

//展期
@property(strong, nonatomic) NSString * powell;//展期费(比索)
@property(strong, nonatomic) NSString * qty;//展期费(比索)，用于展示，带千分位符
@property(strong, nonatomic) NSString * talk;//展期订单应还时间


@end

NS_ASSUME_NONNULL_END
