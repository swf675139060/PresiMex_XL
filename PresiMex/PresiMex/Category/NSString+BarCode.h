//
//  NSString+BarCode.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (BarCode)
//将文字生成条形码
+ (UIImage *)generateBarcodeFromString:(NSString *)string withColor:(UIColor *)color andSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
