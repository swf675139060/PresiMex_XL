//
//  PayResultModel.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PayResultModel : NSObject

@property(strong, nonatomic) NSString * become;//还款订单状态字符
@property(strong, nonatomic) NSString * prairie;//还款ID
@property(strong, nonatomic) NSString * small;//还款订单状态 状态 10:待还款 11:逾期 20:已还款 30:展期关闭 40:部分还款关闭 50:平账关闭

@end

NS_ASSUME_NONNULL_END
