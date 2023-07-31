//
//  AESCGMEnrypt.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/7/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AESCGMEnrypt : NSObject
+ (NSString *)encryptAESCBC:(NSString *)inputString withKey:(NSString*)key;
@end

NS_ASSUME_NONNULL_END
