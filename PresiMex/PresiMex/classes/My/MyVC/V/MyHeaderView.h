//
//  MyHeaderView.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/20.
//

#import "WFBaseView.h"
#import "PMAuthModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyHeaderView : WFBaseView

@property(copy, nonatomic) void (^clickLeftBtnBlock)(void);

@property(copy, nonatomic) void (^clickRightBtnBlock)(void);


@property(copy, nonatomic) void (^clickLoginBlock)(void);
///更新数据
-(void)updataHeaderViewWithModel:(PMAuthModel *)model;


@end

NS_ASSUME_NONNULL_END
