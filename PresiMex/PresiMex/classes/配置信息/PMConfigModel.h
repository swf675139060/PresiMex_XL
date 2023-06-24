//
//  PMConfigModel.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/23.
//

#import <Foundation/Foundation.h>
@class KeywordsModel;

NS_ASSUME_NONNULL_BEGIN

@interface PMConfigModel : NSObject

@property(strong, nonatomic) KeywordsModel * keywords;//客服信息

@property(strong, nonatomic) NSString * medline;//gp引导标识   true:引导   false:不引导

@end


@interface KeywordsModel : NSObject

@property(strong, nonatomic) NSString * sustainability;//客服电话

@property(strong, nonatomic) NSString * solid;//WhatsApp客服
@property(strong, nonatomic) NSString * ohio;//Mensajero客服
@property(strong, nonatomic) NSString * pools;//邮箱
@property(strong, nonatomic) NSString * prepared;//服务时间

@end

NS_ASSUME_NONNULL_END
