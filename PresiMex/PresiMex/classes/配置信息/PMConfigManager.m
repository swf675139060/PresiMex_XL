//
//  PMConfigManager.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/23.
//

#import "PMConfigManager.h"

@interface PMConfigManager()

@property(strong, nonatomic)PMConfigModel * model;

@end


@implementation PMConfigManager

+ (instancetype)sharedInstance {
    static PMConfigManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PMConfigManager alloc] init];
    });
    return instance;
}

-(void)gotoStore{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=APPID&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];
}

-(void)getConfigModelBlock:(void (^)(PMConfigModel *model)) ConfigModellock{
    if (self.model) {
        if(ConfigModellock){
            ConfigModellock(self.model);
        }
    } else {
        NSMutableDictionary *pars=[NSMutableDictionary dictionary];
        
        WF_WEAKSELF(weakself);
        [PMBaseHttp get:GET_CS_Info parameters:pars success:^(id  _Nonnull responseObject) {
            
            if ([responseObject[@"retail"] intValue]==200) {
                NSDictionary * shame = responseObject[@"shame"];
                
                weakself.model = [PMConfigModel mj_objectWithKeyValues:shame];
                
                if(ConfigModellock){
                    ConfigModellock(weakself.model);
                }
                
            }else{
                
            }
            
        } failure:^(NSError * _Nonnull error) {
            
        }];
        
    }
}


//
@end
