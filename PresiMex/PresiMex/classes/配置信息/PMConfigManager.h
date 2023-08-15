//
//  PMConfigManager.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/23.
//

#import <Foundation/Foundation.h>
#import "PMConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PMConfigManager : NSObject

+ (instancetype)sharedInstance;

@property(assign, nonatomic) BOOL showTost;

-(void)gotoStore;

-(void)getConfigModelBlock:(void (^)(PMConfigModel *model)) ConfigModellock;
@end

NS_ASSUME_NONNULL_END
