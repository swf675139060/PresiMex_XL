//
//  WFBtnCell.m
//  HuLuJianYi
//
//  Created by shenWenFeng on 2019/1/9.
//

#import "WFBtnCell.h"

@implementation WFBtnCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *ID = @"WFBtnCell";
    
    WFBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WFBtnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeView];
    }
    return self;
}

-(void)makeView {
    
//    //点击按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:btn];
    self.btn = btn;

    //设置距离父视图边界距离
    UIEdgeInsets padding = UIEdgeInsetsMake(4, 24, 24, 24);
    __weak typeof(self)weakSelf = self;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentView).with.insets(padding);
    }];
}

-(void)updateFrameWithEdgeInsets:(UIEdgeInsets )padding{
    __weak typeof(self)weakSelf = self;
    [self.btn mas_updateConstraints:^(MASConstraintMaker *make) {

        make.edges.equalTo(weakSelf.contentView).with.insets(padding);
        

    }];
}

@end
