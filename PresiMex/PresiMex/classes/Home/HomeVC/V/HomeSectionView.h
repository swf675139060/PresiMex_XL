//
//  HomeSectionView.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/30.
//

#import "WFBaseView.h"
#import "PMHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeSectionView : WFBaseView

-(void)upDataWithModel:(PMHomeProductModel *)Model select:(BOOL)select;

@end

NS_ASSUME_NONNULL_END
