//
//  PMIDAuthTextViewCell.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/6/3.
//

#import "PMIDAuthTextViewCell.h"




@interface PMIDAuthTextViewCell ()

@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation PMIDAuthTextViewCell

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
    static NSString *ID = @"PMIDAuthTextViewCell";
    
    PMIDAuthTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PMIDAuthTextViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
-(void)setupSubViews{
    

    
    UIView *bgView=[UIView new];
    [self.contentView addSubview:bgView];
    bgView.layer.borderColor=BColor_Hex(@"#CCCCCC", 0.5).CGColor;
    bgView.layer.borderWidth=0.5;
    bgView.layer.cornerRadius=22.5;
    bgView.frame=CGRectMake(15,10, WF_ScreenWidth-30, 45);
    _bgView=bgView;
    
    _titleLabel = [[UILabel alloc] init];
    [bgView addSubview:_titleLabel];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.textColor =BColor_Hex(@"#7C7C7C",1);
    _titleLabel.textAlignment=NSTextAlignmentLeft;
    _titleLabel.frame=CGRectMake(15,12.5,145, 20);
   
    
    _contentTF = [[PMTextField alloc] init];
    [bgView addSubview:_contentTF];
    _contentTF.font = [UIFont systemFontOfSize:14];
    _contentTF.textColor =BColor_Hex(@"#333333",1);
    _contentTF.textAlignment = NSTextAlignmentRight;
    _contentTF.frame=CGRectMake(_titleLabel.swf_right, 1,WF_ScreenWidth-190-15, 43);
    
    weakify(self)
    _contentTF.endEditingHandler = ^(NSString * _Nonnull text) {
        strongify(self)
        if (self.endEditingHandler) {
            self.endEditingHandler(self.titleLabel.text, text);
        }
    };
   
}

-(void)setCellWithModel:(PMIDAuthModel*)model{
    
    _titleLabel.text=model.title;
    _contentTF.text=model.cartoon;
    if (model.type == 3) {
        _contentTF.text=model.davis;
    } else {
        _contentTF.text=model.cartoon;
    }
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName: BColor_Hex(@"#CCCCCC", 1), NSFontAttributeName: [UIFont systemFontOfSize:14]};
    NSAttributedString *attributedPlaceholder = [[NSAttributedString alloc] initWithString:model.placeHold attributes:attributes];
    _contentTF.attributedPlaceholder = attributedPlaceholder;
    
}


@end
