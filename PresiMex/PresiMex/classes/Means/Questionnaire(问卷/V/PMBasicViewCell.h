//
//  PMBasicViewCell.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/30.
//

#import "WFBaseViewCell.h"
#import "PMQuestionModel.h"

NS_ASSUME_NONNULL_BEGIN




@interface PMBasicViewCell : WFBaseViewCell



-(void)setCellWithModel:(PMQuestionModel*)model maxCount:(NSInteger)maxCount;




@property (nonatomic, copy) void(^endInputBlock) (NSString *title, NSString *text);

@end

NS_ASSUME_NONNULL_END
