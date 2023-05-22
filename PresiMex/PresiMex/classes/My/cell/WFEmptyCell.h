//
//  WFEmptyCell.h
//  RVIHome
//
//  Created by shenWenFeng on 2023/4/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFEmptyCell : UITableViewCell

@property(strong, nonatomic) UIView * BGView;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
