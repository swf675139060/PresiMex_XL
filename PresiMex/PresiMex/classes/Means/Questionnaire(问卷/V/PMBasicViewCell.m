//
//  PMBasicViewCell.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/30.
//

#import "PMBasicViewCell.h"

#import "PMTextField.h"
#import "BasicDataModel.h"

@interface PMBasicViewCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) PMTextField *contentTF;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) PMQuestionModel*model;
@end

@implementation PMBasicViewCell

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
    static NSString *ID = @"PMBasicViewCell";
    
    PMBasicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PMBasicViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    
    _contentTF = [[PMTextField alloc] init];
    [bgView addSubview:_contentTF];
    _contentTF.font = [UIFont systemFontOfSize:14];
    _contentTF.textColor =BColor_Hex(@"#333333",1);
    _contentTF.textAlignment = NSTextAlignmentLeft;
    _contentTF.frame=CGRectMake(20, 1,WF_ScreenWidth-30-20-39, 43);
    weakify(self)
    _contentTF.endEditingHandler = ^(NSString * _Nonnull text) {
        strongify(self)
        if (self.endInputBlock) {
            self.endInputBlock(self.titleLabel.text, text);
        }
    };
    
    UIImageView*arrowImageView = [[UIImageView alloc] init];
    arrowImageView.contentMode=UIViewContentModeScaleAspectFit;
    [bgView addSubview:arrowImageView];
    arrowImageView.frame=CGRectMake(WF_ScreenWidth-30-14-15,18.5, 14,8);
    arrowImageView.backgroundColor=[UIColor whiteColor];
    arrowImageView.image=[UIImage imageNamed:@"xiaJian"];
    _arrowImageView=arrowImageView;

}

-(void)setCellWithModel:(PMQuestionModel*)model maxCount:(NSInteger)maxCount{
    _model=model;
    _titleLabel.text=model.title;
    _contentTF.maxCount = maxCount;
    if (model.isHave) {
        _contentTF.userInteractionEnabled = NO;
        _arrowImageView.hidden=NO;
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
        _arrowImageView.hidden=YES;
    }
   
   
}


@end
