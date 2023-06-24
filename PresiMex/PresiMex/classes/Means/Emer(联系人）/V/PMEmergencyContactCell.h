//
//  PMEmergencyContactCell.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/6/3.
//

#import "WFBaseViewCell.h"
#import "PMEmergencyContactModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PMEmergencyContactCell : WFBaseViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;
-(void)setCellWithModel:(PMEmergencyContactModel*)model;

@property (nonatomic, copy) void(^guanXiClickBlock)(NSInteger type);


@property (nonatomic, copy) void(^tongXunLUClickBlock)(NSInteger type);

@property (nonatomic, copy) void(^inputBlock)(NSString *  content,NSInteger type);

@end

NS_ASSUME_NONNULL_END
