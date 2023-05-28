//
//  WFSetCell.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/27.
//

#import "WFSetCell.h"

@interface WFSetCell()


@property(strong, nonatomic) UIImageView * typeIcon;
@property(strong, nonatomic) UIImageView * moreIcon;



@end


@implementation WFSetCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *ID = @"WFSetCell";
    
    WFSetCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WFSetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell creatSubView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


-(void)creatSubView{
    [self.contentView addSubview:self.BGView];
    
    [self.BGView addSubview:self.typeIcon];
    [self.BGView addSubview:self.typeLabel];
    [self.BGView addSubview:self.valueLabel];
    [self.BGView addSubview:self.moreIcon];
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
        
    }];
    
    
    [self.typeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.BGView);
        make.left.equalTo(@(15));
        
    }];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.BGView);
        make.left.equalTo(self.typeIcon.mas_right).offset(10);
        
    }];
    
    
    [self.moreIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.BGView);
        make.right.equalTo(@(-15));
        
    }];
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.BGView);
        make.right.equalTo(self.moreIcon.mas_left).offset(-15);
        
    }];
    
}

-(UIView *)BGView{
    if(_BGView == nil){
        _BGView = [[UIView alloc] init];
    }
    return _BGView;
}

-(UIImageView *)typeIcon{
    if(_typeIcon == nil){
        _typeIcon = [[UIImageView alloc] init];
        _typeIcon.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _typeIcon;
}
-(UILabel *)typeLabel{
    if(_typeLabel == nil){
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.numberOfLines = 0;
    }
    return _typeLabel;
}

-(UILabel *)valueLabel{
    if(_valueLabel == nil){
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.numberOfLines = 0;
    }
    return _valueLabel;
}
-(UIImageView *)moreIcon{
    if(_moreIcon == nil){
        _moreIcon = [[UIImageView alloc] init];
        _moreIcon.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _moreIcon;
}



-(void)upBGFrameWithInsets:(UIEdgeInsets )padding{
    [self.BGView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
    }];
}

-(void)updata:(NSString *)typeIcon type:(NSString *)type  value:(NSString *)value{
    self.typeIcon.image = [UIImage imageNamed:typeIcon];
    self.typeLabel.text = type;
    self.valueLabel.text = value;
    self.moreIcon.image = [UIImage imageNamed:@"more"];
}
@end
