//
//  CuponCell.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/27.
//

#import "CuponCell.h"

@interface CuponCell()

@property(strong, nonatomic) UIImageView * BGView;

@property(strong, nonatomic) UILabel * numberLB;

@property(strong, nonatomic) UILabel * titleLB;

@property(strong, nonatomic) UILabel * contentLB;

@property(strong, nonatomic) UILabel * timeLB;

@property(strong, nonatomic) UIButton * useBtn;

@property(assign, nonatomic)NSInteger indx;

@end


@implementation CuponCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *ID = @"CuponCell";
    
    CuponCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CuponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell creatSubView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


-(void)creatSubView{
    [self.contentView addSubview:self.BGView];
    
    [self.BGView addSubview:self.numberLB];
    [self.BGView addSubview:self.titleLB];
    [self.BGView addSubview:self.contentLB];
    [self.BGView addSubview:self.timeLB];
    [self.BGView addSubview:self.useBtn];
    CGFloat width = WF_ScreenWidth -35;
    
    CGFloat biLi = width/325;
    
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(width));
        make.height.equalTo(@(width/325*140));
        make.left.equalTo(@(17.5));
        make.top.equalTo(@(20));
        make.bottom.equalTo(@(0));
        
    }];
    
    [self.numberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.BGView);
        make.left.equalTo(@(biLi*36.5));
        make.width.lessThanOrEqualTo(@(biLi*75));
        
    }];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.BGView).offset(biLi* 20);
        make.left.equalTo(@(biLi*130));
        make.width.equalTo(@(biLi*156));
        
    }];
    
    [self.contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.BGView).offset(biLi* 49);
        make.left.equalTo(@(biLi*130));
        make.width.lessThanOrEqualTo(@(biLi*150));
        
    }];
    
    [self.timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLB.mas_bottom).offset(biLi* 5);
        make.left.equalTo(@(biLi*130));
        make.width.lessThanOrEqualTo(@(biLi*150));
        
    }];
    
    [self.useBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.BGView).offset(biLi* 102);
        make.left.equalTo(@(biLi*156.5));
        make.width.equalTo(@(biLi*100));
        make.height.equalTo(@(biLi*25));
        
    }];
}

-(UIImageView *)BGView{
    if(_BGView == nil){
        _BGView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cuponBG"]];
    }
    return _BGView;
}

-(UILabel *)numberLB{
    if(_numberLB == nil){
        _numberLB = [[UILabel alloc] init];
        _numberLB.adjustsFontSizeToFitWidth = YES;
        _numberLB.numberOfLines = 0;
        [_numberLB setText:@"" TextColor:[UIColor jk_colorWithHexString:@"#D74257"] Font:[UIFont systemFontOfSize:25]];
    }
    return _numberLB;
}

-(UILabel *)titleLB{
    if(_titleLB == nil){
        _titleLB = [[UILabel alloc] init];
        _titleLB.adjustsFontSizeToFitWidth = YES;
        _titleLB.numberOfLines = 0;
        _titleLB.textAlignment = NSTextAlignmentCenter;
        [_titleLB setText:@"" TextColor:[UIColor jk_colorWithHexString:@"#1B1200"] Font:[UIFont boldSystemFontOfSize:12]];
        
    }
    return _titleLB;
}


-(UILabel *)contentLB{
    if(_contentLB == nil){
        _contentLB = [[UILabel alloc] init];
        _contentLB.adjustsFontSizeToFitWidth = YES;
        _contentLB.numberOfLines = 0;
        [_contentLB setText:@"" TextColor:[UIColor jk_colorWithHexString:@"#7C7C7C"] Font:[UIFont systemFontOfSize:11]];
    }
    return _contentLB;
}

-(UILabel *)timeLB{
    if(_timeLB == nil){
        _timeLB = [[UILabel alloc] init];
        _timeLB.adjustsFontSizeToFitWidth = YES;
        _timeLB.numberOfLines = 0;
        [_timeLB setText:@"" TextColor:[UIColor jk_colorWithHexString:@"#7C7C7C"] Font:[UIFont systemFontOfSize:11]];
    }
    return _timeLB;
}

-(UIButton *)useBtn{
    if(_useBtn == nil){
        _useBtn = [[UIButton alloc] init];
        [_useBtn setBackgroundColor:[UIColor jk_colorWithHexString:@"#FAD056"]];
        [_useBtn setTitleColor:[UIColor jk_colorWithHexString:@"#D74257"] forState:UIControlStateNormal];
        _useBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_useBtn setTitle:@"Usar" forState:UIControlStateNormal];
        _useBtn.layer.cornerRadius = 12.5;
        _useBtn.layer.masksToBounds = YES;
        
        [_useBtn addTarget:self action:@selector(clickUseBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _useBtn;
}



-(void)clickUseBtn{
    if(self.clickUseBlock){
        self.clickUseBlock(self.indx);
    }
}

-(void)updataWithModel:(CuponModel *)model indx:(NSInteger)indx;{
    self.indx = indx;
    self.numberLB.text = [NSString stringWithFormat:@"$ %@",model.readers];
    
    self.titleLB.text = model.rev;
    
    self.contentLB.text = model.nu;
    
    self.timeLB.text = [NSString stringWithFormat:@"Válido hasta el : %@",model.ruby];
    
    
}
@end
