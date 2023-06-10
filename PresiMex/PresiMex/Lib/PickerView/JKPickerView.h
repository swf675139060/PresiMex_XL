//
//  JKPickerView.h
//  OPESO
//
//  Created by 撒旦二哈 on 2021/10/22.
//

#import <UIKit/UIKit.h>
#import "PMPickerModel.h"
NS_ASSUME_NONNULL_BEGIN

@class JKPickerView;

@protocol JKPickerViewDelegate <NSObject>

@optional

- (void)datePicker:(JKPickerView *)datePicker didSelectedDate:(PMPickerModel *)model;

@end


@interface JKPickerView : UIPickerView<UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) id<JKPickerViewDelegate> dvDelegate;

/**
 快速构造
@return 返回的实列
 */
-(instancetype)initWithDataPickerWithArr:(NSArray*)data;

@end

NS_ASSUME_NONNULL_END
