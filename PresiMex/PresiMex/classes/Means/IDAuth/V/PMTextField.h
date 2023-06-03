//
//  PMTextField.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/6/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PMTextField : UITextField

@property (nonatomic, copy) void(^endEditingHandler) (NSString *text); /**< 输入框结束编辑回调*/

@end

NS_ASSUME_NONNULL_END