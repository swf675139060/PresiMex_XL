//
//  AuthWaitingAlert.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/22.
//

#import "WFBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AuthWaitingAlert : WFBaseView

- (instancetype)initWithFrame:(CGRect)frame withConttent:(NSString *)Conttent;

-(void)uptime:(NSInteger)time;
@end

NS_ASSUME_NONNULL_END
