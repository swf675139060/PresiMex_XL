//
//  HomeSectionView.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/30.
//

#import "HomeSectionView.h"

@interface HomeSectionView()

@property(strong, nonatomic) UIImageView * userIcon;
@property(strong, nonatomic) UILabel * userName;
@property(strong, nonatomic) UILabel * subtitle;
@property(strong, nonatomic) UIImageView * arrowImage;//箭头
@property(strong, nonatomic) UILabel * moneyLB;


@end

@implementation HomeSectionView

-(void)buildSubViews{
    
    [self addSubview:self.userIcon];
    [self addSubview:self.userName];
    [self addSubview:self.subtitle];
    [self addSubview:self.arrowImage];
    [self addSubview:self.moneyLB];
    
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(16));
        make.centerY.equalTo(@(0));
        make.width.height.equalTo(@(50));
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIcon.mas_right).offset(10.5);
        make.top.equalTo(self.userIcon);
    }];
    
    [self.subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIcon.mas_right).offset(10.5);
        make.bottom.equalTo(self.userIcon);
    }];
    
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.top.equalTo(self.userIcon);
    }];
    
    [self.moneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.bottom.equalTo(self.userIcon);
    }];
    
}


-(void)upDataWithModel:(id)Model select:(BOOL)select{
    self.userIcon.backgroundColor = [UIColor grayColor];
    self.userName.text = @"1111";
    if(select == YES){
        _arrowImage.image = [UIImage imageNamed:@"shangJian"];
    }else{
        _arrowImage.image = [UIImage imageNamed:@"xiaJian"];
    }
}



-(UIImageView *)userIcon{
    if(_userIcon == nil){
        _userIcon = [UIImageView new];
        _userIcon.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _userIcon;
}

-(UILabel *)userName{
    if(_userName == nil){
        _userName = [UILabel new];
        [_userName setText:@"" TextColor:BColor_Hex(@"#1B1200", 1) Font:[UIFont boldSystemFontOfSize:15]];
        
    }
    return _userName;
}

-(UILabel *)subtitle{
    if(_subtitle == nil){
        _subtitle = [UILabel new];
        [_subtitle setText:@"Monto del préstamo:" TextColor:BColor_Hex(@"#7C7C7C", 1) Font:[UIFont boldSystemFontOfSize:13]];
        
    }
    return _subtitle;
}

-(UIImageView *)arrowImage{
    if(_arrowImage == nil){
        _arrowImage = [UIImageView new];
        _arrowImage.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    return _arrowImage;
}

-(UILabel *)moneyLB{
    if(_moneyLB == nil){
        _moneyLB = [UILabel new];
        [_moneyLB setText:@"$ 1,000" TextColor:BColor_Hex(@"#FC7500", 1) Font:[UIFont boldSystemFontOfSize:15]];
        
    }
    return _moneyLB;
}

@end
