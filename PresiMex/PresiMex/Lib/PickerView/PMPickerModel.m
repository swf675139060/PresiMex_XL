//
//  PMPickerModel.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/6/7.
//

#import "PMPickerModel.h"

@implementation PMPickerModel

+(NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"ID":@[@"id",@"broken"],
             @"title":@[@"name",@"title",@"bulgaria"]
             };
}


@end
