//
//  WFStarCell.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/23.
//

#import <UIKit/UIKit.h>
#import "XHStarRateView.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFStarCell : UITableViewCell

@property (strong, nonatomic)XHStarRateView * starV;
@property(strong, nonatomic) UIView * bottomLine;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property(copy, nonatomic)void(^clickStoreBlock)(NSInteger storeCount);


@end

NS_ASSUME_NONNULL_END
