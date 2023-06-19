//
//  LiveStartModel.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveStartModel : NSObject


@property(strong, nonatomic)NSString * profiles;//活体分数(三方返回)
@property(strong, nonatomic)NSString * cooperation;//活体照片(可查看)
@property(strong, nonatomic)NSString * shaw;//活体照片(提交KYC表单时使用)
@property(strong, nonatomic)NSString * versions;//我方ID(三方返回)

@end

NS_ASSUME_NONNULL_END
