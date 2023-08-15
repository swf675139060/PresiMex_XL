//
//  PMVeriCodeView.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/27.
//

#import "WFBaseView.h"

#import "CRBoxInputView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PMVeriCodeView : WFBaseView

@property (nonatomic , strong) CRBoxInputView *boxInputView;

@property (nonatomic , strong) UILabel *desLabel2;


@property (nonatomic , copy) void(^codeTag)(NSString *code);

- (void)updateTime:(NSInteger)time;

@end

NS_ASSUME_NONNULL_END
