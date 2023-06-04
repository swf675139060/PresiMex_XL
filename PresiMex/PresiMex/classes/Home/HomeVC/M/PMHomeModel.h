//
//  PMHomeModel.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/4.
//

#import <Foundation/Foundation.h>

@class PMHomeStarsmerChantModel;
NS_ASSUME_NONNULL_BEGIN

@interface PMHomeModel : NSObject

@property(strong, nonatomic) NSString * barbie;//借款金额(展示)
@property(strong, nonatomic) NSString * building;//可借金额
@property(strong, nonatomic) NSArray * pledge;//产品列表
@property(strong, nonatomic) PMHomeStarsmerChantModel * starsmerchant;//产品订单汇总数据

@end


@interface PMHomeProductModel : NSObject

@property(strong, nonatomic) NSString * demanding;//    产品标识
@property(strong, nonatomic) NSString * nu;//产品名称

@property(strong, nonatomic) NSString * drawings;//利息
@property(strong, nonatomic) NSString * mouth;//利息，用于展示

@property(strong, nonatomic) NSString * employers;//服务费
@property(strong, nonatomic) NSString * trademark;//服务费，用于展示

@property(strong, nonatomic) NSString * engage;//产品图标
@property(strong, nonatomic) NSString * flip;//产品额度
@property(strong, nonatomic) NSString * readers;//产品额度，用于展示

@property(strong, nonatomic) NSString * md;//iva费用(税)
@property(strong, nonatomic) NSString * see;//iva费用(税)，用于展示

@property(strong, nonatomic) NSString * pgp;//到期应还金额
@property(strong, nonatomic) NSString * tt;//到期应还金额，用于展示

@property(strong, nonatomic) NSString * Short;//short。还款时间

@property(strong, nonatomic) NSString * warranties;//    到账金额
@property(strong, nonatomic) NSString * unexpected;//到账金额，用于展示

@end

@interface PMHomeStarsmerChantModel : NSObject

@property(strong, nonatomic) NSString * adam;//到账金额
@property(strong, nonatomic) NSString * apparatus;//订单数量
@property(strong, nonatomic) NSString * caused;//借款期限(天)
@property(strong, nonatomic) NSString * comparing;//服务费
@property(strong, nonatomic) NSString * equality;//到期应还金额
@property(strong, nonatomic) NSString * military;//iva费用(税)
@property(strong, nonatomic) NSString * Short;//还款时间
@property(strong, nonatomic) NSString * years;//可借金额
@property(strong, nonatomic) NSString * cow;//可借金额(展示)

@end



NS_ASSUME_NONNULL_END
