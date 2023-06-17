//
//  JKHelpers.m
//  OPESO
//
//  Created by 王二麻子 on 2021/9/27.
//

#import "JKHelpers.h"

@implementation JKHelpers
+ (CGSize)sizeWithText:(NSString *)text fontSize:(CGFloat)size andMaxsize: (CGFloat)maxWidth {
    
    NSDictionary *arrts = @{NSFontAttributeName: [UIFont systemFontOfSize:size]};
    CGSize biggestSize = CGSizeMake(maxWidth, MAXFLOAT);
    
    return [text boundingRectWithSize:biggestSize options:NSStringDrawingUsesLineFragmentOrigin attributes:arrts context:nil].size;
}
+ (CGSize)sizeWithText:(NSString *)text fontSize:(UIFont*)font{
    
    NSMutableDictionary *arrts = [NSMutableDictionary dictionary];
    arrts[NSFontAttributeName] =font;
    return [text sizeWithAttributes:arrts];
}
// 读取本地JSON文件
-(NSArray *)readLocalFileWithName:(NSDictionary *)name {
    // 获取文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
//    NSString * path = [NSString stringWithFormat:@"/Users/admin/work/json/5012.json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
    
}
// 写入本地JSON文件
- (void)writJson:(NSArray*)json_dic{
    
//    NSString * filePath = [NSString stringWithFormat:@"/Users/admin/work/json/myJs.json"];
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/myJson.json"];
    NSData *json_data = [NSJSONSerialization dataWithJSONObject:json_dic options:NSJSONWritingPrettyPrinted error:nil];
    BOOL a =   [json_data writeToFile:filePath atomically:YES];
    if (a) {
        NSLog(@"路径：%@",filePath);
    }else {
        NSLog(@"存储失败");
    }
}
//将字典转换成json格式字符串,不含\n这些符号
+ (NSString *)jk_jsonStringCompactFormatForDictionary:(NSDictionary *)dicJson {


    if (![dicJson isKindOfClass:[NSDictionary class]] || ![NSJSONSerialization isValidJSONObject:dicJson]) {

        return nil;

    }

    

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicJson options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];

    NSString *strJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    return strJson;

}

 

//将数组转换成json格式字符串,不含\n这些符号

+ (NSString *)jk_jsonStringCompactFormatForNSArray:(NSArray *)arrJson {

    

    if (![arrJson isKindOfClass:[NSArray class]] || ![NSJSONSerialization isValidJSONObject:arrJson]) {

        return nil;

    }

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arrJson options:0 error:nil];

    NSString *strJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    return strJson;

}

 

//将字典转换成json格式字符串,含\n这些符号,便于阅读

+ (NSString *)jk_jsonStringPrettyPrintedFormatForDictionary:(NSDictionary *)dicJson {

    if (![dicJson isKindOfClass:[NSDictionary class]] || ![NSJSONSerialization isValidJSONObject:dicJson]) {

        return nil;

    }


    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicJson options:NSJSONWritingPrettyPrinted error:nil];

    NSString *strJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    return strJson;

}
+(NSString *)arrayToJSONStringWithArray:(NSArray*)arr
{
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:arr
                                                   options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                     error:nil];
    
    if (data == nil) {
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    return string;
//
//    NSError *error = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    return jsonString;
}

+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize
{
    
    if (maxSize <= 0.0) maxSize = 1024.0;
    
    if (maxImageSize) {
        
        //先调整分辨率
        CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
        if (maxImageSize <= 0.0) maxImageSize = 1024.0;
        CGFloat tempHeight = newSize.height / maxImageSize;
        CGFloat tempWidth = newSize.width / maxImageSize;
        
        if (tempWidth > 1.0 && tempWidth > tempHeight) {
            newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
        }
        else if (tempHeight > 1.0 && tempWidth < tempHeight){
            newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
        }
        UIGraphicsBeginImageContext(newSize);
        
        [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    }
    
    
    
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (newImage == nil) {
        newImage = sourceImage;
    }
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    CGFloat sizeOriginKB = imageData.length / 1024.0;
    
    CGFloat resizeRate = 0.7;
    while (sizeOriginKB > maxSize && resizeRate > 0.1) {
        imageData = UIImageJPEGRepresentation(newImage,resizeRate);
        sizeOriginKB = imageData.length / 1024.0;
        resizeRate -= 0.1;
    }
    
    return imageData;
}
+ (BOOL)checkForNull:(NSString *)checkString {
    
    if (checkString == NULL||[checkString isKindOfClass:[NSNull class]]||[checkString isEqualToString:@"null"]||[checkString isEqualToString:@"(null)"]||checkString == nil||[checkString isEqualToString:@"<null>"]||[checkString isEqualToString:@""]||([checkString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0)) {
        return YES;
    }else {
        return NO;
    }
    
}

+(NSString *)time_YMD_TransformWithTimestamp:(NSInteger)timestamp{
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    //[dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    //NSString *hour = [currentDateStr substringWithRange:NSMakeRange(11, 2)];
    //return hour.intValue;
    return currentDateStr;
}
+(NSString *)time_YMDHMS_TransformWithTimestamp:(NSInteger)timestamp{
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    //NSString *hour = [currentDateStr substringWithRange:NSMakeRange(11, 2)];
    //return hour.intValue;
    return currentDateStr;
}
+(NSString *)dateStringAfterlocalDateForYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day Hour:(NSInteger)hour Minute:(NSInteger)minute Second:(NSInteger)second
{
  NSDate *localDate = [NSDate date]; // 为伦敦时间
  // 在当前日期时间加上 时间：格里高利历
  NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  NSDateComponents *offsetComponent = [[NSDateComponents alloc]init];

   [offsetComponent setYear:year ];  // 设置开始时间为当前时间的前x年
   [offsetComponent setMonth:month];
   [offsetComponent setDay:day];
   [offsetComponent setHour:(hour)]; // 中国时区为正八区，未处理为本地，所以+8
   [offsetComponent setMinute:minute];
   [offsetComponent setSecond:second];
  // 当前时间后若干时间
   NSDate *minDate = [gregorian dateByAddingComponents:offsetComponent toDate:localDate options:0];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //fmt.dateFormat = @"yyyy-MM-dd";
    fmt.dateFormat = @"yyyy/MM/dd";
    //fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *selfStr = [fmt stringFromDate:minDate];
    return selfStr;

//   NSString *dateString = [NSString stringWithFormat:@"%@",minDate];
//
//   return dateString;
}
+(NSString *)dateStringAfterlocalDateDay:(NSInteger)day  withSeverTimestamp:(NSInteger)timestamp{
    
    NSString*currentTime=[self time_YMD_TransformWithTimestamp:timestamp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //需要设置为和字符串相同的格式
   
    [dateFormatter setDateFormat: @"yyyy/MM/dd"];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *tempDate = [dateFormatter dateFromString:currentTime];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: tempDate];
    NSDate *localeDate = [tempDate  dateByAddingTimeInterval: interval];
   
    // 为伦敦时间
  // 在当前日期时间加上 时间：格里高利历
  NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  NSDateComponents *offsetComponent = [[NSDateComponents alloc]init];

   //[offsetComponent setYear:year ];  // 设置开始时间为当前时间的前x年
   //[offsetComponent setMonth:month];
   [offsetComponent setDay:day];
  // [offsetComponent setHour:(hour)]; // 中国时区为正八区，未处理为本地，所以+8
   //[offsetComponent setMinute:minute];
   //[offsetComponent setSecond:second];
  // 当前时间后若干时间
   NSDate *minDate = [gregorian dateByAddingComponents:offsetComponent toDate:localeDate options:0];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //fmt.dateFormat = @"yyyy-MM-dd";
    //[dateFormatter setDateFormat: @"dd/MM/yyyy"];
    fmt.dateFormat = @"yyyy/MM/dd";
    //fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *selfStr = [fmt stringFromDate:minDate];
    return selfStr;

//   NSString *dateString = [NSString stringWithFormat:@"%@",minDate];
//
//   return dateString;
}


+(NSString*)time_MDYTransformWithString:(NSString*)time{
    //(2021/11/17)
    if (time.length==10) {
        NSString *y = [time substringWithRange:NSMakeRange(0,4)];
        NSString *m = [time substringWithRange:NSMakeRange(5,2)];
        NSString *d = [time substringWithRange:NSMakeRange(8,2)];
        return [NSString stringWithFormat:@"%@/%@/%@",m,d,y];
        
    }
    return time;
}
+(NSString *)getNowTimeTimestamp{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    //设置时区,这个对于时间的处理有时很重要

    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];

    [formatter setTimeZone:timeZone];

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式

    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];

    return timeSp;

}
+(NSString*)getCurrentTimes{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    //[formatter setDateFormat:@"YYYY:MM:dd HH:mm:ss"];
    [formatter setDateFormat:@"YYYY:MM:dd"];
    //现在时间,你可以输出来看下是什么格式

    NSDate *datenow = [NSDate date];

    //----------将nsdate按formatter格式转成nsstring

    NSString *currentTimeString = [formatter stringFromDate:datenow];

    NSLog(@"currentTimeString =  %@",currentTimeString);

    return currentTimeString;

}

@end
