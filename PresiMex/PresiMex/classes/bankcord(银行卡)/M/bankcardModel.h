//
//  bankcardModel.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface bankcardModel : NSObject

@property(strong, nonatomic) NSString * diameter;//    账户方式:1-银行账号,2-CLABE

@property(strong, nonatomic) NSString * framework;//银行编码

@property(strong, nonatomic) NSString * marshall;//银行名称

@property(strong, nonatomic) NSString * diploma;//账户号

@property(strong, nonatomic) NSString * observer;//查询用户当前使用银行卡时,只会展示状态为0(正常)的状态：0-正常 , 1-停用

@end

NS_ASSUME_NONNULL_END
