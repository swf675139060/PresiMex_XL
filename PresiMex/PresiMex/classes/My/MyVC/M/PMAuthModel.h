//
//  PMAuthModel.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/3.
//  用户授信信息model

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PMAuthModel : NSObject

@property (strong, nonatomic) NSString * antibody;//已使用额度（展示）
@property (strong, nonatomic) NSString * biodiversity;//最小可借额度（展示）
@property (strong, nonatomic) NSString * clear;//最小可借额度
@property (strong, nonatomic) NSString * foto;//用户总额度（展示）
@property (strong, nonatomic) NSString * lemon;//额度过期时间
@property (strong, nonatomic) NSString * medicine;//用户总额度
@property (strong, nonatomic) NSString * monster;//剩余可用额度
@property (strong, nonatomic) NSString * popularity;//已使用额度
@property (strong, nonatomic) NSString * researcher;//剩余可用额度（展示）
@property (strong, nonatomic) NSString * shop;//用户授信状态 授信状态:0 未执行、 10 审核中、20通过 、30 拒绝
@property (strong, nonatomic) NSString * social;//额度调整步长




@end

NS_ASSUME_NONNULL_END
