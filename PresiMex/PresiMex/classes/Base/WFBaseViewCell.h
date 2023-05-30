//
//  WFBaseViewCell.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFBaseViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic , copy) void(^click)(NSInteger tag);

@end

NS_ASSUME_NONNULL_END
