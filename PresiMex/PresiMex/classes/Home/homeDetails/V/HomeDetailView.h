//
//  HomeDetailView.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/23.
//

#import "WFBaseView.h"
#import "bankcardModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeDetailView : WFBaseView


@property (nonatomic, strong) bankcardModel * bankModel;//当前绑定的model

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/

@property(copy, nonatomic)void(^clickBankBlock)(bankcardModel *bankModel);

@property(copy, nonatomic)void(^clickNextBlock)(BOOL success);

@end

NS_ASSUME_NONNULL_END
