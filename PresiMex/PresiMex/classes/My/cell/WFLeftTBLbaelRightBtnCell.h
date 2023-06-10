//
//  WFLeftTBLbaelRightBtnCell.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFLeftTBLbaelRightBtnCell : UITableViewCell

@property(strong, nonatomic) UIView * BGView;

@property(strong, nonatomic) UIButton * btn;

@property(strong, nonatomic) UILabel * topLabel;

@property(strong, nonatomic) UILabel * bottomLabel;

@property(strong, nonatomic) UIView * bottomLine;



+(instancetype)cellWithTableView:(UITableView *)tableView;


//更新背景的边距
-(void)upBGFrameWithInsets:(UIEdgeInsets )padding;

-(void)upBtnFrameWithInsets:(UIEdgeInsets )padding size:(CGSize)size;

-(void)upLabelsFrameWithInsets:(UIEdgeInsets )padding centerSpac:(CGFloat)spac;

-(void)upLineFrameWithInsets:(UIEdgeInsets )padding;
@end

NS_ASSUME_NONNULL_END
