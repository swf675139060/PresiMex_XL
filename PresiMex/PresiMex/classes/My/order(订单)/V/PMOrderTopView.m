//
//  PMOrderTopView.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/28.
//

#import "PMOrderTopView.h"

@interface PMOrderTopView()

@property(strong, nonatomic) UIButton * leftBtn;

@property(strong, nonatomic) UIButton * rightBtn;

@end

@implementation PMOrderTopView


-(void)buildSubViews{
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.top.equalTo(@(15.5));
        make.height.equalTo(@(44));
        make.width.equalTo(@(WF_ScreenWidth - 30 -20));
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.right.equalTo(@(-15.5));
        make.height.equalTo(@(44));
        make.width.equalTo(@(WF_ScreenWidth - 30 -20));
    }];
    
}

-(UIButton *)leftBtn{
    if(_leftBtn == nil){
        _leftBtn = [[UIButton alloc] init];
        [_leftBtn jk_cornerRadius:5 strokeSize:0.5 color:[UIColor jk_colorWithHexString:@"#FC7500"]];
        [_leftBtn setTitleColor:[UIColor jk_colorWithHexString:@"#FC7500"] forState:UIControlStateNormal];
        [_leftBtn setTitle:@"Órdenes en proceso" forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_leftBtn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

-(UIButton *)rightBtn{
    if(_rightBtn == nil){
        _rightBtn = [[UIButton alloc] init];
        [_rightBtn jk_cornerRadius:5 strokeSize:0.5 color:[UIColor jk_colorWithHexString:@"#FC7500"]];
        [_rightBtn setTitleColor:[UIColor jk_colorWithHexString:@"#FC7500"] forState:UIControlStateNormal];
        [_rightBtn setTitle:@"Órdenes completadas" forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_rightBtn addTarget:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

-(void)clickLeftBtn{
    if(self.clickLeftBtnBlock){
        self.clickLeftBtnBlock();
    }
    
}
-(void)clickRightBtn{
    if(self.clickRightBtnBlock){
        self.clickRightBtnBlock();
    }
}




@end
