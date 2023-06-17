//
//  PayModel.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/11.
//

#import "PayModel.h"

@implementation PayModel

@end


//VA支付方式
@implementation specialsModel
-(void)setBatch:(NSString *)batch{
    _batch = batch;
   self.batchImage = [NSString generateBarcodeFromString:batch withColor:[UIColor redColor] andSize:CGSizeMake(300, 75)];
}

@end

//银行支付方式
@implementation fieldsModel
-(void)setBatch:(NSString *)batch{
    _batch = batch;
   self.batchImage = [NSString generateBarcodeFromString:batch withColor:[UIColor redColor] andSize:CGSizeMake(300, 75)];
}
@end

//OXXO支付方式
@implementation whoreModel
-(void)setBatch:(NSString *)batch{
    _batch = batch;
   self.batchImage = [NSString generateBarcodeFromString:batch withColor:[UIColor redColor] andSize:CGSizeMake(300, 75)];
}

@end

//Store支付方式
@implementation yoModel
-(void)setBatch:(NSString *)batch{
    _batch = batch;
   self.batchImage = [NSString generateBarcodeFromString:batch withColor:[UIColor redColor] andSize:CGSizeMake(300, 75)];
}

@end
