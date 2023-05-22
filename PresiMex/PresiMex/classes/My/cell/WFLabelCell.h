//
//  WFLabelCell.h
//  RVIHome
//
//  Created by shenWenFeng on 2023/4/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFLabelCell : UITableViewCell

@property(strong, nonatomic) UIView * BGView;
@property(strong, nonatomic) UILabel * label;

+(instancetype)cellWithTableView:(UITableView *)tableView;


-(void)upBGFrameWithInsets:(UIEdgeInsets )padding;

-(void)upLabelFrameWithInsets:(UIEdgeInsets )padding;

-(void)setLabelText:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
