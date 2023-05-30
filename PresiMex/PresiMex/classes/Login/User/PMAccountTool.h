//
//  PMAccountTool.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/29.
//

#import <Foundation/Foundation.h>
#import "PMUser.h"
NS_ASSUME_NONNULL_BEGIN

//@class PMUser;

@interface PMAccountTool : NSObject

+ (void)saveAccount:(PMUser *)account;

+ (PMUser *)account;

+(BOOL)isLogin;
+(void)logOut;
@end

NS_ASSUME_NONNULL_END
