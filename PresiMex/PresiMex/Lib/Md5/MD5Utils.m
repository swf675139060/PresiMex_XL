//
//  MD5Utils.m
//  VANCL
//
//  Created by haiwang on 15/8/17.
//  Copyright (c) 2015年 vancl.com. All rights reserved.
//

#import "MD5Utils.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "YKGTMBase64.h"

@implementation MD5Utils

+ (NSString *)md5ContentWithOrigin:(NSString *) originContent
{
    const char *cStr = [originContent UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5( cStr, (int)strlen(cStr), result );
    
    return [[NSString
             stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1],
             result[2], result[3],
             result[4], result[5],
             result[6], result[7],
             result[8], result[9],
             result[10], result[11],
             result[12], result[13],
             result[14], result[15]
             ] lowercaseString];
}

+(NSString*)TripleDES:(NSString*)plainText key:(NSString*)key
{
    const void *vplainText;
    size_t plainTextBufferSize;
    //加密
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    plainTextBufferSize = [data length];
    vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    const void *vkey = (const void *)[key UTF8String];
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionECBMode | kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES ,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    NSString *result;
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    result = [GTMBase64 stringByEncodingData:myData];
    return result;
}

@end
