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
#import "KeFuAlert.h"
#import "topLabelBottmBtnAlert.h"

@interface PMVeriCodeViewController ()

@property (nonatomic,strong) UIScrollView *scrollViewView;
@property (nonatomic,strong) PMVeriCodeView*phoneView;

@property (nonatomic ,assign) NSInteger index;

@property (nonatomic ,assign) int type;

@property (nonatomic,strong) UIButton *btn;


@property (nonatomic ,assign) NSInteger requestCount;
@end

@implementation PMVeriCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)updateTime:(NSInteger)time{
    _index = time;

    
    if (time>0) {
        [self.btn setBackgroundColor:BColor_Hex(@"#CCCCCC", 1)];
        [self.btn setTitle:[NSString stringWithFormat:@"%ldS",time] forState:UIControlStateNormal];
        [_btn deletaLinearGradient];
        self.phoneView.desLabel2.hidden = YES;
    }else{
        [_btn addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth - 30, 50) withColors:@[(id)[UIColor jk_colorWithHexString:@"#FFB602"].CGColor,(id)[UIColor jk_colorWithHexString:@"#FC7500"].CGColor] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:13];
        [self.btn setTitle:@"Resend" forState:UIControlStateNormal];
        
        self.phoneView.desLabel2.hidden = NO;
    }
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
    
   
    self.phoneView=[[PMVeriCodeView alloc]initWithFrame:CGRectMake(15, WF_NavigationHeight+10+76+25, WF_ScreenWidth-30, 325)];
    self.phoneView.phone = self.phone;
    [_scrollViewView addSubview:self.phoneView];
    weakify(self)
    self.phoneView.codeTag = ^(NSString * _Nonnull code) {
        strongify(self)
        [self requestLoginWithCode:code];
    };
    self.phoneView.click = ^{
        strongify(self)
        
        if(self.index == 0){
            
            [self requestGetVeriCode:2];
            
            if(self.clickResend){
                self.clickResend();
            }
        }
        
    };
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(15, self.phoneView.swf_bottom+25, WF_ScreenWidth-30, 50);
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_scrollViewView addSubview:btn];
    [btn addTarget:self action:@selector(clickResendbtn) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"Resend" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 13;
    btn.layer.masksToBounds = YES;
   
    self.btn = btn;
    
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
    
    UIView * btView = [[UIView alloc] initWithFrame:CGRectMake(15,pLabel.swf_bottom+20,WF_ScreenWidth-30,75)];
    
    btView.backgroundColor=BColor_Hex(@"#FC7500", 0.1);
    btView.layer.cornerRadius = 10;
    btView.layer.masksToBounds = YES;
    [_scrollViewView addSubview:btView];
    
    UILabel *btLabel = [[UILabel alloc] init];
    btLabel.frame = CGRectMake(6,11,WF_ScreenWidth-30 - 12,75 -22);
    btLabel.text=@"1. Por favor obtenga el OTP solo con una conexión a internet estable.\n2. Si el código no llega, compruebe primero su buzón de spam.";
    
    btLabel.textColor=BColor_Hex(@"#FFB602", 1);
    btLabel.font=B_FONT_REGULAR(11);
    btLabel.textAlignment = NSTextAlignmentLeft;
    
//    btLabel.backgroundColor=[UIColor redColor];
    btLabel.userInteractionEnabled=YES;
    btLabel.numberOfLines = 0;
    
//    [btLabel sizeToFit];
//    btLabel.jk_height = btLabel.jk_height + 22;
    [btView addSubview:btLabel];
}

-(void)clickResendbtn{
    if(self.index == 0){
        [self requestGetVeriCode:1];
        if(self.clickResend){
            self.clickResend();
        }
    }
    
}
-(void)requestGetVeriCode:(NSInteger)type{
    self.requestCount++;
    if (self.requestCount == 3) {
        [self showOTPAlert:type];
        return;
    }
    
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
    pars[@"schedules"]=self.phone;//手机号
    if (type==2) {//null或者1:短信验证码2:语音验证码
        pars[@"monroe"]=@"2";
    } else {
        pars[@"monroe"]=@"1";
    }
    WF_WEAKSELF(weakself);
    [PMBaseHttp post:Post_Sms_Code parameters:pars success:^(id  _Nonnull responseObject) {
        [weakself dismiss];
        if ([responseObject[@"retail"] intValue]==200) {
            [weakself showTip:@"El Código de verificación fue enviado con éxito."];
        }else{
            [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
    } failure:^(NSError * _Nonnull error) {
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        [weakself dismiss];
        
        
    }];
}

//
-(void)showOTPAlert:(NSInteger)type{
    topLabelBottmBtnAlert * alert = [[topLabelBottmBtnAlert alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth - 60,220) withConttent:@"1. Por favor obtenga el OTP solo con una conexión a internet estable. \n2. Si el código no llega, compruebe primero su buzón de spam." btnTitel:@"OK"] ;
    [alert setOPTtype];
    WFCustomAlertView *  AlertView = [[WFCustomAlertView alloc] initWithContentView:alert];
    
    [AlertView show];
    WF_WEAKSELF(weakself);
    [alert setClickBtnBlock:^{
        [weakself requestGetVeriCode:type];
        
        [AlertView dismiss];
    }];
}

-(void)clickProduct{
    
    KeFuAlert * alert = [[KeFuAlert alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth - 60, 217)] ;
    alert.type = 1;
    WFCustomAlertView *  AlertView = [[WFCustomAlertView alloc] initWithContentView:alert];
    
    [AlertView setClickBGDismiss:YES];
    [AlertView show];
//    PMProblemViewController* vc = [[PMProblemViewController alloc]init];
//    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    [self.navigationController  presentViewController:vc animated:NO completion:nil];
}
//验证码登录

-(void)requestLoginWithCode:(NSString*)code{

    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
    pars[@"schedules"]=self.phone;//手机号
    pars[@"myanmar"]=code;//验证码
    pars[@"witch"]=@"fireBase";
    pars[@"registerClientType"]=@"2";
    pars[@"lp"]=@1;
    WF_WEAKSELF(weakself);
    [PMBaseHttp postJson:Post_Sms_Code_Ver parameters:pars success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"retail"] intValue]==200) {
            NSMutableDictionary*dict=[NSMutableDictionary dictionaryWithDictionary:responseObject[@"shame"]];
            dict[@"phone"]=self.phone;
            PMUser *user =[PMUser accountWithDict:dict];
            [PMAccountTool saveAccount:user];
            [self.navigationController popToRootViewControllerAnimated:YES];
            NSLog(@"user==%@",[PMAccountTool account].token);
            
            
            //登录成功首页
            PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_login_succ content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
             [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
            
            
            [[AppsFlyerLib shared]  logEvent: @"af_complete_registration" withValues:nil];
            
            
//            //登陆Dev
//            PMDeviceModel * model =[PMDeviceModel sharedInstance];
//            
//            PMLocationManager * LocationManager  = [PMLocationManager sharedInstance];
//            __weak typeof(model) weakModel = model;
//            [LocationManager creatLocation:^(BOOL isLocation) {
//                [weakModel GetDate];
//                [[PMDotManager sharedInstance] POSTDotDevType:30 value:weakModel];
//            }];
            
            // 定义通知的名称
            NSString *notificationName = @"dengLuChengGong";
            // 创建通知对象
            NSNotification *notification = [NSNotification notificationWithName:notificationName object:nil];
            // 发送通知广播
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
        } else{
            [weakself dismiss];
            [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
    } failure:^(NSError * _Nonnull error) {
        [weakself dismiss];
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        
    }];
    
    //验证码输入
    PMACQInfoModel * phoneInfoModel = [[PMACQInfoModel alloc] initWithIdName:acq02_login_otp_code content:code beginTime:self.phoneView.beginTime Duration:self.phoneView.duration];
    [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: phoneInfoModel];
    


}




@end
