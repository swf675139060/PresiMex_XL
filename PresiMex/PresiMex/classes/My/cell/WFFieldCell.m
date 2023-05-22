//
//  HLRVIFieldCell.m
//  HuLuJianYi
//
//  Created by shenWenFeng on 2019/2/25.
//  Copyright © 2019年 yudeyuan. All rights reserved.
//

#import "WFFieldCell.h"

@interface WFFieldCell ()<UITextFieldDelegate>

/**backV**/
@property (strong, nonatomic) UIView * backView;


@property (assign, nonatomic) NSInteger maxLength;

@end


@implementation WFFieldCell



+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *ID = @"WFFieldCell";
    
    WFFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WFFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        [self makeView];
        
    }
    return self;
}

-(void)makeView {
    
    __weak typeof(self)weakSelf = self;
    
    self.backView = [[UIView alloc]init];
    [self.contentView addSubview:self.backView];
    UIEdgeInsets backvPadding = UIEdgeInsetsMake(0, 24, 0, 24);
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentView).with.insets(backvPadding);
    }];
    
    
    self.leftField = [[UITextField alloc]init];
    self.leftField.font = [UIFont systemFontOfSize:16];
    self.leftField.textAlignment = NSTextAlignmentLeft;
//    self.leftField.textColor = [UIColor colorWithHexString:@"#808080"];
    [self.leftField addTarget:self action:@selector(clickLeftField:) forControlEvents:UIControlEventEditingChanged];
    self.leftField.layer.cornerRadius = 12;
    self.leftField.layer.masksToBounds = YES;
    self.leftField.layer.borderWidth = 1;
    self.leftField.layer.borderColor = [UIColor whiteColor].CGColor;
    self.leftField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 1)];
    self.leftField.leftViewMode = UITextFieldViewModeAlways;
//    self.leftField.tintColor = [UIColor colorWithHexString:@"#C9FF43"];
    self.leftField.delegate = self;
//    self.leftField.enablesReturnKeyAutomatically = YES;

    [self.contentView addSubview:self.leftField];
    //设置距离父视图边界距离
    [self.leftField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.backView);
        make.height.equalTo(@(48));
    }];
    
}
#pragma -mark --UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(self.clickReturnBlock){
        self.clickReturnBlock();
    }
    
    return YES;
}


-(void)inputMaxLength:(NSInteger)max{
    self.maxLength = max;
}

-(void)clickLeftField:(UITextField *)textField{
    if (self.leftFieldBlock) {
        
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *pos = [textField positionFromPosition:selectedRange.start offset:0];
        //如果在变化中是高亮部分在变，就不要计算字符了
        if (selectedRange && pos) {
            return;
        }
        if (textField.text.length > self.maxLength &&  self.maxLength != 0){
            textField.text = [textField.text substringToIndex:self.maxLength];
        }
        self.leftFieldBlock(textField.text);
    }
}

-(void)becomeFirstResponder:(BOOL)firstResponder{
    if(firstResponder){
        if(self.leftField.isFirstResponder == NO){
            [self.leftField becomeFirstResponder];
        }
    }else{
        [self.leftField  resignFirstResponder];
    }
}
-(void)upBGFrameWithInsets:(UIEdgeInsets )padding{
    [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
        
    }];
    
}


-(void)upFieldFrameWithInsets:(UIEdgeInsets )padding height:(CGFloat)height{
    [self.leftField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
        make.height.equalTo(@(height));
    }];
}
@end
