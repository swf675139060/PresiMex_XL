//
//  PMQuestionModel.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/30.
//

#import "PMQuestionModel.h"

@implementation PMQuestionModel
-(instancetype)init{
    self = [super init];
    if (self) {
        self.indx = -1;
        self.REQUIRED = YES;
    }
    return self;
}

@end
