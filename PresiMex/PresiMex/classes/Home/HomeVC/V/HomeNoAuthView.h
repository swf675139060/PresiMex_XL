//
//  HomeNoAuthView.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/10.
//

#import "WFBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeNoAuthView : WFBaseView

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/

@property(copy, nonatomic) void(^clickBock)(void);

@end

NS_ASSUME_NONNULL_END
