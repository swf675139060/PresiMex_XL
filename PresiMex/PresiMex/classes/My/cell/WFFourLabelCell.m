//
//  WFFourLabelCell.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/30.
//

#import "WFFourLabelCell.h"

@implementation WFFourLabelCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *ID = @"WFFourLabelCell";
    
    WFFourLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WFFourLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell creatSubView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


-(void)creatSubView{
    [self.contentView addSubview:self.BGView];
    
    [self.BGView addSubview:self.label1];
    [self.BGView addSubview:self.label2];
    [self.BGView addSubview:self.label3];
    [self.BGView addSubview:self.label4];
    [self.BGView addSubview:self.centerLine];
    [self.BGView addSubview:self.bottomLine];
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
        
    }];
    
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.BGView).multipliedBy(0.5);
        make.top.equalTo(@(10));
        make.left.equalTo(@(0));
        
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.BGView.mas_right).multipliedBy(0.5);
        make.top.equalTo(self.label1);
        make.right.equalTo(@(0));
        
    }];
    
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.label1);
        make.top.equalTo(self.label1.mas_bottom).offset(7.5);
        make.left.equalTo(self.label1);
        make.bottom.equalTo(@(10));
        
    }];
    
    [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label2);
        make.top.equalTo(self.label3);
        make.right.equalTo(self.label2);
        
    }];
    
    [self.centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.BGView);
        make.top.equalTo(self.label1);
        make.bottom.equalTo(self.label3);
        make.width.equalTo(@(0.5));
        
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(20));
        make.right.equalTo(@(-20));
        make.bottom.equalTo(@(0));
        make.height.equalTo(@(0.5));
        
    }];
    
}

-(UIView *)BGView{
    if(_BGView == nil){
        _BGView = [[UIView alloc] init];
    }
    return _BGView;
}

-(UILabel *)label1{
    if(_label1 == nil){
        _label1 = [[UILabel alloc] init];
        _label1.numberOfLines = 0;
        _label1.textAlignment = NSTextAlignmentCenter;
    }
    return _label1;
}

-(UILabel *)label2{
    if(_label2 == nil){
        _label2 = [[UILabel alloc] init];
        _label2.numberOfLines = 0;
        _label2.textAlignment = NSTextAlignmentCenter;
    }
    return _label2;
}


-(UILabel *)label3{
    if(_label3 == nil){
        _label3 = [[UILabel alloc] init];
        _label3.numberOfLines = 0;
        _label3.textAlignment = NSTextAlignmentCenter;
    }
    return _label3;
}

-(UILabel *)label4{
    if(_label4 == nil){
        _label4 = [[UILabel alloc] init];
        _label4.numberOfLines = 0;
        _label4.textAlignment = NSTextAlignmentCenter;
    }
    return _label4;
}


-(UIView *)centerLine{
    if(_centerLine == nil){
        _centerLine = [[UIView alloc] init];
        _centerLine.backgroundColor = BColor_Hex(@"#DDDDDD", 1);
    }
    return _centerLine;
}

-(UIView *)bottomLine{
    if(_bottomLine == nil){
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = BColor_Hex(@"#DDDDDD", 1);
    }
    return _bottomLine;
}



-(void)upBGFrameWithInsets:(UIEdgeInsets )padding{
    [self.BGView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
    }];
}


-(void)upLabelsFrameWithInsets:(UIEdgeInsets )padding spacing:(CGFloat)spacing{
    
    [self.label1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.BGView).multipliedBy(0.5).offset(-padding.left);
        make.top.equalTo(@(padding.top));
        make.left.equalTo(@(padding.left));
        
    }];
    
    [self.label2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.BGView.mas_right).multipliedBy(0.5).offset(padding.right);
        make.top.equalTo(self.label1);
        make.right.equalTo(@(-padding.right));
        
    }];
    
    [self.label3 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.label1);
        make.top.equalTo(self.label1.mas_bottom).offset(spacing);
        make.left.equalTo(self.label1);
        make.bottom.equalTo(@(-padding.bottom));
        
    }];
    
}

-(void)upDataWithModel:(id)model{
    [self.label1 setText:@"1" TextColor:BColor_Hex(@"#999999", 1) Font:[UIFont systemFontOfSize:12]];
    [self.label2 setText:@"2" TextColor:BColor_Hex(@"#999999", 1) Font:[UIFont systemFontOfSize:12]];
    [self.label3 setText:@"3" TextColor:BColor_Hex(@"#1B1200", 1) Font:[UIFont boldSystemFontOfSize:20]];
    [self.label4 setText:@"4" TextColor:BColor_Hex(@"#1B1200", 1) Font:[UIFont boldSystemFontOfSize:20]];
}


@end
