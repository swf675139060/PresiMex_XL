//
//  WFLabelCell.m
//  RVIHome
//
//  Created by shenWenFeng on 2023/4/13.
//

#import "WFLabelCell.h"

@interface WFLabelCell()



@end

@implementation WFLabelCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *ID = @"WFLabelCell";
    
    WFLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WFLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell creatSubView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier{
    NSString *ID = @"WFLabelCell";
    if(identifier){
        ID = [NSString stringWithFormat:@"%@_%@",ID,identifier];
    }
    
    WFLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WFLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell creatSubView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


+(instancetype)cornerCellWithTableView:(UITableView *)tableView{
    NSString *ID = @"WFLabelCell_corner";
    
    WFLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WFLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell creatSubView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


-(void)creatSubView{
    [self.contentView addSubview:self.BGView];
    [self.BGView addSubview:self.label];
    [self.BGView addSubview:self.bottomLine];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
        
    }];
    
    
    UIEdgeInsets LBPadding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.BGView).with.insets(LBPadding);
        
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

-(UILabel *)label{
    if(_label == nil){
        _label = [[UILabel alloc] init];
        _label.numberOfLines = 0;
    }
    return _label;
}

-(UIView *)bottomLine{
    if(_bottomLine == nil){
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor jk_colorWithHexString:@"#DDDDDD"];
        _bottomLine.hidden = YES;
    }
    return _bottomLine;
}

-(void)upBGFrameWithInsets:(UIEdgeInsets )padding{
    [self.BGView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
    }];
}


-(void)upLabelFrameWithInsets:(UIEdgeInsets )padding{
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.BGView).with.insets(padding);
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

-(void)setLabelText:(NSString *)text{
    self.label.text = text;
}
@end
