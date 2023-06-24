//
//  AuthSuccessfuiAlert.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/22.
//

#import "WFBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AuthSuccessfuiAlert : WFBaseView

- (instancetype)initWithFrame:(CGRect)frame withConttent:(NSString *)Conttent btnTitel:(NSString *)btnTitle;

@property (copy, nonatomic)void(^clickBtnBlock)(void);
@end

NS_ASSUME_NONNULL_END
