//
//  LNDetectViewController.h
//  YOLOv5NCNN
//
//  Created by Benjamin Wang on 2022/9/9.
//  Copyright © 2022 TENG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LivenessSuccessResult.h"
#import "LivenessFailResult.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DetectViewControllerDelegate <NSObject>
- (void)detectSuccess:(LivenessSuccessResult*) result;
- (void)detectFailed:(LivenessFailResult*) result;
@end

@interface LNDetectViewController : UIViewController
@property (nonatomic, weak) id<DetectViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString *userID;
@end

NS_ASSUME_NONNULL_END
