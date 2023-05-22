//
//  WFBtnCell.h
//  HuLuJianYi
//  Created by shenWenFeng on 2019/1/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFBtnCell : UITableViewCell


@property (strong, nonatomic)UIButton * btn;

+(instancetype)cellWithTableView:(UITableView *)tableView;

-(void)updateFrameWithEdgeInsets:(UIEdgeInsets )padding;


@end

NS_ASSUME_NONNULL_END
