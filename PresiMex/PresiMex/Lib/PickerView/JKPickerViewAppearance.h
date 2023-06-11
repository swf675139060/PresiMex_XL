//
//  JKPickerViewAppearance.h
//  OPESO
//
//  Created by 撒旦二哈 on 2021/10/22.
//

#import <UIKit/UIKit.h>
#import "JKPickerView.h"
NS_ASSUME_NONNULL_BEGIN

@interface JKPickerViewAppearance : UIView

- (instancetype)initWithPickerViewTilte:(NSString*)tilte withData:(NSArray*)data pickerCompleteBlock:(void (^)(id responseObjct,NSInteger indx))completeBlock;

@property (nonatomic , copy) void(^click)(NSInteger tag);

- (void)show;
@end

NS_ASSUME_NONNULL_END
