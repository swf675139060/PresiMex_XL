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


@property (nonatomic ,strong)NSString *beginTime;
@property (nonatomic ,assign)NSInteger duration;


- (void)buildSubViews;


- (void)setSubViewsPosition;

@property (nonatomic , copy) void(^click)(void);
@property (nonatomic , copy) void(^clickTag)(NSInteger tag);

-(void)show;
-(void)dismiss;

-(void)showTip:(NSString*)text;
@end

NS_ASSUME_NONNULL_END
