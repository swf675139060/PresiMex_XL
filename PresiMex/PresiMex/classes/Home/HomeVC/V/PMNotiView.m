//
//  PMNotiView.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/28.
//

#import "PMNotiView.h"

@interface PMNotiView()
@property(nonatomic, strong) UIButton * notBtn;

@end

@implementation PMNotiView

-(void)buildSubViews{
    [self addSubview:self.notBtn];
    self.backgroundColor = [UIColor jk_colorWithHexString:@"#FC7500"];
    [self.notBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.centerY.equalTo(self);
        
        make.right.equalTo(@(-15));
    }];
    
}

-(UIButton *)notBtn{
    if(_notBtn == nil){
        _notBtn = [UIButton new];
        [_notBtn setImage:[UIImage imageNamed:@"tongzhi"] forState:UIControlStateNormal];
        _notBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _notBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_notBtn setTitleColor:[UIColor jk_colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        _notBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        
    }
    return _notBtn;
}


-(void)setNotiContent:(NSString *)content{
    [self.notBtn setTitle:content forState:UIControlStateNormal];
}
@end
