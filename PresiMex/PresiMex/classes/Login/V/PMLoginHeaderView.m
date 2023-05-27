//
//  PMLoginHeaderView.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/27.
//


#import "PMLoginHeaderView.h"
#import "CRBoxInputView.h"
@interface PMLoginHeaderView()

@property(strong, nonatomic) UIView * topBgView;

@property(strong, nonatomic) UIImageView * logoIcon;

@end

@implementation PMLoginHeaderView

-(void)buildSubViews{
    
    [self addSubview:self.topBgView];
    
    UIButton* button = [[UIButton alloc]init];
    button.titleLabel.font = B_FONT_REGULAR(16);
    [button addTarget:self action:@selector(leftItemAction) forControlEvents:(UIControlEventTouchUpInside)];
    button.frame = CGRectMake(15, WF_StatusBarHeight+7, 32, 32);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeading;
    [button setImage:[UIImage imageNamed: @"back_Icon"] forState:(UIControlStateNormal)];
    [self.topBgView addSubview:button];
    
    [self.topBgView addSubview:self.logoIcon];
    _logoIcon.frame=CGRectMake((WF_ScreenWidth-76)/2,button.slf_bottom+10, 76, 76);
    
//    CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
//    cellProperty.cellBgColorNormal = [UIColor whiteColor];
//    cellProperty.cellBgColorSelected = [UIColor whiteColor];
//    cellProperty.cellCursorColor = BColor_Hex(@"#FF3B30", 1);
//    cellProperty.cellCursorWidth = 2;
//    cellProperty.cellCursorHeight = 30;
//    cellProperty.cornerRadius = 0;
//    cellProperty.borderWidth = 1;
//    cellProperty.cellBorderColorNormal =BColor_Hex(@"#BABAC3", 1);
//    cellProperty.cellBorderColorSelected =BColor_Hex(@"#FF3B30", 1);
//    cellProperty.cellFont = [UIFont boldSystemFontOfSize:33];
//    cellProperty.cellTextColor = [UIColor blackColor];
//
//    CRBoxInputView *boxInputView = [[CRBoxInputView alloc] initWithCodeLength:4];
//    boxInputView.boxFlowLayout.itemSize = CGSizeMake(60, 60);
//    boxInputView.inputType = CRInputType_Number;
//    boxInputView.customCellProperty = cellProperty;
//    [boxInputView loadAndPrepareViewWithBeginEdit:YES];
//    [self addSubview:boxInputView];
//    [boxInputView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(20);
//        make.top.equalTo(_logoIcon.mas_bottom).offset(34);
//        make.width.equalTo(@(WF_ScreenWidth - 40));
//        make.height.equalTo(@60);
//    }];
    CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
    cellProperty.cellBgColorNormal = BColor_Hex(@"#FFA402", 0.1);
    cellProperty.cellBgColorSelected = BColor_Hex(@"#FFA402", 0.3);
    cellProperty.cellCursorColor = BColor_Hex(@"#1B1200", 1);
    cellProperty.cellCursorWidth = 2;
    cellProperty.cellCursorHeight = 30;
    cellProperty.cornerRadius = 4;
    cellProperty.borderWidth = 0;
    cellProperty.cellFont = [UIFont boldSystemFontOfSize:24];
    cellProperty.cellTextColor = BColor_Hex(@"#1B1200", 1);
    cellProperty.configCellShadowBlock = ^(CALayer * _Nonnull layer) {
        layer.shadowColor = BColor_Hex(@"#FFA402", 0.2).CGColor;
        layer.shadowOpacity = 1;
        layer.shadowOffset = CGSizeMake(4, 4);
        layer.shadowRadius = 4;
    };

    CRBoxInputView *boxInputView = [[CRBoxInputView alloc] initWithCodeLength:4];
    boxInputView.boxFlowLayout.itemSize = CGSizeMake(50, 50);
    boxInputView.customCellProperty = cellProperty;
    [boxInputView loadAndPrepareViewWithBeginEdit:YES];
    [self addSubview:boxInputView];
    [boxInputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(20);
            make.top.equalTo(_logoIcon.mas_bottom).offset(34);
            make.width.equalTo(@(WF_ScreenWidth - 40));
            make.height.equalTo(@60);
    }];
}
-(void)setSubViewsPosition{
//    [self.topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self);
//        make.bottom.equalTo(self).offset(40);
//    }];
//    [self.logoIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(15);
//        make.top.equalTo(self).offset(WF_StatusBarHeight + 20);
//        make.width.height.equalTo(@(50));
//    }];
}

-(UIView *)topBgView{
    if(_topBgView == nil){
        _topBgView = [UIView new];
        _topBgView.frame=CGRectMake(0, 0, WF_ScreenWidth, WF_StatusBarHeight+260);
        NSArray *colors = @[(id)[UIColor jk_colorWithHexString:@"#FFB602"].CGColor, (id)[UIColor jk_colorWithHexString:@"#FC7500"].CGColor];
        [self.topBgView addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth, self.jk_height - 40) withColors:colors startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0) maskedCorners:kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:50];
        
       
    }
    return _topBgView;
}

-(UIImageView *)logoIcon{
    if(_logoIcon == nil){
        _logoIcon = [UIImageView new];
        _logoIcon.layer.cornerRadius =38;
        _logoIcon.layer.masksToBounds = YES;
        _logoIcon.image = DefaultAvatar;
        
       
    }
    return _logoIcon;
}
-(void)leftItemAction{
    [self.viewController.navigationController popViewControllerAnimated:YES];
}
@end
