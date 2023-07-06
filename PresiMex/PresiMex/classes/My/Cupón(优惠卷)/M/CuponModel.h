//
//  CuponModel.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CuponModel : NSObject
@property (strong, nonatomic) NSString * rated;//优惠券ID
@property (strong, nonatomic) NSString * demanding;//产品ID A:通用(所有产品都可使用)
@property (strong, nonatomic) NSString * nu;//产品名称
@property (strong, nonatomic) NSString * rev;//优惠券名称
@property (strong, nonatomic) NSString * southeast;//使用途径1:正常还款 2:逾期还款
@property (strong, nonatomic) NSString * flip;//优惠券金额
@property (strong, nonatomic) NSString * readers;//优惠券金额(展示)
@property (strong, nonatomic) NSString * ruby;//到期时间
@property (strong, nonatomic) NSString * guarantee;//是否可用 0:不可用 1:可用 2:过期
@end

NS_ASSUME_NONNULL_END
