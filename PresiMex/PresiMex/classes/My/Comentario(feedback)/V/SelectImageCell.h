//
//  SelectImageCell.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectImageCell : UITableViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView;


@property(strong, nonatomic) UIView * BGView;

@property(copy, nonatomic)void(^selectImageBlock)(void);
@property(copy, nonatomic)void(^imageDeleteBlock)(NSInteger deleteIndx);

-(void)updataWithImages:(NSArray *)Images;


@end

NS_ASSUME_NONNULL_END
