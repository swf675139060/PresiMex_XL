//
//  CuponVC.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/27.
//

#import "WFBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CuponVC : WFBaseViewController

@property(nonatomic, copy)void(^slectCuponBlock)(NSString * ratedID,NSString * ratedStr);

@end

NS_ASSUME_NONNULL_END
