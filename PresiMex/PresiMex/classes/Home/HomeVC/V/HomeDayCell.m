//
//  HomeDayCell.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/10.
//

#import "HomeDayCell.h"

@implementation HomeDayCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    NSString *ID = @"HomeDayCell";
    
    HomeDayCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HomeDayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell creatSubView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}



-(void)creatSubView{
    [self.contentView addSubview:self.BGView];
    
    [self.BGView addSubview:self.leftItem];
    [self.BGView addSubview:self.rightItem];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(15, 15, 35, 15);
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
        
    }];
    
    [self.leftItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.width.equalTo(@((WF_ScreenWidth - 30 - 22)/2));
        make.height.equalTo(@(55));
    }];
    
    [self.rightItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(0));
        make.top.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.width.equalTo(@((WF_ScreenWidth - 30 - 22)/2));
        make.height.equalTo(@(55));
    }];
    
    
}

-(UIView *)BGView{
    if(_BGView == nil){
        _BGView = [[UIView alloc] init];
    }
    return _BGView;
}

-(HomeDayCellItem *)leftItem{
    if(_leftItem == nil){
        _leftItem = [[HomeDayCellItem alloc] init];
    }
    return _leftItem;
}
-(HomeDayCellItem *)rightItem{
    if(_rightItem == nil){
        _rightItem = [[HomeDayCellItem alloc] init];
    }
    return _rightItem;
}



@end



@implementation HomeDayCellItem

-(void)buildSubViews{
    self.backgroundColor = BColor_Hex(@"#FFB602", 0.15);
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    [self addSubview:self.topLabel];
    [self addSubview:self.bottomLabel];
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(7.5));
        make.centerX.equalTo(@(0));
        make.left.right.equalTo(@(0));
        
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-7.5));
        make.centerX.equalTo(@(0));
        make.left.right.equalTo(@(0));
        
    }];
    
}

-(UILabel *)topLabel{
    if(_topLabel == nil){
        _topLabel = [[UILabel alloc] init];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        [_topLabel setText:@"1111" TextColor:BColor_Hex(@"#7C7C7C", 1) Font:[UIFont systemFontOfSize:11]];
    }
    return _topLabel;
}

-(UILabel *)bottomLabel{
    if(_bottomLabel == nil){
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        [_bottomLabel setText:@"22222" TextColor:BColor_Hex(@"#1B1200", 1) Font:[UIFont boldSystemFontOfSize:14]];
    }
    return _bottomLabel;
}

@end
