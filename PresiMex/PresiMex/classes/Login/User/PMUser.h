//
//  PMUser.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PMUser : NSObject

/**
 *  获取授权后的 token
 */
@property (nonatomic, copy) NSString *token;

@property (nonatomic, copy) NSString *customer_user_id;

@property (nonatomic, copy) NSString *tel;

@property (nonatomic, copy) NSString *isForceData;

@property (nonatomic, copy) NSString *isVer;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
