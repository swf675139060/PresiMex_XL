//
//  PMBankVerCodeCell.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/23.
//

#import "PMBankVerCodeCell.h"

#import "PMTextField.h"
#import "BasicDataModel.h"

@interface PMBankVerCodeCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) PMTextField *contentTF;
@property (nonatomic, strong) PMQuestionModel*model;
@end

@implementation PMBankVerCodeCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"PMBankVerCodeCell";
    
    PMBankVerCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PMBankVerCodeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
-(void)setupSubViews{
    
    _titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_titleLabel];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.textColor =BColor_Hex(@"#1B1200",1);
    _titleLabel.numberOfLines=0;
    _titleLabel.frame=CGRectMake(15, 15, WF_ScreenWidth-30, 20);
    
    UIView *bgView=[UIView new];
    [self.contentView addSubview:bgView];
    bgView.layer.borderColor=BColor_Hex(@"#CCCCCC", 0.5).CGColor;
    bgView.layer.borderWidth=0.5;
    bgView.layer.cornerRadius=22.5;
    bgView.frame=CGRectMake(15,_titleLabel.swf_bottom+10, WF_ScreenWidth-30 - 110, 45);
    _bgView=bgView;
    
    _contentTF = [[PMTextField alloc] init];
    [bgView addSubview:_contentTF];
    _contentTF.font = [UIFont systemFontOfSize:14];
    _contentTF.textColor =BColor_Hex(@"#333333",1);
    _contentTF.textAlignment = NSTextAlignmentLeft;
    _contentTF.frame=CGRectMake(20, 1,WF_ScreenWidth- 30 - 20 - 110 -20, 43);
    weakify(self)
    _contentTF.endEditingHandler = ^(NSString * _Nonnull text) {
        strongify(self)
        if (self.endInputBlock) {
            self.endInputBlock(self.titleLabel.text, text);
        }
    };
    
    _btn = [[UIButton alloc] initWithFrame:CGRectMake(WF_ScreenWidth -110, _titleLabel.swf_bottom+10, 95, 44)];
    [_btn setText:@"" TextColor:BColor_Hex(@"#FFFFFF", 1) Font:[UIFont systemFontOfSize:12] forState:UIControlStateNormal];
    [_btn addLinearGradientwithSize:CGSizeMake(95, 44) maskedCorners: kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:22];
    [_btn addTarget:self action:@selector(clickSendBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_btn];
    
    

}

-(void)clickSendBtn{
    if (self.clickSendBlock) {
        self.clickSendBlock();
    }
}

-(void)setCellWithModel:(PMQuestionModel*)model btnTitle:(NSString *)btnTitle {
    _model=model;
    _titleLabel.text=model.title;
    if (model.isHave) {
        _contentTF.userInteractionEnabled = NO;
        if (model.indx >= 0) {
            BasicDataModel *  DataModel = model.contentArr[model.indx];
            _contentTF.text = DataModel.title;
        }else if (model.content && model.content.length){
            _contentTF.text =model.content;
        }else{
            _contentTF.text = @"";
        }
    } else {
        _contentTF.text=model.content;
        _contentTF.userInteractionEnabled = YES;
    }
    
    [self.btn setTitle:btnTitle forState:UIControlStateNormal];
   
   
}

// 按钮是否是数字的背景
-(void)setBtnBGType:(BOOL)number{
    
    if (number) {
        [self.btn deletaLinearGradient];
        self.btn.layer.cornerRadius = 22;
        self.btn.layer.masksToBounds = YES;
        self.btn.layer.borderWidth = 0.5;
        self.btn.layer.borderColor = BColor_Hex(@"#CCCCCC", 1).CGColor;
        [self.btn setTitleColor:BColor_Hex(@"#7C7C7C", 1) forState:UIControlStateNormal];
    } else {
        
        [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btn addLinearGradientwithSize:CGSizeMake(95, 44) maskedCorners: kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:22];
    }
}

@end
