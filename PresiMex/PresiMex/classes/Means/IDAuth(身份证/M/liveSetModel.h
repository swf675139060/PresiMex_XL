//
//  liveSetModel.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/18.
//

#import <Foundation/Foundation.h>
@class JerryModel;

NS_ASSUME_NONNULL_BEGIN

@interface liveSetModel : NSObject

@property(strong, nonatomic)NSString * copies;//活体类型 cloudun   izi   selfie (自拍)
@property(strong, nonatomic)JerryModel * jerry;//活体配置信息

@end


@interface JerryModel : NSObject

@property(strong, nonatomic)NSString * barely;//clound活体信息/AppName
@property(strong, nonatomic)NSString * physicians;//partnerCode
@property(strong, nonatomic)NSString * persian;//partnerKey
@property(strong, nonatomic)NSString * weather;//IZI活体信息


@end

NS_ASSUME_NONNULL_END
