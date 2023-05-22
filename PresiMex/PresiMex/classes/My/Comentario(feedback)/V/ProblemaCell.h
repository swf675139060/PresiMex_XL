//
//  ProblemaCell.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProblemaCell : UITableViewCell



+(instancetype)cellWithTableView:(UITableView *)tableView;

@property(copy, nonatomic)void(^clickBlock)(NSInteger indx);

-(void)updataWithProblems:(NSArray *)Problems selectIndx:(NSInteger)indx;
@end

NS_ASSUME_NONNULL_END
