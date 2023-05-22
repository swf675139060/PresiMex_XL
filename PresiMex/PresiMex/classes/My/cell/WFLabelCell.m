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


-(void)creatSubView{
    [self.contentView addSubview:self.BGView];
    
    [self.BGView addSubview:self.label];
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
        
    }];
    
    
    UIEdgeInsets LBPadding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.BGView).with.insets(LBPadding);
        
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

-(void)setLabelText:(NSString *)text{
    self.label.text = text;
}
@end
