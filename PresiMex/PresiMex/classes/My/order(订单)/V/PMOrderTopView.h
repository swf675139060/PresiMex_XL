//
//  PMOrderTopView.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/28.
//

#import "WFBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PMOrderTopView : WFBaseView

@property(strong, nonatomic) void(^clickLeftBtnBlock)(void);

@property(strong, nonatomic) void(^clickRightBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
