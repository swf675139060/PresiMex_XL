//
//  PMBankSelectViewCell.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/6/4.
//

#import "WFBaseViewCell.h"
#import "bankcardModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PMBankSelectViewCell : WFBaseViewCell

-(void)setCellWithModel:(bankcardModel*)model;

@end

NS_ASSUME_NONNULL_END
