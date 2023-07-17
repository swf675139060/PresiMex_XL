//
//  PMVeriCodeView.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/27.
//

#import "PMVeriCodeView.h"

#import "CRBoxInputView.h"

@interface PMVeriCodeView ()
@property (nonatomic ,strong)UILabel *timeLabel;
@end

@implementation PMVeriCodeView

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
    desLabel1.font=B_FONT_REGULAR(11);
    desLabel1.text=@"El código de verificación ha sido enviado a su móvil con los últimos cuatro dígitos 6789.";
    desLabel1.textAlignment = NSTextAlignmentLeft;
    desLabel1.textColor=BColor_Hex(@"#7C7C7C", 1);
    desLabel1.numberOfLines=0;
    [self addSubview:desLabel1];
    [desLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(desLabel.mas_bottom).offset(10);
            
    }];
    
    UILabel *verLabel = [[UILabel alloc] init];
    [self addSubview:verLabel];
    verLabel.textColor=BColor_Hex(@"#1B1200", 1);
    verLabel.text=@"Por favor ingrese su código de verificación";
    verLabel.textAlignment = NSTextAlignmentLeft;
    verLabel.font=B_FONT_MEDIUM(13);
    [verLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-45);
            make.top.equalTo(desLabel1.mas_bottom).offset(30);
            
    }];



    UILabel *timeLabel = [[UILabel alloc] init];
    [self addSubview:timeLabel];
    timeLabel.font=B_FONT_MEDIUM(13);
    timeLabel.textColor=BColor_Hex(@"#7C7C7C", 1);
    timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel=timeLabel;
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(verLabel.mas_right).offset(0);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(desLabel1.mas_bottom).offset(30);
            make.width.equalTo(self).offset(30);
            
    }];

   



 
    CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
    cellProperty.cellBgColorNormal = BColor_Hex(@"#FFA402", 0.1);
    cellProperty.cellBgColorSelected = BColor_Hex(@"#FFA402", 0.3);
    cellProperty.cellCursorColor = BColor_Hex(@"#1B1200", 1);
    cellProperty.cellCursorWidth = 2;
    cellProperty.cellCursorHeight = 30;
    cellProperty.cornerRadius = 4;
    cellProperty.borderWidth = 0;
    cellProperty.cellFont = [UIFont boldSystemFontOfSize:24];
    cellProperty.cellTextColor = BColor_Hex(@"#1B1200", 1);
    cellProperty.configCellShadowBlock = ^(CALayer * _Nonnull layer) {
        layer.shadowColor = BColor_Hex(@"#FFA402", 0.2).CGColor;
        layer.shadowOpacity = 1;
        layer.shadowOffset = CGSizeMake(4, 4);
        layer.shadowRadius = 4;
    };

    CRBoxInputView *boxInputView = [[CRBoxInputView alloc] initWithCodeLength:4];
    boxInputView.boxFlowLayout.itemSize = CGSizeMake(50, 50);
    boxInputView.customCellProperty = cellProperty;
    [boxInputView loadAndPrepareViewWithBeginEdit:YES];
    [self addSubview:boxInputView];
    [boxInputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(verLabel.mas_bottom).offset(20);
            make.height.equalTo(@60);
    }];
    
    UILabel *desLabel2 = [[UILabel alloc] init];
    [self addSubview:desLabel2];
    desLabel2.textAlignment=NSTextAlignmentCenter;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"¿No ha recibido el código? Intente con un código de voz."attributes: @{NSFontAttributeName:B_FONT_REGULAR(11),NSForegroundColorAttributeName: BColor_Hex(@"#7C7C7C", 1)}];
    NSRange range=[[attStr string]rangeOfString:@"Intente con un código de voz."];
    [attStr addAttributes:@{NSForegroundColorAttributeName: BColor_Hex(@"#FC7909", 1)} range:range];
    desLabel2.attributedText = attStr;
    desLabel2.userInteractionEnabled=YES;
    [desLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(boxInputView.mas_bottom).offset(20);
            make.height.equalTo(@15);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resendVioceCode)];
    [desLabel2 addGestureRecognizer:tap];

    weakify(self)
    boxInputView.textDidChangeblock = ^(NSString *text, BOOL isFinished) {
        strongify(self);
        NSLog(@"text:%@", text);
        if (text.length == 4) {
            if( self.codeTag){
                self.codeTag(text);
            }
        }

       
    };
    
  
    
}
-(void)resendVioceCode{
    if( self.click){
        self.click();
    }
}

- (void)updateTime:(NSInteger )time
{
    
    
    if (time>0) {
        _timeLabel.text=[NSString stringWithFormat:@"%dS",time];
    }else{
        _timeLabel.text=@"";
    }
    
}

@end
