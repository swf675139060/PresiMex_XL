//
//  PMVeriCodeViewController.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/27.
//

#import "PMVeriCodeViewController.h"
#import "PMLoginHeaderView.h"
#import "PMVeriCodeView.h"
#import "PMProblemViewController.h"

@interface PMVeriCodeViewController ()

@property (nonatomic,strong) UIScrollView *scrollViewView;

@end

@implementation PMVeriCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
    [self requestGetVeriCode:1];
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
    weakify(self)
    phoneView.codeTag = ^(NSString * _Nonnull code) {
        strongify(self)
        [self requestLoginWithCode:code];
    };
    phoneView.click = ^{
        strongify(self)
        [self requestGetVeriCode:2];
    };
    
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
    pLabel.userInteractionEnabled=YES;
    [_scrollViewView addSubview:pLabel];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickProduct)];
    [pLabel addGestureRecognizer:tap];
}
-(void)requestGetVeriCode:(NSInteger)type{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
    pars[@"schedules"]=self.phone;//手机号
    if (type==2) {//null或者1:短信验证码2:语音验证码
        pars[@"monroe"]=@"2";
    } else {
        pars[@"monroe"]=@"1";
    }
    [PMBaseHttp post:Post_Sms_Code parameters:pars success:^(id  _Nonnull responseObject) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

-(void)clickProduct{
    
    PMProblemViewController* vc = [[PMProblemViewController alloc]init];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.navigationController  presentViewController:vc animated:NO completion:nil];
}
//验证码登录
-(void)requestLoginWithCode:(NSString*)code{

    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
    pars[@"schedules"]=self.phone;//手机号
    pars[@"myanmar"]=code;//验证码
    [PMBaseHttp postJson:Post_Sms_Code_Ver parameters:pars success:^(id  _Nonnull responseObject) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
//    [PMBaseHttp post:Post_Sms_Code_Ver parameters:pars success:^(id  _Nonnull responseObject) {
//
//    } failure:^(NSError * _Nonnull error) {
//
//    }];
}
@end
