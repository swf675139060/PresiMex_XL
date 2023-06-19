//
//  PMCerViewCell.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/6/4.
//

#import "WFBaseViewCell.h"
#import "PMCerModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PMCerViewCell : WFBaseViewCell
-(void)setCellWithModel:(PMCerModel*)model isSelect:(BOOL)select;
@end

NS_ASSUME_NONNULL_END
