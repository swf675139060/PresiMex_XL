//
//  PayModel.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/11.
//

#import <Foundation/Foundation.h>
@class specialsModel;
@class fieldsModel;
@class whoreModel;
@class yoModel;

NS_ASSUME_NONNULL_BEGIN

@interface PayModel : NSObject

@property(strong, nonatomic) NSString * fraction;//支付类型
@property(strong, nonatomic) NSString * hang;//收款机构
@property(strong, nonatomic) specialsModel * specials;//VA支付方式
@property(strong, nonatomic) fieldsModel * fields;//银行支付方式
@property(strong, nonatomic) whoreModel * whore;//OXXO支付方式
@property(strong, nonatomic) yoModel * yo;//Store支付方式

@end

//VA支付方式
@interface specialsModel : NSObject

@property(strong, nonatomic) NSString * pgp;//还款金额
@property(strong, nonatomic) NSString * tt;//还款金额，用于展示，带千分位符
@property(strong, nonatomic) NSString * batch;//支付码
@property(strong, nonatomic) NSString * properly;//支付指引

@property(strong, nonatomic) UIImage * batchImage;//支付码 图片

@end

//银行支付方式
@interface fieldsModel : NSObject

@property(strong, nonatomic) NSString * pgp;//还款金额
@property(strong, nonatomic) NSString * tt;//还款金额，用于展示，带千分位符
@property(strong, nonatomic) NSString * batch;//支付码
@property(strong, nonatomic) NSString * properly;//支付指引
@property(strong, nonatomic) NSString * hang;//收益人
@property(strong, nonatomic) NSString * framework;//银行
@property(strong, nonatomic) NSString * site;//clabe账号
@property(strong, nonatomic) NSString * troy;//    Concepto de pago
@property(strong, nonatomic) NSString * drops;//订单序列号

@property(strong, nonatomic) UIImage * batchImage;//支付码 图片
@end

//OXXO支付方式
@interface whoreModel : NSObject


@property(strong, nonatomic) NSString * pgp;//还款金额
@property(strong, nonatomic) NSString * tt;//还款金额，用于展示，带千分位符
@property(strong, nonatomic) NSString * batch;//支付码
@property(strong, nonatomic) NSString * properly;//支付指引

@property(strong, nonatomic) UIImage * batchImage;//支付码 图片
@end

//Store支付方式
@interface yoModel : NSObject


@property(strong, nonatomic) NSString * pgp;//还款金额
@property(strong, nonatomic) NSString * tt;//还款金额，用于展示，带千分位符
@property(strong, nonatomic) NSString * batch;//支付码
@property(strong, nonatomic) NSString * properly;//支付指引

@property(strong, nonatomic) UIImage * batchImage;//支付码 图片
@end


NS_ASSUME_NONNULL_END
