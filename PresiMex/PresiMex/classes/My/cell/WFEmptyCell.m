//
//  WFEmptyCell.m
//  RVIHome
//
//  Created by shenWenFeng on 2023/4/13.
//

#import "WFEmptyCell.h"

@implementation WFEmptyCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *ID = @"WFEmptyCell";
    
    WFEmptyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WFEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
        make.height.equalTo(@(0.5));
    }];
}

-(UIView *)BGView{
    if(_BGView == nil){
        _BGView = [[UIView alloc] init];
        _BGView.backgroundColor = [UIColor clearColor];
        
    }
    return _BGView;
}
@end
