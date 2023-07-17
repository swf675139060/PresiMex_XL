//
//  PMPhoneNumberView.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/27.
//

#import "PMPhoneNumberView.h"
#import "PMVeriCodeViewController.h"
#import "PMProblemViewController.h"
#import "KeFuAlert.h"

@interface PMPhoneNumberView ()<UITextFieldDelegate>
@end

@implementation PMPhoneNumberView

-(void)buildSubViews{
   
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.layer.cornerRadius = 15;
    self.layer.shadowColor = BColor_Hex(@"#D9D9D9", 0.5).CGColor;
    self.layer.shadowOffset = CGSizeMake(0,1);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 10;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(15,25,100,25);
    titleLabel.textColor=BColor_Hex(@"#1B1200", 1);
    [self addSubview:titleLabel];
    titleLabel.text=@"Acceso";
    titleLabel.font=B_FONT_BOLD(20);
    titleLabel.textAlignment = NSTextAlignmentLeft;

    UILabel *desLabel = [[UILabel alloc] init];
    desLabel.frame = CGRectMake(15,titleLabel.swf_bottom+20,200,31);
    [self addSubview:desLabel];
    desLabel.text=@"Bienvenido a PresiMex";
    desLabel.font=B_FONT_MEDIUM(18);
    desLabel.textColor=BColor_Hex(@"#FC7500", 1);
    desLabel.textAlignment = NSTextAlignmentLeft;
   
    UILabel *desLabel1 = [[UILabel alloc] init];
    desLabel1.frame = CGRectMake(15,desLabel.swf_bottom+10,WF_ScreenWidth-30,15);
    desLabel1.font=B_FONT_REGULAR(11);
    desLabel1.adjustsFontSizeToFitWidth=YES;
    desLabel1.textColor=BColor_Hex(@"#7C7C7C", 1);
    [self addSubview:desLabel1];
    desLabel1.text=@"Ingrese su número para obtener hasta $30,000  de crédito.";
    desLabel1.textAlignment = NSTextAlignmentLeft;

 
    UIView *phoneView = [[UIView alloc] init];
    phoneView.backgroundColor = [UIColor whiteColor];
    phoneView.frame = CGRectMake(15,desLabel1.swf_bottom+40, WF_ScreenWidth-60, 44);
    [self addSubview:phoneView];
    phoneView.layer.cornerRadius=20;
    phoneView.layer.borderWidth=0.5;
    phoneView.layer.borderColor=BColor_Hex(@"#CCCCCC", 0.5).CGColor;
    
    UILabel *leftLabel= [[UILabel alloc] init];
    leftLabel.textAlignment = NSTextAlignmentLeft;
    leftLabel.font =B_FONT_REGULAR(16);
    leftLabel.textColor=BColor_Hex(@"#1B1200", 1);
    [phoneView addSubview:leftLabel];
    leftLabel.text=@"+52";
    leftLabel.frame=CGRectMake(20,12,35,20);
    
    
    NSString*phone=[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginPhone"];
    _phoneTextField = [[UITextField alloc] init];
    _phoneTextField.backgroundColor = [UIColor whiteColor];
    _phoneTextField.placeholder = @"Ingrese su número de teléfono";
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextField.textColor=BColor_Hex(@"#1B1200", 1);
    _phoneTextField.font =B_FONT_REGULAR(16);
    _phoneTextField.frame = CGRectMake(leftLabel.swf_right+10,7, WF_ScreenWidth-115-20, 30);
    _phoneTextField.textAlignment=NSTextAlignmentLeft;
    _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneTextField.delegate=self;
    [_phoneTextField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    [phoneView addSubview:_phoneTextField];
    if (phone.length!=0) {
        _phoneTextField.text=phone;
    }
   

    UILabel *pLabel = [[UILabel alloc] init];
    pLabel.frame = CGRectMake(15,phoneView.swf_bottom+25,WF_ScreenWidth-60,20);
    pLabel.text=@"¿Algún problema?";
    pLabel.textColor=BColor_Hex(@"#FC7500", 1);
    pLabel.font=B_FONT_REGULAR(12);
    pLabel.textAlignment = NSTextAlignmentRight;
    pLabel.userInteractionEnabled=YES;
    [self addSubview:pLabel];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickProduct)];
    [pLabel addGestureRecognizer:tap];
   

    
}
#pragma mark - UITextField 监听变化

-(void)textFieldTextChange:(UITextField *)textField{
    
    if ([_phoneTextField.text length] >=15) {
       _phoneTextField.text = [_phoneTextField.text substringToIndex:15];
//        [self pushVerVc];
        
    }
    if (self.TextChangeBlock) {
        self.TextChangeBlock(_phoneTextField.text);
    }
    
      
  
}
-(void)pushVerVc{
    if (_phoneTextField.text.length) {
        PMVeriCodeViewController *Vc=[PMVeriCodeViewController new];
        Vc.phone=_phoneTextField.text;
        [self.viewController.navigationController pushViewController:Vc animated:YES];
    }
}
-(void)clickProduct{
    
    KeFuAlert * alert = [[KeFuAlert alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth - 60, 217)] ;
    alert.type = 1;
    WFCustomAlertView *  AlertView = [[WFCustomAlertView alloc] initWithContentView:alert];
    
    [AlertView setClickBGDismiss:YES];
    [AlertView show];
//
//    PMProblemViewController* vc = [[PMProblemViewController alloc]init];
//    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    [self.viewController.navigationController  presentViewController:vc animated:NO completion:nil];
}
@end
