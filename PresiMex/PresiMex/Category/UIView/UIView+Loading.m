//
//  UIView+Loading.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/10.
//

#import "UIView+Loading.h"
#import "Toast+UIView.h"

@implementation UIView (Loading)

-(void)showTipC:(NSString*)text{
    
    if (text.length==0) {
        return;
    }
   [self makeToast: text duration:1.5 position:@"center"];
}
-(void)show{
    
    [self dismiss];
    // 获取keyWindow
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    // 添加hud
    UIView * hudView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, WF_ScreenHeight)];
    [hudView setBackgroundColor:[UIColor colorWithWhite:0.2 alpha:0.2]];
    
    hudView.tag = 20230610;
    [window addSubview:hudView];
    
    UIView *bg=[UIView new];
    [hudView addSubview:bg];
    bg.frame=CGRectMake((WF_ScreenWidth-80)/2,WF_ScreenHeight/2, 80, 80);
    bg.backgroundColor=[UIColor colorWithWhite:0 alpha:0.8];
    bg.layer.cornerRadius=10;
    bg.layer.masksToBounds=YES;
    
    UIImageView *animationImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"peso_loading_img"]];
    [bg addSubview:animationImageView];
    animationImageView.frame=CGRectMake(20, 10, 40, 40);

    UILabel*load=[UILabel new];
    load.frame=CGRectMake(0, animationImageView.swf_bottom+5, 80, 20);
    load.text=@"loading..";
    load.textColor=[UIColor whiteColor];
    load.font=[UIFont systemFontOfSize:13];
    load.textAlignment=NSTextAlignmentCenter;
    [bg addSubview:load];
    


    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.autoreverses = NO;
    animation.fromValue    = [NSNumber numberWithFloat:0.f];
    animation.toValue      = [NSNumber numberWithFloat: M_PI *2];
    animation.duration     = 0.5; // 每秒10转，闪瞎你的眼
    animation.repeatCount  = MAXFLOAT; // 一直转
    animation.fillMode     = kCAFillModeForwards;
    [animationImageView.layer addAnimation:animation forKey:nil];
    

}


-(void)dismiss{
    // 遍历keyWindow上的CQHudView，一一移除
//    for (UIView * view in [UIApplication sharedApplication].keyWindow.subviews) {
//        if (view.tag  == 2023) {
//            [view removeFromSuperview];
//        }
//    }
    UIView * view = [[UIApplication sharedApplication].keyWindow viewWithTag:20230610];
    [view removeFromSuperview];
    
}

@end
