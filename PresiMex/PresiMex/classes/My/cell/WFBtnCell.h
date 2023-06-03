//
//  WFBtnCell.h
//  HuLuJianYi
//  Created by shenWenFeng on 2019/1/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFBtnCell : UITableViewCell


@property (strong, nonatomic)UIButton * btn;


@property (copy, nonatomic)void(^clickBtnBlock)(void);


+(instancetype)cellWithTableView:(UITableView *)tableView;

-(void)updateFrameWithEdgeInsets:(UIEdgeInsets )padding height:(CGFloat)height;


@end

NS_ASSUME_NONNULL_END
