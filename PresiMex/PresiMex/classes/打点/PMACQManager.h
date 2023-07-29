//
//  PMACQManager.h
//  PresiMex
//
//  Created by shenwenfeng on 2023/7/23.
//

#import <Foundation/Foundation.h>
#import "PMACQModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PMACQManager : NSObject
+ (PMACQManager *)sharedInstance;
@property(strong,nonatomic)PMACQModel *ACQModel40;
@property(strong,nonatomic)PMACQModel *ACQModel50;
@property(strong,nonatomic)PMACQModel *ACQModel60;

-(void)creatACQModel40;
-(void)creatACQModel50;
-(void)creatACQModel60;

+(NSString *)GetTimestampString;
@end

NS_ASSUME_NONNULL_END
