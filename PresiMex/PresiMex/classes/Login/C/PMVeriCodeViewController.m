//
//  PMVeriCodeViewController.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/27.
//

#import "PMVeriCodeViewController.h"
#import "PMLoginHeaderView.h"
#import "PMVeriCodeView.h"
@interface PMVeriCodeViewController ()

@property (nonatomic,strong) UIScrollView *scrollViewView;

@end

@implementation PMVeriCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
}

-(void)setupSubviews{
    
    self.navBarView.hidden=YES;
    self.tempView.hidden=YES;
    _scrollViewView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, WF_ScreenWidth,WF_ScreenHeight)];
    _scrollViewView.showsVerticalScrollIndicator = NO;
    _scrollViewView.contentSize=CGSizeMake(WF_ScreenWidth, WF_ScreenHeight+50);
    [self.view addSubview:_scrollViewView];
    _scrollViewView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    PMLoginHeaderView*bgView = [[PMLoginHeaderView alloc] initWithFrame:CGRectMake(0,0,WF_ScreenWidth, WF_StatusBarHeight+300)];
    [_scrollViewView addSubview:bgView];
    
   
    PMVeriCodeView*phoneView=[[PMVeriCodeView alloc]initWithFrame:CGRectMake(15, WF_NavigationHeight+10+76+25, WF_ScreenWidth-30, 325)];
    [_scrollViewView addSubview:phoneView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(15, phoneView.swf_bottom+25, WF_ScreenWidth-30, 50);
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_scrollViewView addSubview:btn];
    [btn setTitle:@"Resend" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth - 30, 50) withColors:@[(id)[UIColor jk_colorWithHexString:@"#FFB602"].CGColor,(id)[UIColor jk_colorWithHexString:@"#FC7500"].CGColor] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:13];
    
    UILabel *pLabel = [[UILabel alloc] init];
    pLabel.frame = CGRectMake(15,btn.swf_bottom+25,WF_ScreenWidth-30,20);
    pLabel.text=@"¿Algún problema?";
    pLabel.textColor=BColor_Hex(@"#FC7500", 1);
    pLabel.font=B_FONT_REGULAR(12);
    pLabel.textAlignment = NSTextAlignmentRight;
    [_scrollViewView addSubview:pLabel];
    
}

@end
