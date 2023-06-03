//
//  SLFFailedHub.m
//  PesiMex
//
//  Created by swf on 2023/1/3.
//

#import "SLFFailedHub.h"
#import <JKCategories/JKCategories.h>

@implementation SLFFailedHub

+(SLFFailedHub *)showWithView:(UIView *)view content:(NSString *)content{
    SLFFailedHub * failedHub = [self showHUDAddedTo:view animated:YES];
    failedHub.mode = MBProgressHUDModeCustomView;
    failedHub.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    failedHub.bezelView.backgroundColor = [UIColor blackColor];
    failedHub.bezelView.layer.cornerRadius = 12;
    failedHub.customView = [self customView];
//    failedHub.label.textColor = SLFToastStyle.titleColor;
    failedHub.label.font = [UIFont systemFontOfSize:12];
    failedHub.label.numberOfLines = 0;
    failedHub.label.slf_lineSpace = 3;
    failedHub.label.text = content;
    failedHub.label.textAlignment = NSTextAlignmentCenter;
    failedHub.removeFromSuperViewOnHide = YES;
    return failedHub;
}

+(UIImageView *)customView{
    UIImageView * failedImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 36, 36)];
//    failedImage.image = SLFHubStyle.failedIcon;
    return failedImage;
}

+(SLFFailedHub *)showWithView:(UIView *)view content:(NSString *)content afterDelay:(NSTimeInterval)delay{
    SLFFailedHub * failedHub = [self showWithView:view content:content];
    [failedHub hideAnimated:YES afterDelay:delay];
    return failedHub;
}


+(SLFFailedHub *)showWithContent:(NSString *)content afterDelay:(NSTimeInterval)delay{
    return [self showWithView:[UIApplication sharedApplication].delegate.window content:content afterDelay:delay];
}



@end
