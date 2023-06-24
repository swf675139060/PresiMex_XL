//
//  OrderModel.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderModel : NSObject

@property(strong, nonatomic) NSString * products;//借款单号订单号
@property(strong, nonatomic) NSString * prairie;//还款订单ID
@property(strong, nonatomic) NSString * lexus;//订单状态 0-待审核 10-审核中 20-审核通过  30-审核失败 40-放款中 50-待还款 60-放款失败 70-已还款 80-展期中 90-已逾期 100取消贷款
@property(strong, nonatomic) NSString * downloading;//    还款计划状态
@property(strong, nonatomic) NSString * owns;//结清状态
@property(strong, nonatomic) NSString * demanding;//产品Code
@property(strong, nonatomic) NSString * nu;//产品名称
@property(strong, nonatomic) NSString * engage;//产品Icon
@property(strong, nonatomic) NSString * building;//合同金额
@property(strong, nonatomic) NSString * barbie;//合同金额，带千分位符，用于展示
@property(strong, nonatomic) NSString * cook;//到期时间
@property(strong, nonatomic) NSString * impacts;//Borrow修改时间
@property(strong, nonatomic) NSString * resorts;//还款时间
@property(strong, nonatomic) NSString * become;//状态名称
@property(strong, nonatomic) NSString * workstation;//状态描述
@property(strong, nonatomic) NSString * warranties;//实际到账金额
@property(strong, nonatomic) NSString * unexpected;//实际到账金额，带千分位符，用于展示



//barbie = "1,000";
//become = Extendido;
//building = 1000;
//cook = "06/06/2023";
//demanding = f2d32a27e989096292ffa56d2b8bcd89;
//downloading = 30;
//engage = "https://picture.cashimex.mx/mc.png";
//impacts = "2023-05-30 00:10:32";
//lexus = 80;
//nu = "Mexa Cash";
//prairie = 523;
//products = 1119;
//resorts = "30/05/2023";
//unexpected = 650;
//warranties = 650;
//workstation = "Tiempo pagado 30/05/2023";
@end

NS_ASSUME_NONNULL_END
