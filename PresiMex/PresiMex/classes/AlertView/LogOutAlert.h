//
//  LogOutAlert.h
//  PresiMex
//
//  Created by shenwenfeng on 2023/7/31.
//

#import "WFBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LogOutAlert : WFBaseView

- (instancetype)initWithFrame:(CGRect)frame withType:(NSInteger)type;

@property (copy, nonatomic)void(^clickBtnBlock)(NSInteger indx);
@end

NS_ASSUME_NONNULL_END
