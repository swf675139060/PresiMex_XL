//
//  PMHomeModel.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/4.
//

#import "PMHomeModel.h"

@implementation PMHomeModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{ @"pledge" : [PMHomeProductModel class]};
}


@end

@implementation PMHomeProductModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"Short":@"short"
             };
}




@end
@implementation PMHomeStarsmerChantModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"Short":@"short"
             };
}




@end
