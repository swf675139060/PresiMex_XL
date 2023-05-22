//
//  WFTextViewCell.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/21.
//

#import "WFTextViewCell.h"

@implementation WFTextViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *ID = @"WFTextViewCell";
    
    WFTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WFTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell creatSubView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


-(void)creatSubView{
    [self.contentView addSubview:self.BGView];
    
    [self.BGView addSubview:self.textView];
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
        
    }];
    
    
    UIEdgeInsets LBPadding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.BGView).with.insets(LBPadding);
        make.height.equalTo(@(150));
        
    }];
    
}

-(UIView *)BGView{
    if(_BGView == nil){
        _BGView = [[UIView alloc] init];
    }
    return _BGView;
}

-(SLFPlaceHolderTextView *)textView{
    if(_textView == nil){
        _textView = [SLFPlaceHolderTextView textView];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.textColor = [UIColor jk_colorWithHexString:@"#333333"];
//        _textView.textContainerInset = UIEdgeInsetsMake(14.5, 16.5, 14.5, 16.5);
        
    }
    return _textView;
}



-(void)upBGFrameWithInsets:(UIEdgeInsets )padding{
    [self.BGView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
    }];
}


-(void)upTextViewFrameWithInsets:(UIEdgeInsets )padding height:(CGFloat)height{
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.BGView).with.insets(padding);
        make.height.equalTo(@(height));
    }];
}

-(void)setTextViewText:(NSString *)text{
    self.textView.text = text;
}
@end
