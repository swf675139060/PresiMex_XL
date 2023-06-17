//
//  WFTopBtnBottomTwoLabelCell.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/10.
//

#import "WFTopBtnBottomTwoLabelCell.h"

@implementation WFTopBtnBottomTwoLabelCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *ID = @"WFTopBtnBottomTwoLabelCell";
    
    WFTopBtnBottomTwoLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WFTopBtnBottomTwoLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell creatSubView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier{
    NSString *ID = @"WFTopBtnBottomTwoLabelCell";
    if(identifier){
        ID = [NSString stringWithFormat:@"%@_%@",ID,identifier];
    }
    
    WFTopBtnBottomTwoLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WFTopBtnBottomTwoLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell creatSubView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


-(void)creatSubView{
    [self.contentView addSubview:self.BGView];
    
    [self.contentView addSubview:self.btn];
    [self.BGView addSubview:self.label1];
    [self.BGView addSubview:self.label2];
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
        
    }];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(padding.top);
        make.left.equalTo(self.contentView).offset(padding.left);
        make.right.equalTo(self.contentView).offset(-padding.right);
        make.height.equalTo(@(10));
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.BGView);
        
    }];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.BGView);
        make.top.equalTo(self.label1.mas_bottom).offset(10);
        make.height.equalTo(@(300));
    }];
    
}

-(UIView *)BGView{
    if(_BGView == nil){
        _BGView = [[UIView alloc] init];
    }
    return _BGView;
}
-(UIButton *)btn{
    if(_btn == nil){
        _btn = [[UIButton alloc]init];
//        _btn.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _btn;
}
-(UILabel *)label1{
    if(_label1 == nil){
        _label1 = [[UILabel alloc] init];
        _label1.numberOfLines = 0;
    }
    return _label1;
}

-(WKWebView *)label2{
    if(_label2 == nil){
        _label2 = [[WKWebView alloc] init];
        _label2.scrollView.scrollEnabled = NO;
        [_label2.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return _label2;
}
#pragma mark  - KVO回调
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    CGFloat newHeight = _label2.scrollView.contentSize.height + 30;
    
    if(self.label2.jk_height < newHeight){
        [self.label2 mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.BGView).offset(13);
            make.right.equalTo(self.BGView).offset(-13);
            make.bottom.equalTo(self.BGView).offset(-21);
            make.top.equalTo(self.label1.mas_bottom).offset(14);
            make.height.equalTo(@(newHeight));
        }];
    }
}


-(void)upBGFrameWithInsets:(UIEdgeInsets )padding{
    [self.BGView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
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

-(void)upBtnFrameWithEdgeInsets:(UIEdgeInsets )padding height:(CGFloat)height{

    [self.btn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(padding.top);
        make.left.equalTo(self.contentView).offset(padding.left);
        make.right.equalTo(self.contentView).offset(-padding.right);
        if (height) {
            make.height.equalTo(@(height));
        }
       
 
    }];
}

-(void)upLabelFrameWithInsets:(UIEdgeInsets )padding spacing:(CGFloat)spacing{
   
    [self.label1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn.mas_bottom).offset(padding.top);
        make.left.equalTo(self.BGView).offset(padding.left);
        make.right.equalTo(self.BGView).offset(-padding.right);
        
    }];
    
}



-(void)dealloc{
    [self.label2.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

@end
