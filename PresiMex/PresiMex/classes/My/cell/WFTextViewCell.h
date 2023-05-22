//
//  WFTextViewCell.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/21.
//

#import <UIKit/UIKit.h>
#import "SLFPlaceHolderTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFTextViewCell : UITableViewCell
@property(strong, nonatomic) UIView * BGView;

@property(strong, nonatomic) SLFPlaceHolderTextView * textView;

+(instancetype)cellWithTableView:(UITableView *)tableView;


-(void)upBGFrameWithInsets:(UIEdgeInsets )padding;

-(void)upTextViewFrameWithInsets:(UIEdgeInsets )padding height:(CGFloat)height;

-(void)setTextViewText:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
