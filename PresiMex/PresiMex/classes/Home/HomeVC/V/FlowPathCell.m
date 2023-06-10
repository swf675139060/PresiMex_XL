//
//  FlowPathCell.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/10.
//

#import "FlowPathCell.h"

@implementation FlowPathCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *ID = @"FlowPathCell";
    
    FlowPathCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FlowPathCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    [self.BGView addSubview:self.centerV1];
    [self.BGView addSubview:self.centerV2];

    
    
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
    }];
    
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(13));
        make.bottom.equalTo(@(13));
        make.height.equalTo(@(63));
        make.width.equalTo(@(110));
        make.centerX.equalTo(self.BGView.mas_left).offset(52.5);
    }];
    
    [self.centerV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftBtn.mas_right).offset(20);
        make.right.equalTo(self.centerBtn.mas_left).offset(-20);
        make.top.equalTo(@(16));
        make.height.equalTo(@(7.8));
    }];
    
    
    [self.centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(13));
        make.bottom.equalTo(@(13));
        make.centerX.equalTo(@(0));
        make.height.equalTo(@(63));
        make.width.equalTo(@(110));
    }];
    
    [self.centerV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.centerBtn.mas_right).offset(20);
        make.right.equalTo(self.rightBtn.mas_left).offset(-20);
        make.top.equalTo(@(16));
        make.height.equalTo(@(7.8));
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(13));
        make.bottom.equalTo(@(13));
        make.height.equalTo(@(63));
        make.centerX.equalTo(self.BGView.mas_right).offset(-52.5);
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
        _leftBtn.tag = 0;
        [_leftBtn setImage:[UIImage imageNamed:@"zhuce"] forState:UIControlStateNormal];
        [_leftBtn setText:@"Registro" TextColor:BColor_Hex(@"#7C7C7C", 1) Font:[UIFont systemFontOfSize:10] forState:UIControlStateNormal];
        [_leftBtn jk_setImagePosition:LXMImagePositionTop spacing:10];

    }
    return _leftBtn;
    
}

-(UIButton *)centerBtn{
    if (_centerBtn == nil) {
        _centerBtn = [[UIButton alloc] init];
        [_centerBtn setImage:[UIImage imageNamed:@"zhuce1"] forState:UIControlStateNormal];
        [_centerBtn setText:@"Autenticación" TextColor:BColor_Hex(@"#7C7C7C", 1) Font:[UIFont systemFontOfSize:10] forState:UIControlStateNormal];
        [_centerBtn jk_setImagePosition:LXMImagePositionTop spacing:10];
//        _centerBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _centerBtn.tag = 1;
        
    }
    return _centerBtn;
    
}

-(UIButton *)rightBtn{
    if (_rightBtn == nil) {
        _rightBtn = [[UIButton alloc] init];
        [_rightBtn setImage:[UIImage imageNamed:@"zhuce2"] forState:UIControlStateNormal];
        [_rightBtn setText:@"Conseguir un préstamo" TextColor:BColor_Hex(@"#7C7C7C", 1) Font:[UIFont systemFontOfSize:10] forState:UIControlStateNormal];
        [_rightBtn jk_setImagePosition:LXMImagePositionTop spacing:10];
        _rightBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _rightBtn.tag = 2;
//        [_rightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    }
    return _rightBtn;
    
}

-(UIImageView *)centerV1{
    if (_centerV1 == nil) {
        _centerV1 = [[UIImageView alloc] init];
        _centerV1.image = [UIImage imageNamed:@"fankui"];
        _centerV1.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _centerV1;
}

-(UIImageView *)centerV2{
    if (_centerV2 == nil) {
        _centerV2 = [[UIImageView alloc] init];
        _centerV2.image = [UIImage imageNamed:@"fankui"];
        _centerV2.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _centerV2;
}


@end
