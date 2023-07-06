//
//  PMVeriCodeView.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/27.
//

#import "WFBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PMVeriCodeView : WFBaseView

@property (nonatomic , copy) void(^codeTag)(NSString *code);

- (void)updateTime:(NSInteger)time;
@end

NS_ASSUME_NONNULL_END
