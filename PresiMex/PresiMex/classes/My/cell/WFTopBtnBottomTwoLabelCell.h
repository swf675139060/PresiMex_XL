//
//  WFTopBtnBottomTwoLabelCell.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/10.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface WFTopBtnBottomTwoLabelCell : UITableViewCell
@property(strong, nonatomic) UIView * BGView;

@property (strong, nonatomic)UIButton * btn;
@property(strong, nonatomic) UILabel * label1;
@property(strong, nonatomic) WKWebView * label2;

+(instancetype)cellWithTableView:(UITableView *)tableView;


+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;



-(void)upBGFrameWithInsets:(UIEdgeInsets )padding;

-(void)upBtnFrameWithEdgeInsets:(UIEdgeInsets )padding height:(CGFloat)height;

-(void)upLabelFrameWithInsets:(UIEdgeInsets )padding spacing:(CGFloat)spacing;

@end

NS_ASSUME_NONNULL_END
