//
//  PMACQModel.h
//  PresiMex
//
//  Created by shenwenfeng on 2023/7/23.
//

#import <Foundation/Foundation.h>
@class PMACQInfoModel;
NS_ASSUME_NONNULL_BEGIN

@interface PMACQModel : NSObject

@property(strong,nonatomic)NSString *  user_id;//用户id
@property(strong,nonatomic)NSString * app_id;//app产品名
@property(strong,nonatomic)NSString * data_type;//数据类型（见数据类型标识）
@property(strong,nonatomic)NSString * upload_type;//数据上报类型（见数据上报触发场景类型码）
@property(strong,nonatomic)NSString * create_time;//数据入库完成时间
@property(strong,nonatomic)NSString * collect_time;//数据爬取时间
@property(strong,nonatomic)NSMutableArray<PMACQInfoModel *> * value;//acq数据




@end

@interface PMACQInfoModel : NSObject

@property(strong,nonatomic)NSString * idName;//客户端埋点id（页面/输入框/按钮）
@property(strong,nonatomic)NSString * content;//输入框内容（仅输入行为，其他为缺失）
@property(strong,nonatomic)NSString * beginTime;//访问/输入/点击起始时间
@property(strong,nonatomic)NSString * Duration;//访问/输入时长（s）(点击为0)
//@property(strong,nonatomic)NSString * description1;//埋点对应产品描述
//@property(strong,nonatomic)NSString * pageDescription;//埋点所在页面对应产品描述

//-(instancetype)initWithIdName:(NSString *)idName content:(NSString *)content beginTime:(NSString *)beginTime Duration:(NSString *)Duration description:(NSString *)description pageDescription:(NSString *)pageDescription;


-(instancetype)initWithIdName:(NSString *)idName content:(NSString *)content beginTime:(NSString *)beginTime Duration:(NSInteger )Duration;


+(NSString *)GetTimestampString;
@end

NS_ASSUME_NONNULL_END
