//
//  WFBaseViewController.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFBaseViewController : UIViewController

@property(strong,nonatomic)UIView *navBarView;
@property(strong,nonatomic)UIButton *backBtn;
@property(strong,nonatomic)UILabel *navTitleLabel;
@property(strong,nonatomic)UIView *tempView;

-(void)setBackBarButtonWithTheme:(NSInteger)type;
-(void)hiddenLeftItem;
-(void)addRightBarButtonWithImag:(NSString*)imgName;
-(void)show;
-(void)dismiss;
-(void)showTip:(NSString*)text;
@end

NS_ASSUME_NONNULL_END
