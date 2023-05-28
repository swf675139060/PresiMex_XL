//
//  WFLeftRightBtnCell.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/28.
//

#import "WFLeftRightBtnCell.h"

@implementation WFLeftRightBtnCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *ID = @"WFLeftRightBtnCell";
    
    WFLeftRightBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WFLeftRightBtnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        [cell makeView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}



-(void)makeView {
    
    [self.contentView addSubview:self.BGView];
    
    [self.BGView addSubview:self.leftBtn];
    
    [self.BGView addSubview:self.rightBtn];
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
        
    }];

    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(16));
        make.top.equalTo(@(1));
        make.bottom.equalTo(@(1));
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-16));
        make.top.equalTo(@(1));
        make.bottom.equalTo(@(1));
    }];
}

-(UIView *)BGView{
    if(_BGView == nil){
        _BGView = [[UIView alloc] init];
    }
    return _BGView;
}

-(UIButton *)leftBtn{
    if(_leftBtn == nil){
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _leftBtn;
}

-(UIButton *)rightBtn{
    if(_rightBtn == nil){
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _rightBtn;
}


-(void)upBGFrameWithInsets:(UIEdgeInsets )padding height:(CGFloat)height{
    [self.BGView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
        if(height){
            make.height.equalTo(@(height));
        }
    }];
}

-(void)upBtnsFrameWithEdgeInsets:(UIEdgeInsets )padding{
    [self.leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(padding.left));
        make.top.equalTo(@(padding.top));
        make.bottom.equalTo(@(-padding.bottom));

    }];
    
    [self.rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-padding.right));
        make.centerY.equalTo(self.leftBtn);

    }];
}

@end
