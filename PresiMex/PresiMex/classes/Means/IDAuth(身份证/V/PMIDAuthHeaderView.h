//
//  PMIDAuthHeaderView.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/30.
//

#import "WFBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PMIDAuthHeaderView : WFBaseView

-(instancetype)initViewWithType:(NSInteger)type;

@property(copy, nonatomic)void(^btnEventBlcok)(void);
@end

NS_ASSUME_NONNULL_END
