//
//  WFLeftTBLbaelRightBtnCell.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/6.
//

#import "WFLeftTBLbaelRightBtnCell.h"

@implementation WFLeftTBLbaelRightBtnCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    return [WFLeftTBLbaelRightBtnCell cellWithTableView:tableView identifier:@""];
}

+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier{
    NSString * ID = @"WFLeftTBLbaelRightBtnCell";
    if (identifier && identifier.length) {
        ID = [NSString stringWithFormat:@"WFLeftTBLbaelRightBtnCell_%@",identifier];
    }
    
    WFLeftTBLbaelRightBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WFLeftTBLbaelRightBtnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell creatSubView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}



-(void)creatSubView{
    [self.contentView addSubview:self.BGView];
    
    [self.BGView addSubview:self.btn];
    [self.BGView addSubview:self.topLabel];
    [self.BGView addSubview:self.bottomLabel];
    [self.BGView addSubview:self.bottomLine];
    
    
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
        
    }];
    
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.height.equalTo(@(0.5));
    }];
//    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@(0));
//        make.top.equalTo(@(0));
//        make.bottom.equalTo(@(0));
//
//        make.height.equalTo(@(50));
//
//
//    }];
    
//    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.imageV.mas_right).offset(10);
//        make.top.equalTo(self.imageV).offset(padding.top);
//        make.right.equalTo(@(-padding.right));
//    }];
//
//    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.imageV.mas_right).offset(10);
//        make.bottom.equalTo(self.imageV).offset(-padding.bottom);
//        make.right.equalTo(@(-padding.right));
//    }];
    
    
    
    
    
    
}

-(UIView *)BGView{
    if(_BGView == nil){
        _BGView = [[UIView alloc] init];
    }
    return _BGView;
}


-(UIButton *)btn{
    if(_btn== nil){
        _btn = [[UIButton alloc]init];
        [_btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

-(UILabel *)topLabel{
    if(_topLabel == nil){
        _topLabel = [[UILabel alloc] init];
        _topLabel.numberOfLines = 0;
    }
    return _topLabel;
}
-(UILabel *)bottomLabel{
    if(_bottomLabel == nil){
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.numberOfLines = 0;
    }
    return _bottomLabel;
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
    
    [self.BGView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
       
    }];
}

-(void)upBtnFrameWithInsets:(UIEdgeInsets )padding size:(CGSize)size{
    [self.btn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-padding.right));
        make.top.equalTo(@(padding.top));
//        make.bottom.equalTo(@(-padding.bottom));
        if (size.width) {
            make.size.equalTo(@(size));
        }

    }];
}

-(void)upLabelsFrameWithInsets:(UIEdgeInsets )padding centerSpac:(CGFloat)spac{
    
    [self.topLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.BGView).offset(padding.left);
        make.top.equalTo(self.BGView).offset(padding.top);
        make.right.equalTo(self.btn.mas_left).offset(-padding.right);
    }];
    
    [self.bottomLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.BGView).offset(padding.left);
        make.bottom.equalTo(self.BGView).offset(-padding.bottom);
        make.right.equalTo(self.btn.mas_left).offset(-padding.right);
        make.top.equalTo(self.topLabel.mas_bottom).offset(padding.top);
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


-(void)clickBtn{
    if(self.clickbtnBlock){
        self.clickbtnBlock(self.btn);
    }
}
@end
