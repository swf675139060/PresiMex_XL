//
//  PMBasicViewCell.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/30.
//

#import "WFBaseViewCell.h"
#import "PMQuestionModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^inputBlock)(NSString *  content);
typedef void(^endInputBlock)(NSString * content);

@interface PMBasicViewCell : WFBaseViewCell

-(void)setCellWithModel:(PMQuestionModel*)model;

+(CGFloat)cellWithHight:(PMQuestionModel*)model;

@property (nonatomic, copy)   inputBlock  input;
@property (nonatomic, copy)   endInputBlock  endinput;

@end

NS_ASSUME_NONNULL_END
