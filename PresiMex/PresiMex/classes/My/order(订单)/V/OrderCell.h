//
//  OrderCell.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (copy, nonatomic) void(^clickUseBlock)(NSInteger indx);

-(void)updataWithModel:(id)model indx:(NSInteger)indx;

@end

NS_ASSUME_NONNULL_END
