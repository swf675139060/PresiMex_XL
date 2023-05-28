//
//  PMLoginViewController.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/27.
//

#import "PMLoginViewController.h"
#import "PMLoginHeaderView.h"
#import "PMPhoneNumberView.h"
@interface PMLoginViewController ()

@property (nonatomic,strong) UIScrollView *scrollViewView;

@end

@implementation PMLoginViewController

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
    
   
    PMPhoneNumberView*phoneView=[[PMPhoneNumberView alloc]initWithFrame:CGRectMake(15, WF_NavigationHeight+10+76+25, WF_ScreenWidth-30, 300)];
    [_scrollViewView addSubview:phoneView];
    
}


@end
