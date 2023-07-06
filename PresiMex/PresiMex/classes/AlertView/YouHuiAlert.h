//
//  YouHuiAlert.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/7/1.
//

#import "WFBaseView.h"
#import "CuponModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YouHuiAlert : WFBaseView

- (instancetype)initWithFrame:(CGRect)frame withArr:(NSArray *)Arr;

@property (copy, nonatomic)void(^clickBtnBlock)(NSInteger indx);
@end

NS_ASSUME_NONNULL_END
