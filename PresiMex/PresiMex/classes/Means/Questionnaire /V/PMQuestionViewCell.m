//
//  PMQuestionViewCell.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/30.
//

#import "PMQuestionViewCell.h"



@interface PMQuestionViewCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UITextField *contentTF;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation PMQuestionViewCell

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
    static NSString *ID = @"PMQuestionViewCell";
    
    PMQuestionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PMQuestionViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    bgView.frame=CGRectMake(15,_titleLabel.swf_bottom+10, WF_ScreenWidth-30, 45);
    _bgView=bgView;
    
    _contentTF = [[UITextField alloc] init];
    [bgView addSubview:_contentTF];
    _contentTF.font = [UIFont systemFontOfSize:14];
    _contentTF.textColor =BColor_Hex(@"#333333",1);
    _contentTF.textAlignment = NSTextAlignmentLeft;
    _contentTF.frame=CGRectMake(20, 1,WF_ScreenWidth-30-20-39, 43);
    _contentTF.delegate=self;
    
    UIImageView*arrowImageView = [[UIImageView alloc] init];
    arrowImageView.contentMode=UIViewContentModeScaleAspectFit;
    [bgView addSubview:arrowImageView];
    arrowImageView.frame=CGRectMake(WF_ScreenWidth-30-14-15,18.5, 14,8);
    arrowImageView.backgroundColor=[UIColor whiteColor];
    arrowImageView.image=[UIImage imageNamed:@"xiaJian"];

   

}

-(void)setCellWithModel:(PMQuestionModel*)model{
    
    _titleLabel.text=model.title;
    _contentTF.text=model.content;
    CGSize size=[UILabel sizeWithText:model.title fontSize:12 andMaxsize:WF_ScreenWidth-30];
    if (model.type==4) {
        _titleLabel.frame=CGRectMake(15, 15, WF_ScreenWidth-30, size.height);
        _bgView.frame=CGRectMake(15,_titleLabel.swf_bottom+10, WF_ScreenWidth-30, 45);
    }
   
}



-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return NO;

}

+(CGFloat)cellWithHight:(PMQuestionModel*)model{
    
    if (model.type==4) {
      CGSize size=[UILabel sizeWithText:model.title fontSize:12 andMaxsize:WF_ScreenWidth-30];
        return 70+size.height;
    } else {
        return 90;
    }
}

-(void)setCellWithModel1:(PMQuesModel*)model{
    _titleLabel.text=model.title;
    _contentTF.text=model.content;
    CGSize size=[UILabel sizeWithText:model.title fontSize:12 andMaxsize:WF_ScreenWidth-30];
    _titleLabel.frame=CGRectMake(15, 15, WF_ScreenWidth-30, size.height);
    _bgView.frame=CGRectMake(15,_titleLabel.swf_bottom+10, WF_ScreenWidth-30, 45);
    
}

+(CGFloat)cellWithHight1:(PMQuesModel*)model{
    
    CGSize size=[UILabel sizeWithText:model.title fontSize:12 andMaxsize:WF_ScreenWidth-30];
    return 70+size.height;
    
}
@end
