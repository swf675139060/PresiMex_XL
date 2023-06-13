//
//  PayTypeModel.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PayTypeModel : NSObject
@property(strong, nonatomic) NSString * fraction;//渠道ID va bank_account  store
@property(strong, nonatomic) NSString * merchandise;//渠道名称 目前与repayWay一样 va bank_account  store


@end

NS_ASSUME_NONNULL_END
