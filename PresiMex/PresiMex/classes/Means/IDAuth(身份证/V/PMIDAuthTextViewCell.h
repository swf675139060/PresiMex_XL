//
//  PMIDAuthTextViewCell.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/6/3.
//

#import "WFBaseViewCell.h"
#import "PMIDAuthModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PMIDAuthTextViewCell : WFBaseViewCell


-(void)setCellWithModel:(PMIDAuthModel*)model;
@property (nonatomic, copy) void(^endEditingHandler) (NSString *title, NSString *text);
@end

NS_ASSUME_NONNULL_END
