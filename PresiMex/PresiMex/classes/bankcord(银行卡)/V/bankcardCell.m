//
//  bankcardCell.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/17.
//

#import "bankcardCell.h"

@interface bankcardCell()

@property(strong, nonatomic) UIImageView * BGView;

@property(strong, nonatomic) UIImageView * bankCardsub;

@property(strong, nonatomic) UILabel * cardName;

@property(strong, nonatomic) UILabel * numberLB;

@property(strong, nonatomic) UILabel * contentLB;


@end


@implementation bankcardCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *ID = @"bankcardCell";
    
    bankcardCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[bankcardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell creatSubView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

+(instancetype)alertCellWithTableView:(UITableView *)tableView{
    NSString *ID = @"alertBankcardCell";
    
    bankcardCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[bankcardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell alertCreatSubView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
-(void)alertCreatSubView{
    [self.contentView addSubview:self.BGView];
    
    [self.BGView addSubview:self.cardName];
    [self.BGView addSubview:self.numberLB];
    [self.BGView addSubview:self.contentLB];
    [self.BGView addSubview:self.bankCardsub];
    CGFloat biLi = WF_ScreenWidth/360;
    
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(WF_ScreenWidth - 64));
        make.height.equalTo(@(177*biLi));
        make.left.equalTo(@(12));
        make.top.equalTo(@(20));
        make.bottom.equalTo(@(0));
        
    }];
    
    
    [self.cardName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.BGView).offset(biLi* 16);
        make.left.equalTo(@(biLi*20));
        make.right.equalTo(@( -(biLi*18)) );
        
    }];
    
    [self.numberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.BGView).offset(biLi* 104);
        make.left.equalTo(@(biLi*20));
        make.right.equalTo(@( -(biLi*18)) );
        
    }];
    
    [self.contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.BGView).offset(-(biLi* 15));
        make.right.equalTo(@(-biLi*20));
        
    }];
    
    [self.bankCardsub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.BGView).offset(-(biLi* 15));
        make.left.equalTo(@(biLi*20));
        make.width.equalTo(@(biLi*115));
        make.height.equalTo(@(biLi*18));

        
    }];
}

-(void)creatSubView{
    [self.contentView addSubview:self.BGView];
    
    [self.BGView addSubview:self.cardName];
    [self.BGView addSubview:self.numberLB];
    [self.BGView addSubview:self.contentLB];
    [self.BGView addSubview:self.bankCardsub];
    CGFloat biLi = WF_ScreenWidth/360;
    
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(WF_ScreenWidth - 64));
        make.height.equalTo(@(177*biLi));
        make.left.equalTo(@(32));
        make.top.equalTo(@(35));
        make.bottom.equalTo(@(0));
        
    }];
    
    
    [self.cardName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.BGView).offset(biLi* 16);
        make.left.equalTo(@(biLi*20));
        make.right.equalTo(@( -(biLi*18)) );
        
    }];
    
    [self.numberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.BGView).offset(biLi* 104);
        make.left.equalTo(@(biLi*20));
        make.right.equalTo(@( -(biLi*18)) );
        
    }];
    
    [self.contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.BGView).offset(-(biLi* 15));
        make.right.equalTo(@(-biLi*20));
        
    }];
    
    [self.bankCardsub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.BGView).offset(-(biLi* 15));
        make.left.equalTo(@(biLi*20));
        make.width.equalTo(@(biLi*115));
        make.height.equalTo(@(biLi*18));

        
    }];
}

-(UIImageView *)BGView{
    if(_BGView == nil){
        _BGView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bankCard"]];
    }
    return _BGView;
}

-(UIImageView *)bankCardsub{
    if(_bankCardsub == nil){
        _bankCardsub = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bankCardsub"]];
    }
    return _bankCardsub;
}



-(UILabel *)cardName{
    if(_cardName == nil){
        _cardName = [[UILabel alloc] init];
        _cardName.adjustsFontSizeToFitWidth = YES;
        _cardName.numberOfLines = 1;
        _cardName.textAlignment = NSTextAlignmentLeft;
        [_cardName setText:@"" TextColor:[[UIColor jk_colorWithHexString:@"#FFFFFF"] colorWithAlphaComponent:0.8] Font:[UIFont boldSystemFontOfSize:16]];
        
    }
    return _cardName;
}

-(UILabel *)numberLB{
    if(_numberLB == nil){
        _numberLB = [[UILabel alloc] init];
        _numberLB.adjustsFontSizeToFitWidth = YES;
        _numberLB.numberOfLines = 1;
        _numberLB.textAlignment = NSTextAlignmentCenter;
        [_numberLB setText:@"" TextColor:[UIColor jk_colorWithHexString:@"#FFFFFF"] Font:[UIFont boldSystemFontOfSize:21]];
        
    }
    return _numberLB;
}


-(UILabel *)contentLB{
    if(_contentLB == nil){
        _contentLB = [[UILabel alloc] init];
        _contentLB.adjustsFontSizeToFitWidth = YES;
        _contentLB.numberOfLines = 0;
        [_contentLB setText:@"" TextColor:[UIColor jk_colorWithHexString:@"#FFFFFF"] Font:[UIFont boldSystemFontOfSize:15]];
    }
    return _contentLB;
}



-(void)updataWithModel:(bankcardModel *)model indx:(NSInteger)indx{
    if(model){
        
        self.cardName.text = [NSString stringWithFormat:@"BANK %@",model.marshall];
     
        self.numberLB.text = model.diploma;
        if ([model.diameter integerValue] == 1) {
            
            self.contentLB.text = @"Tarjeta de débito";
        } else {
            self.contentLB.text = @"CLABE";
        }
    }
    
}

@end
