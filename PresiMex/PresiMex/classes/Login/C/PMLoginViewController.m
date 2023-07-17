//
//  PMLoginViewController.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/27.
//

#import "PMLoginViewController.h"
#import "PMLoginHeaderView.h"
#import "PMPhoneNumberView.h"
#import "PMProblemViewController.h"
#import "PMVeriCodeViewController.h"
@interface PMLoginViewController ()

@property (nonatomic,strong) UIScrollView *scrollViewView;
@property (nonatomic,strong) PMPhoneNumberView*phoneView;
@property (nonatomic ,strong) NSTimer *timeTimer;
@property (nonatomic ,assign) int index;

@property (nonatomic ,strong) UIButton* submitBtn;


@property (nonatomic ,assign) BOOL isSend;

@property (nonatomic ,strong) PMVeriCodeViewController *CodeViewController;
@end

@implementation PMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.CodeViewController  =[PMVeriCodeViewController new];
    WF_WEAKSELF(weakself);
    [self.CodeViewController setClickResend:^{
        weakself.index = 60;
        [weakself startTime];
    }];
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
    
   
    self.phoneView=[[PMPhoneNumberView alloc]initWithFrame:CGRectMake(15, WF_NavigationHeight+10+76+25, WF_ScreenWidth-30, 300)];
    WF_WEAKSELF(weakself);
    [self.phoneView setTextChangeBlock:^(NSString * _Nonnull text) {
        [weakself upsubmitBtn:text.length];
    }];
    [_scrollViewView addSubview:self.phoneView];
    
    
    
    UIButton* submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.tag=1;
    submitBtn.frame = CGRectMake(15,self.phoneView.swf_bottom + 35,WF_ScreenWidth-30,50);
    [submitBtn setTitle:@"Próximo paso" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(clickSubmitBtn) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.layer.cornerRadius=13;
    submitBtn.layer.masksToBounds=YES;
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_scrollViewView addSubview:submitBtn];
  
    [submitBtn setBackgroundColor:BColor_Hex(@"#CCCCCC", 1)];
    self.submitBtn = submitBtn;
    
}
- (void)upsubmitBtn:(NSInteger)time{

    if (time<10) {
        
        [self.submitBtn setBackgroundColor:BColor_Hex(@"#CCCCCC", 1)];
        [self.submitBtn deletaLinearGradient];
    }else{
        [self.submitBtn addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth - 30, 50) withColors:@[(id)[UIColor jk_colorWithHexString:@"#FFB602"].CGColor,(id)[UIColor jk_colorWithHexString:@"#FC7500"].CGColor] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:13];
    }
}

-(void)clickSubmitBtn{
    
    if (self.phoneView.phoneTextField.text.length >= 10) {
        self.CodeViewController.phone=self.phoneView.phoneTextField.text;
        [self.navigationController pushViewController:self.CodeViewController animated:YES];
        
        if (self.isSend == NO) {
            self.isSend = YES;
            self.index = 60;
            [self.CodeViewController updateTime:self.index];
            [self startTime];
        }
       
    }
    
    
}


-(void)startTime{
    
    
    [_timeTimer invalidate];
    _timeTimer = nil;
    _timeTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timeTimer forMode:NSDefaultRunLoopMode];
    [_timeTimer fire];
}

- (void)updateTime:(NSTimer *)time
{
    
    
    self.index--;
    if (self.index>0) {
        [self.CodeViewController updateTime:self.index];
    }else{
        [self.timeTimer invalidate];
        self.timeTimer = nil;
        [self.CodeViewController updateTime:0];
    }
    
}

-(void)resendVioceCode{
    self.index = 60;
    _timeTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timeTimer forMode:NSDefaultRunLoopMode];
    [_timeTimer fire];
    
//    if (self.click) {
//        self.click();
//    }
}
@end
