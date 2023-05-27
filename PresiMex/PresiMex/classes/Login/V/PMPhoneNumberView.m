//
//  PMPhoneNumberView.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/27.
//

#import "PMPhoneNumberView.h"

@interface PMPhoneNumberView ()<UITextFieldDelegate>
@property (nonatomic ,strong)UITextField *phoneTextField;
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
    desLabel1.frame = CGRectMake(15,desLabel.swf_bottom,WF_ScreenWidth-30,15);
    desLabel1.font=B_FONT_REGULAR(11);
    desLabel1.adjustsFontSizeToFitWidth=YES;
    desLabel1.textColor=BColor_Hex(@"#7C7C7C", 1);
    [self addSubview:desLabel1];
    desLabel1.text=@"Ingrese su número para obtener hasta $30,000  de crédito.";
    desLabel1.textAlignment = NSTextAlignmentLeft;

 
    UIView *phoneView = [[UIView alloc] init];
    phoneView.backgroundColor = [UIColor whiteColor];
    phoneView.frame = CGRectMake(15,desLabel1.swf_bottom+35, WF_ScreenWidth-30, 44);
    [self addSubview:phoneView];
    phoneView.layer.cornerRadius=20;
    phoneView.layer.borderWidth=0.5;
    phoneView.layer.borderColor=BColor_Hex(@"#CCCCCC", 1).CGColor;
    
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
    _phoneTextField.placeholder = @"9xxxxxxxxx";
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextField.font =B_FONT_REGULAR(16);
    _phoneTextField.frame = CGRectMake(10,5, WF_ScreenWidth-30-20, 30);
    _phoneTextField.textAlignment=NSTextAlignmentLeft;
    _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneTextField.delegate=self;
    [_phoneTextField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    [phoneView addSubview:_phoneTextField];
    if (phone.length!=0) {
        _phoneTextField.text=phone;
    }





    
}
#pragma mark - UITextField 监听变化

-(void)textFieldTextChange:(UITextField *)textField{
    
        if ([_phoneTextField.text hasPrefix:@"0"]&([_phoneTextField.text length] >=11)) {
            _phoneTextField.text = [_phoneTextField.text substringToIndex:11];
            
        }
        if (([_phoneTextField.text hasPrefix:@"9"]|[_phoneTextField.text hasPrefix:@"8"])&([_phoneTextField.text length] >=10)) {
               _phoneTextField.text = [_phoneTextField.text substringToIndex:10];
           
        }
      
       
  
}
@end
