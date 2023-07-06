//
//  WFGifImageCell.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/26.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFGifImageCell : UITableViewCell
@property (strong, nonatomic)FLAnimatedImageView * imgV;
@property(strong, nonatomic) UIView * bottomLine;

+(instancetype)cellWithTableView:(UITableView *)tableView;

-(void)updateFrameWithEdgeInsets:(UIEdgeInsets )padding height:(CGFloat)height;
@end

NS_ASSUME_NONNULL_END
