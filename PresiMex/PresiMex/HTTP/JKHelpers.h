//
//  JKHelpers.h
//  OPESO
//
//  Created by 王二麻子 on 2021/9/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKHelpers : NSObject
/// 计算字体大小

+ (CGSize)sizeWithText:(NSString *)text fontSize:(CGFloat)size andMaxsize: (CGFloat)maxWidth;
+ (CGSize)sizeWithText:(NSString *)text fontSize:(UIFont*)font;
///不含\n
+ (NSString *)jk_jsonStringCompactFormatForDictionary:(NSDictionary *)dicJson;
///含\n
+(NSString*)jk_jsonStringPrettyPrintedFormatForDictionary:(NSDictionary *)dict;
//数组转josn
+(NSString *)arrayToJSONStringWithArray:(NSArray*)arr;
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
/**
 *  调整图片尺寸和大小
 *
 *  @param sourceImage  原始图片
 *  @param maxImageSize 新图片最大尺寸
 *  @param maxSize      新图片最大存储大小
 *
 *  @return 新图片imageData
 */
+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize;
///检查字符串是否为空
+ (BOOL)checkForNull:(NSString *)checkString;
//转换为年月日
+(NSString *)time_YMD_TransformWithTimestamp:(NSInteger)timestamp;
//转换为年月日时分秒
+(NSString *)time_YMDHMS_TransformWithTimestamp:(NSInteger)timestamp;
/**
 *  获得与当前\后的时间
 */
+(NSString *)dateStringAfterlocalDateForYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day Hour:(NSInteger)hour Minute:(NSInteger)minute Second:(NSInteger)second;

/**
 *  获得与当几天/前/后的时间
 */
+(NSString *)dateStringAfterlocalDateDay:(NSInteger)day  withSeverTimestamp:(NSInteger)timestamp;

//时间格式转换

+(NSString*)time_MDYTransformWithString:(NSString*)time;
//获取当前时间戳
+(NSString *)getNowTimeTimestamp;
//获取当前时间
+(NSString*)getCurrentTimes;

@end

NS_ASSUME_NONNULL_END
