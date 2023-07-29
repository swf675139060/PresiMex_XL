//
//  PMPhoneNumberView.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/27.
//

#import "WFBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PMPhoneNumberView : WFBaseView

@property (nonatomic ,strong)UITextField *phoneTextField;



@property (nonatomic ,copy)void(^TextChangeBlock)(NSString * text);


@end

NS_ASSUME_NONNULL_END
