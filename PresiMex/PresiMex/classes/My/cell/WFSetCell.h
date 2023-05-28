//
//  WFSetCell.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/27.
//  设置类型的cell 左图标+文字，右文字加+更多图标

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFSetCell : UITableViewCell


@property(strong, nonatomic) UIView * BGView;

@property(strong, nonatomic) UILabel * typeLabel;

@property(strong, nonatomic) UILabel * valueLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

-(void)updata:(NSString *)typeIcon type:(NSString *)type  value:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
