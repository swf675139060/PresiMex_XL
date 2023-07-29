//
//  PMDotManager.h
//  PresiMex
//
//  Created by shenwenfeng on 2023/7/22.
//

#import <Foundation/Foundation.h>
#import "PMDeviceModel.h"
#import "PMACQModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PMDotManager : NSObject

+ (PMDotManager *)sharedInstance;

// 10 -30
-(void)POSTDotDevType:(NSInteger)type value:(PMDeviceModel *)valueDic;
// 40
-(void)POSTDotACQ40Withvalue:(PMACQInfoModel *)InfoModel;
// 50
-(void)POSTDotACQ50Withvalue:(PMACQInfoModel *)InfoModel;
// 60
-(void)POSTDotACQ60Withvalue:(PMACQInfoModel *)InfoModel;

/// 上传异常
/// - Parameter valueDic: 异常数据
-(void)POSTDotCrashDic:(NSDictionary *)valueDic;


@end

NS_ASSUME_NONNULL_END
