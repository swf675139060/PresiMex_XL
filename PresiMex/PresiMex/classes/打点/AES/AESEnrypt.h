//
//  AESEnrypt.h
//  aes
//
//  Created by shenwenfeng on 2023/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AESEnrypt : NSObject

+ (NSString*) AES128Encrypt:(NSString *)plainText gkey:(NSString *)gkey;
 
//+ (NSString*) AES128Decrypt:(NSString *)encryptText gkey:(NSString *)gkey;
@end

NS_ASSUME_NONNULL_END
