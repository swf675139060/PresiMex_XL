//
//  WFThreeBtnCell.h
//  RVIHome
//
//  Created by shenWenFeng on 2023/4/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFThreeBtnCell : UITableViewCell

@property(strong, nonatomic) UIView * BGView;

@property(strong, nonatomic) UIButton * leftBtn;

@property(strong, nonatomic) UIButton * centerBtn;

@property(strong, nonatomic) UIButton * rightBtn;


@property (nonatomic, copy)void(^clickBtnBlock)(NSInteger index);

+(instancetype)cellWithTableView:(UITableView *)tableView;


-(void)updataLeftStr:(NSString *)leftStr centerStr:(NSString *)centerStr rightStr:(NSString *)rightStr;

//更新背景的边距
-(void)upBGFrameWithInsets:(UIEdgeInsets )padding  height:(CGFloat)height;

-(void)upBtnsFrameWithInsets:(UIEdgeInsets )padding;

@end

NS_ASSUME_NONNULL_END
