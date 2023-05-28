//
//  MD5Utils.h
//  VANCL
//
//  Created by haiwang on 15/8/17.
//  Copyright (c) 2015年 vancl.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5Utils : NSObject

//16位的MD5加密
+ (NSString *)md5ContentWithOrigin:(NSString *) originContent;


+(NSString*)TripleDES:(NSString*)plainText key:(NSString*)key;

@end
