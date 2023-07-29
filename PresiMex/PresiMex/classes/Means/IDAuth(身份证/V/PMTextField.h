//
//  PMTextField.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/6/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PMTextField : UITextField

@property (nonatomic ,strong)NSString *beginTime;
@property (nonatomic ,assign)NSInteger duration;

@property (nonatomic, assign) NSInteger  maxCount; 

@property (nonatomic, copy) void(^endEditingHandler) (NSString *text); /**< 输入框结束编辑回调*/


@property (nonatomic, copy) void(^changeHandler) (NSString *text); /***/

@end

NS_ASSUME_NONNULL_END
