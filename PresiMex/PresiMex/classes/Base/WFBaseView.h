//
//  WFBaseView.h
//  HLUIKit
//
//  Created by panxin on 2019/9/19.
//  Copyright © 2019 panxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFBaseView : UIView



- (void)buildSubViews;


- (void)setSubViewsPosition;

@property (nonatomic , copy) void(^click)(void);
@property (nonatomic , copy) void(^clickTag)(NSInteger tag);
//-(void)showTip:(NSString*)text;
//-(void)show;
//-(void)dismiss;
@end

NS_ASSUME_NONNULL_END
