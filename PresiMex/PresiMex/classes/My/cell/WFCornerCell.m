//
//  WFCornerCell.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/27.
//

#import "WFCornerCell.h"

@implementation WFCornerCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *ID = @"WFCornerCell";
    
    WFCornerCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WFCornerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell creatSubView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


-(void)creatSubView{
    [self.contentView addSubview:self.BGView];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
        make.height.equalTo(@(10));
        
    }];
    
    
    
}

-(UIView *)BGView{
    if(_BGView == nil){
        _BGView = [[UIView alloc] init];
    }
    return _BGView;
}





-(void)upBGFrameWithInsets:(UIEdgeInsets )padding height:(CGFloat)height maskedCorners:(CACornerMask)maskedCorners cornerRadius:(CGFloat )cornerRadius{
    self.BGView.layer.maskedCorners = maskedCorners;
    self.BGView.layer.masksToBounds = YES;
    self.BGView.layer.cornerRadius = cornerRadius;
    
    [self.BGView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
        make.height.equalTo(@(height));
    }];
}


@end
