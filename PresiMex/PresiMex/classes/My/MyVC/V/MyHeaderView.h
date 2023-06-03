//
//  MyHeaderView.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/20.
//

#import "WFBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyHeaderView : WFBaseView

@property(copy, nonatomic) void (^clickLeftBtnBlock)(void);

@property(copy, nonatomic) void (^clickRightBtnBlock)(void);


@property(copy, nonatomic) void (^clickLoginBlock)(void);
///更新数据
/// - Parameter type: 0: 未登录， 1:登录未授信，2:登录已授信
-(void)updataHeaderViewWithType:(int)type;


@end

NS_ASSUME_NONNULL_END
