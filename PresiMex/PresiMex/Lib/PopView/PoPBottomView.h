//
//  PoPBottomView.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/28.
//

#import "WFBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PoPBottomView : WFBaseView
@property(strong, nonatomic)NSArray * titles;

@property(copy, nonatomic)void(^selectBlock)(NSString *responseObjct, NSInteger indx);
@end

NS_ASSUME_NONNULL_END
