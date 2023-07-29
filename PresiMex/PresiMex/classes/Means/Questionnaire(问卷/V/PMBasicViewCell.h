//
//  PMBasicViewCell.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/30.
//

#import "WFBaseViewCell.h"
#import "PMQuestionModel.h"
#import "PMTextField.h"

NS_ASSUME_NONNULL_BEGIN




@interface PMBasicViewCell : WFBaseViewCell



@property (nonatomic, strong) PMTextField *contentTF;
-(void)setCellWithModel:(PMQuestionModel*)model maxCount:(NSInteger)maxCount;




@property (nonatomic, copy) void(^endInputBlock) (NSString *title, NSString *text,BOOL end);


@end

NS_ASSUME_NONNULL_END
