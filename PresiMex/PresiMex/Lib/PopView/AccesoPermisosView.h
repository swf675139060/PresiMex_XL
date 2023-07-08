//
//  AccesoPermisosView.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/7/8.
//  同意权限

#import "WFBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccesoPermisosView : WFBaseView
@property(strong, nonatomic)NSArray * titles;

@property(copy, nonatomic)void(^selectBlock)(void);
@end

NS_ASSUME_NONNULL_END
