//
//  KeFuAlert.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/3.
//

#import "WFBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface KeFuAlert : WFBaseView

// 0 客服 1有问题吗
@property(assign, nonatomic) NSInteger type;

@end

NS_ASSUME_NONNULL_END
