//
//  UIButton+WFTextSizeColor.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (WFTextSizeColor)
-(void)setText:(NSString *)text TextColor:(UIColor *)textColor Font:(UIFont *)font forState:(UIControlState)stat;
@end

NS_ASSUME_NONNULL_END
