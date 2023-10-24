//
//  MyHeaderView.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/20.
//

#import "MyHeaderView.h"
#import "UIView+LinearGradient.h"
#import <ZZCircleProgress/ZZCircleProgress.h>

@interface MyHeaderView()
@property(strong, nonatomic) UIView * topBgView;

@property(strong, nonatomic) UIImageView * userIcon;

@property(strong, nonatomic) UILabel * userName;

@property(strong, nonatomic) UILabel * cartera; //名字后面跟的钱包

@property(strong, nonatomic) UILabel * SubNubmer; //子标题

@property(strong, nonatomic) UILabel * moneyLB; //

@property(strong, nonatomic) UILabel * moneyTOPLB; //
@property(strong, nonatomic) UILabel * moneyBottonLB; //


@property(strong, nonatomic) UIView *  circularBGView; //圆环
@property(strong, nonatomic) ZZCircleProgress *  circularView; //圆环

@property(strong, nonatomic) UIView *  noLoginBG; //
@property(strong, nonatomic) UILabel * noLoginTitleLB; //
@property(strong, nonatomic) UILabel * noLoginSubLB; //
@property(strong, nonatomic) UIButton* noLoginBtn;

@property(strong, nonatomic) UIView *  LoginTOPBG; //
@property(strong, nonatomic) UILabel * LoginTOPLeftLB; //
@property(strong, nonatomic) UILabel * LoginTOPRightLB; //

@property(strong, nonatomic) UIButton * LoginLeftBtn;
@property(strong, nonatomic) UIButton * LoginRightBtn;

@property(strong, nonatomic) UILabel * LoginLeftBtnTitle;
@property(strong, nonatomic) UILabel * LoginRightBtnTitle;



@end

@implementation MyHeaderView

-(void)buildSubViews{
    [self addSubview:self.topBgView];
    
    [self.topBgView addSubview:self.userIcon];
    
    [self.topBgView addSubview:self.userName];

    [self.topBgView addSubview:self.cartera];
    
    [self.topBgView addSubview:self.SubNubmer];
    
    [self.topBgView addSubview:self.circularBGView];
    
    [self.circularBGView addSubview:self.circularView];
    [self.topBgView addSubview:self.moneyLB];
    [self.topBgView addSubview:self.moneyTOPLB];
    [self.topBgView addSubview:self.moneyBottonLB];
    
    [self addSubview:self.noLoginBG];
    [self.noLoginBG addSubview:self.noLoginTitleLB];
    [self.noLoginBG addSubview:self.noLoginSubLB];
    [self.noLoginBG addSubview:self.noLoginBtn];
    
    [self addSubview:self.LoginTOPBG];
    [self.LoginTOPBG addSubview:self.LoginTOPLeftLB];
    [self.LoginTOPBG addSubview:self.LoginTOPRightLB];
    
    [self addSubview:self.LoginLeftBtn];
    [self addSubview:self.LoginRightBtn];
    [self.LoginLeftBtn addSubview:self.LoginLeftBtnTitle];
    [self.LoginRightBtn addSubview:self.LoginRightBtnTitle];
}

-(void)setSubViewsPosition{
    [self.topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(self).offset(40);
    }];
    
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(WF_StatusBarHeight + 20);
        make.width.height.equalTo(@(50));
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIcon.mas_right).offset(10);
        make.top.equalTo(self.userIcon);
    }];
    
    [self.cartera mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userName.mas_right).offset(2);
        make.bottom.equalTo(self.userName);
    }];
    
    [self.SubNubmer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userName);
        make.bottom.equalTo(self.userIcon).offset(-2.5);
    }];
    
    [self.moneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.topBgView).offset(131 + WF_StatusBarHeight);
    }];
    
    [self.moneyTOPLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.moneyLB);
        make.bottom.equalTo(self.moneyLB.mas_top).offset(-5);
    }];
    
    [self.moneyBottonLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.moneyLB);
        make.top.equalTo(self.moneyLB.mas_bottom).offset(5);
    }];
    
    [self.circularBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topBgView);
        make.top.equalTo(self.topBgView).offset(84 + WF_StatusBarHeight);
        make.width.equalTo(@(192));
        make.height.equalTo(@(97));
        
    }];
    
    [self.noLoginBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(14.5);
        make.right.equalTo(self).offset(-14.5);
        make.top.equalTo(self.circularBGView.mas_bottom);
        make.height.equalTo(@(80));
        
    }];
    
    [self.noLoginTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.noLoginBG).offset(15.5);
        make.top.equalTo(self.noLoginBG).offset(19.5);
        
    }];
    
    [self.noLoginSubLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.noLoginBG).offset(15.5);
        make.right.equalTo(self.noLoginBG).offset(-106);
        make.top.equalTo(self.noLoginTitleLB.mas_bottom).offset(10);
        
    }];
    
    
    [self.noLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.noLoginBG).offset(-14.5);
        make.centerY.equalTo(self.noLoginBG);
        make.width.equalTo(@(65));
        make.height.equalTo(@(34));
        
    }];
    

    [self.LoginTOPBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self.circularBGView.mas_bottom);
        make.height.equalTo(@(33));

    }];

    [self.LoginTOPLeftLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.LoginTOPBG).offset(14.5);
        make.centerY.equalTo(self.LoginTOPBG);

    }];
    [self.LoginTOPRightLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.LoginTOPBG).offset(-14.5);
        make.centerY.equalTo(self.LoginTOPBG);

    }];


    [self.LoginLeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.LoginTOPBG);
        make.right.equalTo(self.LoginTOPBG.mas_centerX).offset(-5);
        make.top.equalTo(self.LoginTOPBG.mas_bottom).offset(5);
        make.height.equalTo(@(65));

    }];
    [self.LoginRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.LoginTOPBG.mas_centerX).offset(5);
        make.right.equalTo(self.LoginTOPBG);
        make.top.equalTo(self.LoginTOPBG.mas_bottom).offset(5);
        make.height.equalTo(@(65));

    }];

    [self.LoginLeftBtnTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.LoginLeftBtn).offset(10);
        make.top.equalTo(self.LoginLeftBtn).offset(14.5);

    }];
    [self.LoginRightBtnTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.LoginRightBtn).offset(10);
        make.top.equalTo(self.LoginRightBtn).offset(14.5);

    }];

}


-(UIView *)topBgView{
    if(_topBgView == nil){
        _topBgView = [UIView new];
       
    }
    return _topBgView;
}

-(UIImageView *)userIcon{
    if(_userIcon == nil){
        _userIcon = [UIImageView new];
        _userIcon.layer.cornerRadius = 25;
        _userIcon.layer.masksToBounds = YES;
    }
    return _userIcon;
}

-(UILabel *)userName{
    if(_userName == nil){
        _userName = [UILabel new];
        _userName.textColor = [UIColor whiteColor];
        _userName.font = [UIFont boldSystemFontOfSize:19];
    }
    return _userName;
}

-(UILabel *)cartera{
    if(_cartera == nil){
        _cartera = [UILabel new];
        _cartera.textColor = [UIColor whiteColor];
        _cartera.font = [UIFont systemFontOfSize:14];
    }
    return _cartera;
}

-(UILabel *)SubNubmer{
    if(_SubNubmer == nil){
        _SubNubmer = [UILabel new];
        _SubNubmer.textColor = [UIColor whiteColor];
        _SubNubmer.font = [UIFont systemFontOfSize:12];
    }
    return _SubNubmer;
}

-(UILabel *)moneyLB{
    if(_moneyLB == nil){
        _moneyLB = [UILabel new];
        _moneyLB.textColor = [UIColor whiteColor];
        _moneyLB.font = [UIFont boldSystemFontOfSize:20];
    }
    return _moneyLB;
}

-(UILabel *)moneyTOPLB{
    if(_moneyTOPLB == nil){
        _moneyTOPLB = [UILabel new];
        _moneyTOPLB.textColor = [UIColor whiteColor];
        _moneyTOPLB.font = [UIFont systemFontOfSize:10];
    }
    return _moneyTOPLB;
}

-(UILabel *)moneyBottonLB{
    if(_moneyBottonLB == nil){
        _moneyBottonLB = [UILabel new];
        _moneyBottonLB.textColor = [UIColor whiteColor];
        _moneyBottonLB.font = [UIFont systemFontOfSize:10];
    }
    return _moneyBottonLB;
}
-(UIView *)circularBGView{
    if(_circularBGView == nil){
        _circularBGView = [UIView new];
    }
    return _circularBGView;
}

-(ZZCircleProgress *)circularView{
    if(_circularView == nil){
        _circularView = [[ZZCircleProgress alloc] initWithFrame:CGRectMake(0, 0, 192, 192) pathBackColor:[UIColor jk_colorWithHexString:@"#FDB14C"] pathFillColor:[UIColor whiteColor] startAngle:180 strokeWidth:10];
        _circularView.showPoint = NO;
        _circularView.reduceAngle = 180;
        _circularView.showProgressText = NO;
        _circularView.increaseFromLast = YES;
    }
    return _circularView;
}

-(UIView *)noLoginBG{
    if(_noLoginBG == nil){
        _noLoginBG = [UIView new];
        _noLoginBG.backgroundColor = [UIColor whiteColor];
        _noLoginBG.layer.cornerRadius = 15;
        _noLoginBG.layer.masksToBounds = YES;
    }
    return _noLoginBG;
}

-(UILabel *)noLoginTitleLB{
    if(_noLoginTitleLB == nil){
        _noLoginTitleLB = [UILabel new];
        _noLoginTitleLB.textColor = [UIColor jk_colorWithHexString:@"#1B1200"];
        _noLoginTitleLB.font = [UIFont boldSystemFontOfSize:15];
    }
    return _noLoginTitleLB;
}

-(UILabel *)noLoginSubLB{
    if(_noLoginSubLB == nil){
        _noLoginSubLB = [UILabel new];
        _noLoginSubLB.textColor = [UIColor jk_colorWithHexString:@"#7C7C7C"];
        _noLoginSubLB.font = [UIFont boldSystemFontOfSize:10];
        _noLoginSubLB.numberOfLines = 2;
    }
    return _noLoginSubLB;
}

-(UIButton *)noLoginBtn{
    if(_noLoginBtn == nil){
        _noLoginBtn = [UIButton new];
        [_noLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _noLoginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [_noLoginBtn addTarget:self action:@selector(clicknoLoginBtn) forControlEvents:UIControlEventTouchUpInside];
        [_noLoginBtn addLinearGradientwithSize:CGSizeMake(65, 34) withColors:@[(id)[UIColor jk_colorWithHexString:@"#FFB602"].CGColor, (id)[UIColor jk_colorWithHexString:@"#FC7500"].CGColor] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner |kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:17];
    }
    return _noLoginBtn;
}


-(UIView *)LoginTOPBG{
    if(_LoginTOPBG == nil){
        _LoginTOPBG = [UIView new];
        _LoginTOPBG.layer.cornerRadius = 5;
        _LoginTOPBG.layer.masksToBounds = YES;
        [_LoginTOPBG addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth - 30, 34) withColors:@[(id)[UIColor jk_colorWithHexString:@"#FFBA1B"].CGColor, (id)[UIColor jk_colorWithHexString:@"#FC851A"].CGColor] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner |kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:5];
    }
    return _LoginTOPBG;
}

-(UILabel *)LoginTOPLeftLB{
    if(_LoginTOPLeftLB == nil){
        _LoginTOPLeftLB = [UILabel new];
        _LoginTOPLeftLB.textColor = [UIColor whiteColor];
        _LoginTOPLeftLB.font = [UIFont boldSystemFontOfSize:11];
    }
    return _LoginTOPLeftLB;
}

-(UILabel *)LoginTOPRightLB{
    if(_LoginTOPRightLB == nil){
        _LoginTOPRightLB = [UILabel new];
        _LoginTOPRightLB.textColor = [UIColor whiteColor];
        _LoginTOPRightLB.font = [UIFont boldSystemFontOfSize:11];
    }
    return _LoginTOPRightLB;
}


-(UIButton *)LoginLeftBtn{
    if(_LoginLeftBtn == nil){
        _LoginLeftBtn = [UIButton new];
        [_LoginLeftBtn setBackgroundImage:[UIImage imageNamed:@"Factura"] forState:UIControlStateNormal];
        
        [_LoginLeftBtn addTarget:self action:@selector(ClickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _LoginLeftBtn;
}
-(UIButton *)LoginRightBtn{
    if(_LoginRightBtn == nil){
        _LoginRightBtn = [UIButton new];
        [_LoginRightBtn setBackgroundImage:[UIImage imageNamed:@"cupon"] forState:UIControlStateNormal];
        
        [_LoginRightBtn addTarget:self action:@selector(ClickRightBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _LoginRightBtn;
}

-(UILabel *)LoginLeftBtnTitle{
    if(_LoginLeftBtnTitle == nil){
        _LoginLeftBtnTitle = [UILabel new];
        _LoginLeftBtnTitle.textColor = [UIColor jk_colorWithHexString:@"#407AFB"];
        _LoginLeftBtnTitle.font = [UIFont boldSystemFontOfSize:15];
    }
    return _LoginLeftBtnTitle;
}

-(UILabel *)LoginRightBtnTitle{
    if(_LoginRightBtnTitle == nil){
        _LoginRightBtnTitle = [UILabel new];
        _LoginRightBtnTitle.textColor = [UIColor jk_colorWithHexString:@"#FD1717"];
        _LoginRightBtnTitle.font = [UIFont boldSystemFontOfSize:15];
    }
    return _LoginRightBtnTitle;
}


-(void)clicknoLoginBtn{
    if(self.clickLoginBlock){
        self.clickLoginBlock();
    }
}
-(void)ClickLeftBtn{
    if(self.clickLeftBtnBlock){
        self.clickLeftBtnBlock();
    }
}
-(void)ClickRightBtn{
    if(self.clickRightBtnBlock){
        self.clickRightBtnBlock();
    }
}



-(void)updataHeaderViewWithModel:(PMAuthModel *)model{
    
    if([PMAccountTool isLogin] == NO || !model){
        self.jk_height = WF_StatusBarHeight + 270;

        self.circularView.progress = 0;
        NSArray *colors = @[(id)[UIColor jk_colorWithHexString:@"#FFB602"].CGColor, (id)[UIColor jk_colorWithHexString:@"#FC7500"].CGColor];
        [self.topBgView addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth, self.jk_height - 40) withColors:colors startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0) maskedCorners:kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:50];
        
        self.userIcon.image = DefaultAvatar;
        self.userName.text = @"PresiMex, ";
        self.cartera.text = @"su cartera instante";
        self.SubNubmer.text = @"XXXXXXXXXX";
        
        [self.moneyLB mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self);
            make.top.equalTo(self.topBgView).offset(131 + WF_StatusBarHeight);
        }];
        self.moneyBottonLB.hidden = NO;
        self.moneyLB.text = @"$30000";
        self.moneyTOPLB.text = @"Hasta";
        self.moneyBottonLB.text = @"Sin monto";
        
        self.noLoginBG.hidden = NO;
        self.noLoginTitleLB.text = @"Iniciar sesión";
        self.noLoginSubLB.text = @"Acceda a su cuenta para conocer su monto máximo.";
        [self.noLoginBtn setTitle:@"Ir" forState:UIControlStateNormal];
        
        self.LoginTOPBG.hidden = YES;
        self.LoginLeftBtn.hidden = YES;
        self.LoginRightBtn.hidden = YES;
        
        return;
    }
   
    
    if([model.shop integerValue] == 20) {
        
        
        PMUser * userModel = [PMAccountTool account];
        
        self.jk_height = WF_StatusBarHeight + 291;

        NSArray *colors = @[(id)[UIColor jk_colorWithHexString:@"#FFB602"].CGColor, (id)[UIColor jk_colorWithHexString:@"#FC7500"].CGColor];
        [self.topBgView addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth, self.jk_height - 40) withColors:colors startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0) maskedCorners:kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:50];
        
        self.userIcon.image = DefaultAvatar;
        self.userName.text = @"PresiMex, ";
        self.cartera.text = @"su cartera instante";
        self.SubNubmer.text = userModel.tel;
        
        [self.moneyLB mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self);
            make.top.equalTo(self.topBgView).offset(145 + WF_StatusBarHeight);
        }];
        self.moneyBottonLB.hidden = YES;
        self.moneyLB.text = [NSString stringWithFormat:@"$%@",model.researcher];
        self.moneyTOPLB.text = @"Crédito disponible";
        
        self.noLoginBG.hidden = YES;
        
        self.LoginTOPBG.hidden = NO;
        self.LoginLeftBtn.hidden = NO;
        self.LoginRightBtn.hidden = NO;
        self.LoginTOPLeftLB.text = [NSString stringWithFormat:@"Límite de crédito: %@",model.foto];
        self.LoginTOPRightLB.text = [NSString stringWithFormat:@"Crédito utilizado: %@",model.antibody];
        
        
        
        self.circularView.progress = [model.researcher doubleValue]/[model.foto doubleValue];
        self.LoginLeftBtnTitle.text = @"Factura";
        self.LoginRightBtnTitle.text = @"Cupón";
        
        
    }else{
        PMUser * userModel = [PMAccountTool account];
        
        self.jk_height = WF_StatusBarHeight + 270;

        NSArray *colors = @[(id)[UIColor jk_colorWithHexString:@"#FFB602"].CGColor, (id)[UIColor jk_colorWithHexString:@"#FC7500"].CGColor];
        [self.topBgView addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth, self.jk_height - 40) withColors:colors startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0) maskedCorners:kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:50];
        
        self.userIcon.image = DefaultAvatar;
        self.userName.text = @"PresiMex, ";
        self.cartera.text = @"su cartera instante";
        self.SubNubmer.text = userModel.tel;
        
        [self.moneyLB mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self);
            make.top.equalTo(self.topBgView).offset(131 + WF_StatusBarHeight);
        }];
        self.moneyBottonLB.hidden = NO;
//        self.moneyLB.text = [NSString stringWithFormat:@"$%@",model.researcher];
        self.moneyLB.text = [NSString stringWithFormat:@"$%@",@"30,000"];
        self.moneyTOPLB.text = @"Hasta";
        self.moneyBottonLB.text = @"Sin monto";
        
        self.noLoginBG.hidden = NO;
        self.noLoginTitleLB.text = @"Autenticación";
        self.noLoginSubLB.text = @"Avance con la autenticación de su identidad para acceder al monto máximo.";
        [self.noLoginBtn setTitle:@"Ir" forState:UIControlStateNormal];
        
        self.LoginTOPBG.hidden = YES;
        self.LoginLeftBtn.hidden = YES;
        self.LoginRightBtn.hidden = YES;
        
        
    }


}

@end
