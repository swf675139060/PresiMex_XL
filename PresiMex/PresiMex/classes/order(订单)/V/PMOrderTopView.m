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


@property(assign, nonatomic) NSInteger indx;

@end

@implementation PMOrderTopView


-(void)buildSubViews{
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.top.equalTo(@(15.5));
        make.height.equalTo(@(44));
        make.width.equalTo(@((WF_ScreenWidth - 30 -20)/2));
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.top.equalTo(@(15.5));
        make.height.equalTo(@(44));
        make.width.equalTo(@((WF_ScreenWidth - 30 -20)/2));
    }];
    
}

-(void)setDetails:(BOOL)details{
    _details = details;
    [_leftBtn setTitle:@"Pago completo" forState:UIControlStateNormal];
    [_rightBtn setTitle:@"Pago de prórroga" forState:UIControlStateNormal];
    
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
    if(self.indx != 0){
        
        [self selectIndx:0];
        if(self.clickLeftBtnBlock){
            self.clickLeftBtnBlock();
        }
    }
    
}
-(void)clickRightBtn{
    if(self.indx != 1){
        
        if(self.clickRightBtnBlock){
            self.clickRightBtnBlock();
        }
        
        [self selectIndx:1];
    }
}


-(void)selectIndx:(NSInteger)indx{
    self.indx = indx;
    if(indx == 0){
        [self.leftBtn jk_cornerRadius:5 strokeSize:0.5 color:[UIColor jk_colorWithHexString:@"#FC7500"]];
        [self.leftBtn setTitleColor:[UIColor jk_colorWithHexString:@"#FC7500"] forState:UIControlStateNormal];
        
        [self.rightBtn jk_cornerRadius:5 strokeSize:0.5 color:[UIColor jk_colorWithHexString:@"#7C7C7C"]];
        [self.rightBtn setTitleColor:[UIColor jk_colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        
        
    }else{
        [self.leftBtn jk_cornerRadius:5 strokeSize:0.5 color:[UIColor jk_colorWithHexString:@"#7C7C7C"]];
        [self.leftBtn setTitleColor:[UIColor jk_colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        
        
        [self.rightBtn jk_cornerRadius:5 strokeSize:0.5 color:[UIColor jk_colorWithHexString:@"#FC7500"]];
        [self.rightBtn setTitleColor:[UIColor jk_colorWithHexString:@"#FC7500"] forState:UIControlStateNormal];
    }
}



@end
