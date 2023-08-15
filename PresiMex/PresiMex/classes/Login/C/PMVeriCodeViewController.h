//
//  PMVeriCodeViewController.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/27.
//

#import "WFBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PMVeriCodeViewController : WFBaseViewController
@property (nonatomic ,strong)NSString *phone;

- (void)updateTime:(NSInteger)time;
-(void)requestGetVeriCode:(NSInteger)type;
@property(copy, nonatomic)void(^clickResend)(void);
@end

NS_ASSUME_NONNULL_END
