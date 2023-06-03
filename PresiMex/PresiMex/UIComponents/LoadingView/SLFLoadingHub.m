//
//  SLFLoadingView.m
//  PesiMex
//
//  Created by swf on 2022/12/22.
//

#import "SLFLoadingHub.h"
#import "SLFLoadingView.h"

@implementation SLFLoadingHub

+(SLFLoadingHub *)showWithView:(UIView *)view content:(NSString *)content loadingColor:(UIColor *)color{
    SLFLoadingHub * loadingHub = [self showHUDAddedTo:view animated:YES];
    loadingHub.mode = MBProgressHUDModeCustomView;
    loadingHub.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    loadingHub.bezelView.backgroundColor = [UIColor blackColor];
    loadingHub.bezelView.layer.cornerRadius = 12;
    loadingHub.customView = [self getCustomLoadingWithLoadingColor:color];
    loadingHub.label.text = content;
    loadingHub.label.textColor = [UIColor jk_colorWithHexString:@"FFFFFFE"];
    loadingHub.label.font = [UIFont systemFontOfSize:12];
    loadingHub.removeFromSuperViewOnHide = YES;
    return loadingHub;
}


+(SLFLoadingHub *)showLoadingWithView:(UIView *)view{
    return [self showWithView:view content:@"Loading" loadingColor:[UIColor jk_colorWithHexString:@"FFFFFFF"]];
}

+(SLFLoadingHub *)showLoading{
    return [self showLoadingWithView:[UIApplication sharedApplication].delegate.window];
}

+(SLFLoadingView *)getCustomLoadingWithLoadingColor:(UIColor *)color{
    SLFLoadingView * customLoadingView = [[SLFLoadingView alloc]initWithFrame:CGRectMake(0, 0, 36, 36)];
    customLoadingView.duration = 3;
    customLoadingView.lineW = 4.f;
    customLoadingView.strokeColor = color;
    [customLoadingView createUI];
    [customLoadingView starAnimation];
    return  customLoadingView;
}

-(void)hideAnimated:(BOOL)animated{
    [super hideAnimated:animated];
    SLFLoadingView * customLoadingView = (SLFLoadingView *)self.customView;
    [customLoadingView stopAnimation];
}

@end
