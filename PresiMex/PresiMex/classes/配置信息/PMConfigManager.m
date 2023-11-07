//
//  PMConfigManager.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/23.
//

#import "PMConfigManager.h"
#import <StoreKit/StoreKit.h>

@interface PMConfigManager()<SKStoreProductViewControllerDelegate>

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
//    [SKStoreReviewController requestReview];
    NSString *reviewURL = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?action=write-review", @"6471468507"];
       NSURL *url = [NSURL URLWithString:reviewURL];
       [[UIApplication sharedApplication] openURL:url];
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=APPID&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];
}

- (void)openAppStoreForAppWithID:(NSString *)appID {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id6471468507"]];
//    SKStoreProductViewController *storeViewController = [[SKStoreProductViewController alloc] init];
//    storeViewController.delegate = self;
//
//    NSDictionary *parameters = @{ SKStoreProductParameterITunesItemIdentifier : @"67887" };
//    [storeViewController loadProductWithParameters:parameters completionBlock:^(BOOL result, NSError *error) {
//        if (result) {
//
//            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
//            [[keyWindow jk_currentViewController] presentViewController:storeViewController animated:YES completion:nil];
//        } else {
//            NSLog(@"Error loading product details: %@", error);
//        }
//    }];
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:nil];
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
//                [weakself showTip:responseObject[@"entire"]];//（对）
            }
            
        } failure:^(NSError * _Nonnull error) {
//            [weakself dismiss];
//            [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
            
        }];
        
    }
}


//
@end
