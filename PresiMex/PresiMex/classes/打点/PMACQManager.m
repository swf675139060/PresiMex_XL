//
//  PMACQManager.m
//  PresiMex
//
//  Created by shenwenfeng on 2023/7/23.
//

#import "PMACQManager.h"

@implementation PMACQManager


+ (PMACQManager *)sharedInstance {
    
    static PMACQManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        [sharedInstance creatACQModel40];
        [sharedInstance creatACQModel50];
        [sharedInstance creatACQModel60];
    });
    return sharedInstance;
}


-(void)creatACQModel40{
    self.ACQModel40 = [PMACQModel new];
    if ([PMAccountTool isLogin]) {
        self.ACQModel40.user_id = [PMAccountTool account].customer_user_id;
    }
    self.ACQModel40.app_id = @"com.prsi.PresiMex";
    self.ACQModel40.data_type = @"acq";
    self.ACQModel40.upload_type = @"40";
    self.ACQModel40.collect_time = [PMACQManager GetTimestampString];
    self.ACQModel40.value = [NSMutableArray array];
}

-(void)creatACQModel50{
    self.ACQModel50 = [PMACQModel new];
    if ([PMAccountTool isLogin]) {
        self.ACQModel50.user_id = [PMAccountTool account].customer_user_id;
    }
    self.ACQModel50.app_id = @"com.prsi.PresiMex";
    self.ACQModel50.data_type = @"acq";
    self.ACQModel50.upload_type = @"50";
    self.ACQModel50.collect_time = [PMACQManager GetTimestampString];
    self.ACQModel50.value = [NSMutableArray array];
}


-(void)creatACQModel60{
    self.ACQModel60 = [PMACQModel new];
    if ([PMAccountTool isLogin]) {
        self.ACQModel60.user_id = [PMAccountTool account].customer_user_id;
    }
    self.ACQModel60.app_id = @"com.prsi.PresiMex";
    self.ACQModel60.data_type = @"acq";
    self.ACQModel60.upload_type = @"60";
    self.ACQModel60.collect_time = [PMACQManager GetTimestampString];
    self.ACQModel60.value = [NSMutableArray array];
}

+(NSString *)GetTimestampString{
    NSDate *now = [NSDate date];
    NSTimeInterval timestamp = [now timeIntervalSince1970];

    // 将时间戳转换为字符串类型时间戳
    NSString *timestampString = [NSString stringWithFormat:@"%ld", (long)timestamp];
    return timestampString;

}

@end
