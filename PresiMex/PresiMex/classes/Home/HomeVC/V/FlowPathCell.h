//
//  FlowPathCell.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/10.
//  流程的cell

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlowPathCell : UITableViewCell

@property(strong, nonatomic) UIView * BGView;

@property(strong, nonatomic) UIButton * leftBtn;

@property(strong, nonatomic) UIButton * centerBtn;

@property(strong, nonatomic) UIButton * rightBtn;


@property(strong, nonatomic) UIImageView * centerV1;

@property(strong, nonatomic) UIImageView * centerV2;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
