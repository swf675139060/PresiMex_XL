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
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
    self.btn = btn;

    //设置距离父视图边界距离
    UIEdgeInsets padding = UIEdgeInsetsMake(4, 24, 24, 24);
    __weak typeof(self)weakSelf = self;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentView).with.insets(padding);
    }];
}

-(void)updateFrameWithEdgeInsets:(UIEdgeInsets )padding height:(CGFloat)height{
    __weak typeof(self)weakSelf = self;
    [self.btn mas_remakeConstraints:^(MASConstraintMaker *make) {

        make.edges.equalTo(weakSelf.contentView).with.insets(padding);
        
        make.height.equalTo(@(height));

    }];
}

-(void)clickBtn{
    if(self.clickBtnBlock){
        self.clickBtnBlock();
    }
}

@end
