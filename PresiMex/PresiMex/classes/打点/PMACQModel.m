//
//  PMACQModel.m
//  PresiMex
//
//  Created by shenwenfeng on 2023/7/23.
//

#import "PMACQModel.h"

@implementation PMACQModel

@end

@implementation PMACQInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {

    return @{@"description1":@"description"};

}
//
//-(instancetype)initWithIdName:(NSString *)idName content:(NSString *)content beginTime:(NSString *)beginTime Duration:(NSString *)Duration description:(NSString *)description pageDescription:(NSString *)pageDescription{
//    self.idName = idName;
//    self.content = content;
//    self.beginTime = beginTime;
//    self.Duration = Duration;
//    self.description1 = description;
//    self.pageDescription = pageDescription;
//    return self;
//}


-(instancetype)initWithIdName:(NSString *)idName content:(NSString *)content beginTime:(NSString *)beginTime Duration:(NSInteger )Duration{
    self.idName = idName;
    self.content = content;
    
    if (beginTime) {
        self.beginTime = beginTime;
    } else {
        self.beginTime = [PMACQInfoModel GetTimestampString];
    }
    
    if (Duration >= 0) {
        
        self.Duration = [NSString stringWithFormat:@"%ld",Duration];
    } else {
        NSString * endtime = [PMACQInfoModel GetTimestampString];
        
        NSInteger Durationint =  MAX(0, [endtime integerValue] - [beginTime integerValue]);

        self.Duration = [NSString stringWithFormat:@"%ld",Durationint];
    }
    return self;
}


+(NSString *)GetTimestampString{
    NSDate *now = [NSDate date];
    NSTimeInterval timestamp = [now timeIntervalSince1970];

    // 将时间戳转换为字符串类型时间戳
    NSString *timestampString = [NSString stringWithFormat:@"%ld", (long)timestamp];
    return timestampString;

}

@end

