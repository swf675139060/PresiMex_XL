//
//  WFLeftRightLabelCell.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/31.
//

#import "WFLeftRightLabelCell.h"

@implementation WFLeftRightLabelCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    return [WFLeftRightLabelCell cellWithTableView:tableView identifier:@""];
}

+(instancetype)bottomLineCellWithTableView:(UITableView *)tableView{
    return [WFLeftRightLabelCell cellWithTableView:tableView identifier:@"bottomLine"];
}

+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier{
    NSString * ID = @"WFLeftRightLabelCell";
    if (identifier && identifier.length) {
        ID = [NSString stringWithFormat:@"WFLeftRightLabelCell_%@",identifier];
    }
    
    WFLeftRightLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WFLeftRightLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell creatSubView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


+(instancetype)cornerCellWithTableView:(UITableView *)tableView{
    NSString *ID = @"WFLeftRightLabelCell_corner";
    
    WFLeftRightLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WFLeftRightLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell creatSubView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


-(void)creatSubView{
    [self.contentView addSubview:self.BGView];
    
    [self.BGView addSubview:self.leftLabel];
    [self.BGView addSubview:self.rightLabel];
    [self.BGView addSubview:self.bottomLine];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
        
    }];
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(16));
        make.top.equalTo(@(1));
        make.bottom.equalTo(@(1));
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-16));
        make.top.equalTo(@(1));
        make.bottom.equalTo(@(1));
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(@(0));
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

-(UILabel *)leftLabel{
    if(_leftLabel == nil){
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.numberOfLines = 0;
    }
    return _leftLabel;
}
-(UILabel *)rightLabel{
    if(_rightLabel == nil){
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.numberOfLines = 0;
    }
    return _rightLabel;
}

-(UIView *)bottomLine{
    if(_bottomLine == nil){
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor jk_colorWithHexString:@"#DDDDDD"];
        _bottomLine.hidden = YES;
    }
    return _bottomLine;
}



-(void)upBGFrameWithInsets:(UIEdgeInsets )padding height:(CGFloat)height{
    
    [self.BGView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
        if(height){
            make.height.equalTo(@(height));
        }
    }];
}


-(void)upLabelFrameWithInsets:(UIEdgeInsets )padding{
    
    [self.leftLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(padding.left));
        make.top.equalTo(@(padding.top));
        make.bottom.equalTo(@(-padding.bottom));

    }];
    
    [self.rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-padding.right));
        make.centerY.equalTo(self.leftLabel);

    }];
}

-(void)upBGFrameWithInsets:(UIEdgeInsets )padding maskedCorners:(CACornerMask)maskedCorners cornerRadius:(CGFloat)cornerRadius{
    self.BGView.layer.maskedCorners = maskedCorners;
    self.BGView.layer.masksToBounds = YES;
    self.BGView.layer.cornerRadius = cornerRadius;
    
    [self.BGView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
        
    }];
}


-(void)upLineFrameWithInsets:(UIEdgeInsets )padding{
    [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(padding.left));
        make.right.equalTo(@(-padding.right));
        make.bottom.equalTo(@(-padding.bottom));
        make.height.equalTo(@(0.5));
    }];
}




@end
