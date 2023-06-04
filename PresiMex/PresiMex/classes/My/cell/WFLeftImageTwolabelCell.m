//
//  WFLeftImageTwolabelCell.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/3.
//

#import "WFLeftImageTwolabelCell.h"

@implementation WFLeftImageTwolabelCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    return [WFLeftImageTwolabelCell cellWithTableView:tableView identifier:@""];
}

+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier{
    NSString * ID = @"WFLeftImageTwolabelCell";
    if (identifier && identifier.length) {
        ID = [NSString stringWithFormat:@"WFLeftImageTwolabelCell_%@",identifier];
    }
    
    WFLeftImageTwolabelCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WFLeftImageTwolabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell creatSubView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}



-(void)creatSubView{
    [self.contentView addSubview:self.BGView];
    
    [self.BGView addSubview:self.imageV];
    [self.BGView addSubview:self.topLabel];
    [self.BGView addSubview:self.bottomLabel];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
        
    }];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(0));
        make.bottom.equalTo(@(0));
      
        make.height.equalTo(@(50));
        

    }];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageV.mas_right).offset(10);
        make.top.equalTo(self.imageV).offset(padding.top);
        make.right.equalTo(@(-padding.right));
    }];
  
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageV.mas_right).offset(10);
        make.bottom.equalTo(self.imageV).offset(-padding.bottom);
        make.right.equalTo(@(-padding.right));
    }];
    
    
    
    
    
    
}

-(UIView *)BGView{
    if(_BGView == nil){
        _BGView = [[UIView alloc] init];
    }
    return _BGView;
}


-(UIImageView *)imageV{
    if(_imageV== nil){
        _imageV = [[UIImageView alloc]init];
        _imageV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageV;
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




-(void)upBGFrameWithInsets:(UIEdgeInsets )padding{
    
    [self.BGView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
       
    }];
}

-(void)upImageFrameWithInsets:(UIEdgeInsets )padding height:(CGFloat)height{
    [self.imageV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(padding.left));
        make.top.equalTo(@(padding.top));
        make.bottom.equalTo(@(-padding.bottom));
        if (height) {
            make.height.equalTo(@(height));
        }

    }];
}

-(void)upLabelsFrameWithInsets:(UIEdgeInsets )padding{
    
    [self.topLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageV.mas_right).offset(padding.left);
        make.top.equalTo(self.imageV).offset(padding.top);
        make.right.equalTo(@(-padding.right));
    }];
    
    [self.bottomLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageV.mas_right).offset(padding.left);
        make.bottom.equalTo(self.imageV).offset(-padding.bottom);
        make.right.equalTo(@(-padding.right));
    }];
}


@end
