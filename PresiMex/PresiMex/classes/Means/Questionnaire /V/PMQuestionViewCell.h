//
//  PMQuestionViewCell.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/30.
//

#import "WFBaseViewCell.h"

#import "PMQuestionModel.h"

NS_ASSUME_NONNULL_BEGIN



@interface PMQuestionViewCell : WFBaseViewCell

-(void)setCellWithModel:(PMQuestionModel*)model;

+(CGFloat)cellWithHight:(PMQuestionModel*)model;

@end

NS_ASSUME_NONNULL_END
