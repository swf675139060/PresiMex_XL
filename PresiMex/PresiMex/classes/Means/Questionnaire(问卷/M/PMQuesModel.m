//
//  PMQuesModel.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/6/11.
//

#import "PMQuesModel.h"

@implementation PMQuesModel


+(NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"ID":@[@"pm"],
             @"title":@[@"conclude"],
             @"datas":@"mary"
             };
}


@end
