//
//  WFThreeBtnCell.m
//  RVIHome
//
//  Created by shenWenFeng on 2023/4/13.
//

#import "WFThreeBtnCell.h"

@implementation WFThreeBtnCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *ID = @"WFThreeBtnCell";
    
    WFThreeBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WFThreeBtnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell creatSubView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


-(void)creatSubView{
    [self.contentView addSubview:self.BGView];
    
    [self.BGView addSubview:self.leftBtn];
    [self.BGView addSubview:self.centerBtn];
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
    
  
    
    
    [self.centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(0));
        make.centerY.equalTo(self.leftBtn);

    }];
    
}



-(UIView *)BGView{
    if(_BGView == nil){
        _BGView = [[UIView alloc] init];
    }
    return _BGView;
}

-(UIButton *)leftBtn{
    if (_leftBtn == nil) {
        _leftBtn = [[UIButton alloc] init];
        _leftBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _leftBtn.tag = 0;
        [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_leftBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        
    }
    return _leftBtn;
    
}

-(UIButton *)centerBtn{
    if (_centerBtn == nil) {
        _centerBtn = [[UIButton alloc] init];
        _centerBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _centerBtn.tag = 1;
        [_centerBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _centerBtn;
    
}

-(UIButton *)rightBtn{
    if (_rightBtn == nil) {
        _rightBtn = [[UIButton alloc] init];
        _rightBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _rightBtn.tag = 2;
        [_rightBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    }
    return _rightBtn;
    
}

//点击按钮
-(void)clickBtn:(UIButton *)btn{
    if(self.clickBtnBlock){
        self.clickBtnBlock(btn.tag);
    }
}

-(void)upBGFrameWithInsets:(UIEdgeInsets )padding height:(CGFloat)height{
    [self.BGView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
        make.height.equalTo(@(height));
    }];
}

-(void)updataLeftStr:(NSString *)leftStr centerStr:(NSString *)centerStr rightStr:(NSString *)rightStr{
    [self.leftBtn setTitle:leftStr forState:UIControlStateNormal];
    [self.centerBtn setTitle:centerStr forState:UIControlStateNormal];
    [self.rightBtn setTitle:rightStr forState:UIControlStateNormal];
}

-(void)upBtnsFrameWithInsets:(UIEdgeInsets )padding{
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
