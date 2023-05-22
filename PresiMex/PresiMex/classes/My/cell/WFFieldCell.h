//
//  HLRVIFieldCell.h
//  HuLuJianYi
//
//  Created by shenWenFeng on 2019/2/25.
//  Copyright © 2019年 yudeyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFFieldCell : UITableViewCell

@property (strong, nonatomic)UITextField * leftField;

@property(nonatomic,copy)void(^leftFieldBlock)(NSString* leftFieldText);

@property(nonatomic,copy)void(^clickReturnBlock)(void);//点击键盘上的return按钮



+(instancetype)cellWithTableView:(UITableView *)tableView;

//输入最长字符设置
-(void)inputMaxLength:(NSInteger)max;

-(void)becomeFirstResponder:(BOOL)firstResponder;

-(void)upBGFrameWithInsets:(UIEdgeInsets )padding;

-(void)upFieldFrameWithInsets:(UIEdgeInsets )padding height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
