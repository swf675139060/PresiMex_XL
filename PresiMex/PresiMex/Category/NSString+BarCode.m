//
//  NSString+BarCode.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/17.
//

#import "NSString+BarCode.h"

@implementation NSString (BarCode)

+ (UIImage *)generateBarcodeFromString:(NSString *)string withColor:(UIColor *)color andSize:(CGSize)size {
    //1.将字符串转出NSData
    NSData *img_data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    //2.将字符串变成二维码滤镜
//    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    
    //3.恢复滤镜的默认属性
    [filter setDefaults];
    
    //4.设置滤镜的 inputMessage
    [filter setValue:img_data forKey:@"inputMessage"];
    
    //5.获得滤镜输出的图像
    CIImage *img_CIImage = [filter outputImage];
    
    //6.此时获得的二维码图片比较模糊，通过下面函数转换成高清
    CGFloat scaleX = size.width / img_CIImage.extent.size.width;//300是你想要的长
    CGFloat scaleY = size.height / img_CIImage.extent.size.height;//70是你想要的宽
      img_CIImage = [img_CIImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    UIImage * img_BarCode =  [UIImage imageWithCIImage:img_CIImage];
    return img_BarCode;
        
}

@end
