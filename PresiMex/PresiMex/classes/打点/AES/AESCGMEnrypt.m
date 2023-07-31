//
//  AESCGMEnrypt.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/7/30.
//

#import "AESCGMEnrypt.h"
#import <CommonCrypto/CommonCryptor.h>





@implementation AESCGMEnrypt

+ (NSData *)CBCWithOperation:(CCOperation)operation andIv:(NSString *)ivString andKey:(NSString *)keyString andInput:(NSData *)inputData

{
    
    const char *iv = [[ivString dataUsingEncoding: NSUTF8StringEncoding] bytes]; const char *key = [[keyString dataUsingEncoding: NSUTF8StringEncoding] bytes];
    
    CCCryptorRef cryptor;
    
    CCCryptorCreateWithMode(operation, kCCModeCFB, kCCAlgorithmAES128, ccNoPadding, iv, key, [keyString length], NULL, 0, 0, 0, &cryptor);
    
    NSUInteger inputLength = inputData.length;
    
    char *outData = malloc(inputLength);
    
    memset(outData, 0, inputLength);
    
    size_t outLength = 0;
    
    CCCryptorUpdate(cryptor, inputData.bytes, inputLength, outData, inputLength, &outLength);
    
    NSData *data = [NSData dataWithBytes: outData length: outLength];
    
    CCCryptorRelease(cryptor);
    
    free(outData);
    
    return data;
    
}

+ (NSString *)encryptAESCBC:(NSString *)inputString withKey:(NSString*)key

{
    if (inputString.length<1|key.length<1) {
        return  nil;
    } 
    
    NSString* iv = @"0000000000000000";
    
    
    NSMutableData *inputData = [NSMutableData dataWithData: [inputString dataUsingEncoding: NSUTF8StringEncoding]];
    
    NSData *outData = [self CBCWithOperation: kCCEncrypt andIv:iv  andKey:key andInput: inputData];
    
    outData = [outData base64EncodedDataWithOptions: NSDataBase64EncodingEndLineWithLineFeed];
    
    return [[NSString alloc] initWithData: outData encoding: NSUTF8StringEncoding] ?: @"";
    
}





@end

