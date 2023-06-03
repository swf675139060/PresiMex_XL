//
//  SLFToast.m
//  PesiMex
//
//  Created by swf on 2022/12/22.
//

#import "SLFToast.h"

@implementation SLFToast

+(SLFToast *)showWithView:(UIView *)view content:(NSString *)content{
    SLFToast * toast = [self showHUDAddedTo:view animated:YES];
    toast.mode = MBProgressHUDModeText;
    toast.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    toast.bezelView.backgroundColor = [UIColor blackColor];
    toast.bezelView.layer.cornerRadius = 12;
    toast.label.text = content;
    toast.label.textColor = [UIColor jk_colorWithHexString:@"FFFFFFE"];
    toast.label.numberOfLines = 0;
    toast.label.font = [UIFont systemFontOfSize:12];
    toast.removeFromSuperViewOnHide = YES;
    return toast;
}

+(SLFToast *)showWithView:(UIView *)view content:(NSString *)content afterDelay:(NSTimeInterval)delay{
    SLFToast * toast = [self showWithView:view content:content];
    [toast hideAnimated:YES afterDelay:delay];
    return  toast;
}


+(SLFToast *)showContent:(NSString *)content{
    
    return [self showWithView:[UIApplication sharedApplication].delegate.window content:content];
}

+(SLFToast *)showWithContent:(NSString *)content afterDelay:(NSTimeInterval)delay{
    
    SLFToast * toast = [self showWithView:[UIApplication sharedApplication].delegate.window content:content afterDelay:delay];
    return toast;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
