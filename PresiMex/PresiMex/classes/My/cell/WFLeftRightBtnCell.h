//
//  WFLeftRightBtnCell.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// <#Description#>
@interface WFLeftRightBtnCell : UITableViewCell

@property(strong, nonatomic) UIView * BGView;

@property (strong, nonatomic)UIButton * leftBtn;

@property (strong, nonatomic)UIButton * rightBtn;

+(instancetype)cellWithTableView:(UITableView *)tableView;


/// 更新背景编剧
///   - height: 高度大于0，则更新
-(void)upBGFrameWithInsets:(UIEdgeInsets )padding height:(CGFloat)height;


-(void)upBtnsFrameWithEdgeInsets:(UIEdgeInsets )padding;


@end

NS_ASSUME_NONNULL_END
