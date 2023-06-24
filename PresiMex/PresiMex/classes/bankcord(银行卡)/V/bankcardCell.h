//
//  bankcardCell.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/17.
//

#import <UIKit/UIKit.h>
#import "bankcardModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface bankcardCell : UITableViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView;

// 创建弹出框银行卡cell
+(instancetype)alertCellWithTableView:(UITableView *)tableView;

-(void)updataWithModel:(bankcardModel *)model indx:(NSInteger)indx;
@end

NS_ASSUME_NONNULL_END
