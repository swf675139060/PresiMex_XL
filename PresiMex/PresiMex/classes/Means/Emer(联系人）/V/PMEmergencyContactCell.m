//
//  PMEmergencyContactCell.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/6/3.
//

#import "PMEmergencyContactCell.h"
#import "BasicDataModel.h"



@interface PMEmergencyContactCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UILabel   *reTitleLabel;
@property (nonatomic, strong) UILabel   *phoneTitleLabel;
@property (nonatomic, strong) UILabel   *pTitleLabel;

@property (nonatomic, strong) UITextField *reContentTF;
@property (nonatomic, strong) UITextField *phoneContentTF;
@property (nonatomic, strong) PMEmergencyContactModel *model;
@end

@implementation PMEmergencyContactCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"PMEmergencyContactCell";
    PMEmergencyContactCell *cell= [[PMEmergencyContactCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    
//    JKEmergencyContactCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[JKEmergencyContactCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
    return cell;
}
-(void)setupSubViews{
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(15,15,300,25);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    titleLabel.textColor=BColor_Hex(@"#1B1200", 1);
    titleLabel.font=B_FONT_BOLD(20);
    _titleLabel=titleLabel;
    
    UIView *relationBg=[UIView new];
    [self.contentView addSubview:relationBg];
    relationBg.frame=CGRectMake(0,titleLabel.swf_bottom+20, WF_ScreenWidth, 95);
    
    
    _reTitleLabel=[[UILabel alloc] init];
    [relationBg addSubview:_reTitleLabel];
    _reTitleLabel.font = [UIFont systemFontOfSize:12];
    _reTitleLabel.textColor = BColor_Hex(@"#1B1200",1);
    _reTitleLabel.frame=CGRectMake(15,0,200, 20);
    _reTitleLabel.text=@"Relación";
    
    
    UIView *rebgView=[UIView new];
    [relationBg addSubview:rebgView];
    relationBg.layer.borderColor=BColor_Hex(@"#CCCCCC", 0.5).CGColor;
    rebgView.layer.borderWidth=0.5;
    rebgView.layer.cornerRadius=22.5;
    rebgView.frame=CGRectMake(15,_reTitleLabel.swf_bottom+15, WF_ScreenWidth-30, 45);
    
    
    _reContentTF = [[UITextField alloc] init];
    [rebgView addSubview:_reContentTF];
    _reContentTF.font = B_FONT_BOLD(16);
    _reContentTF.textColor =BColor_Hex(@"#333333",1);
    _reContentTF.textAlignment = NSTextAlignmentLeft;
    _reContentTF.frame=CGRectMake(20, 1,WF_ScreenWidth-30-20-39, 43);
    _reContentTF.delegate=self;
    _reContentTF.tag=0;
   
    
    UIImageView*arrowImageView = [[UIImageView alloc] init];
    arrowImageView.contentMode=UIViewContentModeScaleAspectFit;
    [rebgView addSubview:arrowImageView];
    arrowImageView.frame=CGRectMake(WF_ScreenWidth-30-14-15,18.5, 14,8);
    arrowImageView.image=[UIImage imageNamed:@"xiaJian"];
    
  
    
    UIView *phoneBg=[UIView new];
    [self.contentView  addSubview:phoneBg];
    phoneBg.frame=CGRectMake(0,relationBg.swf_bottom, WF_ScreenWidth, 95);
    phoneBg.tag=1;
   
   
    _phoneTitleLabel=[[UILabel alloc] init];
    [phoneBg addSubview:_phoneTitleLabel];
    _phoneTitleLabel.font = [UIFont systemFontOfSize:12];
    _phoneTitleLabel.textColor = BColor_Hex(@"#1B1200",1);
    _phoneTitleLabel.frame=CGRectMake(15,0,200, 20);
    _phoneTitleLabel.text=@"Número de teléfono";
    
    UIView *phonebgView=[UIView new];
    [phoneBg addSubview:phonebgView];
    phonebgView.layer.borderColor=BColor_Hex(@"#CCCCCC", 0.5).CGColor;
    phonebgView.layer.borderWidth=0.5;
    phonebgView.layer.cornerRadius=22.5;
    phonebgView.frame=CGRectMake(15,_phoneTitleLabel.swf_bottom+15, WF_ScreenWidth-30, 45);
    
    _pTitleLabel=[[UILabel alloc] init];
    [phonebgView addSubview:_pTitleLabel];
    _pTitleLabel.font =B_FONT_BOLD(16);
    _pTitleLabel.textColor = BColor_Hex(@"#1B1200",1);
    _pTitleLabel.text=@"+52";
    _pTitleLabel.frame=CGRectMake(15,12.5,35,20);
   


    UIImageView *leftNameImag=[[UIImageView alloc]init];
    leftNameImag.frame=CGRectMake(WF_ScreenWidth-30-45,2.5,45,40);
    [phonebgView addSubview:leftNameImag];
    leftNameImag.image=[UIImage imageNamed:@"icon_contact_small"];
    leftNameImag.tag = 2;
    leftNameImag.userInteractionEnabled = YES;
    leftNameImag.contentMode = UIViewContentModeCenter;
    
    _phoneContentTF = [[UITextField alloc] init];
    [phonebgView addSubview:_phoneContentTF];
    _phoneContentTF.font = B_FONT_BOLD(16);
    _phoneContentTF.textColor = BColor_Hex(@"#1B1200",1);
    _phoneContentTF.textAlignment = NSTextAlignmentLeft;
    _phoneContentTF.delegate = self;
//    [_phoneContentTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _phoneContentTF.frame=CGRectMake(_pTitleLabel.swf_right+20, 12.5, WF_ScreenWidth-30-45-20-45, 20);
    _phoneContentTF.tag=2;
    _phoneContentTF.keyboardType = UIKeyboardTypeNumberPad;
   
    


    UITapGestureRecognizer *relTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [relationBg addGestureRecognizer:relTap];
    
//    UITapGestureRecognizer *phoneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
//    [phoneBg addGestureRecognizer:phoneTap];
    
    UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [leftNameImag addGestureRecognizer:imageTap];

}

-(void)setCellWithModel:(PMEmergencyContactModel*)model{
    _model = model;
    _titleLabel.text=model.title;
    
    if (model.indx >= 0) {
        BasicDataModel *  DataModel = model.contentArr[model.indx];
        _reContentTF.text = DataModel.title;
    }else if (model.relation && model.relation.length){
        _reContentTF.text =model.relation;
    }else{
        _reContentTF.text = @"";
    }
    _phoneContentTF.text=model.telephone;

}
- (void)textFieldDidChange:(UITextField *)textField {
    
    
    if (self.inputBlock) {
        self.inputBlock(textField.text,[self.model.type integerValue]);
     
    }
}




-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    
    if (self.guanXiClickBlock) {
        if (textField.tag==0) {
            self.guanXiClickBlock([self.model.type integerValue]);
            
          return NO;
        }else{
            if (self.tongXunLUClickBlock) {
                self.tongXunLUClickBlock([self.model.type integerValue]);
            }
          return NO;
        }
    }

    return YES;

}
-(void)tap:(UITapGestureRecognizer *)relTap{
    if (relTap.view.tag==0) {
        if (self.guanXiClickBlock) {
            self.guanXiClickBlock([self.model.type integerValue]);
            
        }
    }else{
        if (self.tongXunLUClickBlock) {
            self.tongXunLUClickBlock([self.model.type integerValue]);
        }
        
    }
}


@end
