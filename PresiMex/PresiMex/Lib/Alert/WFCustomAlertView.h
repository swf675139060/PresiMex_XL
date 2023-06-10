//
//  WFCustomAlertView.h
//
//  Created by swf on 2023/1/7.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    BlockCauseButtonClick = 0,
    BlockSureButtonClick,
    BlockCrossButtonClick
} BlockButtonClickIndex;


NS_ASSUME_NONNULL_BEGIN

@interface WFCustomAlertView : UIView
- (instancetype)initWithContentView:(UIView *)contentView;

- (void)show;

- (void)dismiss;

-(void)setClickBGDismiss:(BOOL)miss;
@end

NS_ASSUME_NONNULL_END
