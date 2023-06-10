//
//  WFImageCell.h
//  RVIHome
//
//  Created by shenWenFeng on 2023/4/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFImageCell : UITableViewCell

@property (strong, nonatomic)UIImageView * imgV;
@property(strong, nonatomic) UIView * bottomLine;

+(instancetype)cellWithTableView:(UITableView *)tableView;

-(void)updateFrameWithEdgeInsets:(UIEdgeInsets )padding height:(CGFloat)height;
@end

NS_ASSUME_NONNULL_END
