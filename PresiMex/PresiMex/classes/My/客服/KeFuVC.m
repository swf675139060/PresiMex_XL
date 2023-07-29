//
//  KeFuVC.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/24.
//

#import "KeFuVC.h"
#import "KeFuAlert.h"

@interface KeFuVC ()

@end

@implementation KeFuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRightBarButtonWithImag:@"bai_kefu"];
    
    //客服主页
    PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_assistance content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
    [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
}



@end
