//
//  PMCerViewCell.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/6/4.
//

#import "PMCerViewCell.h"

@interface PMCerViewCell()

@property (nonatomic, strong) UIImageView*iconView;
@property (nonatomic, strong) UILabel  *titleLabel;
@end



@implementation PMCerViewCell

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
    static NSString *ID = @"PMCerViewCell";
    
    PMCerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PMCerViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
-(void)setupSubViews{
   
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(15,10,WF_ScreenWidth-30,50);
    bgView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    bgView.layer.cornerRadius = 10;
    bgView.layer.shadowColor =BColor_Hex(@"#D9D9D9", 0.5).CGColor;
    bgView.layer.shadowOffset = CGSizeMake(0,1);
    bgView.layer.shadowOpacity = 1;
    bgView.layer.shadowRadius = 10;
    [self.contentView addSubview:bgView];

    UIImageView*imageView = [[UIImageView alloc] init];
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    [bgView addSubview:imageView];
    imageView.frame=CGRectMake(15,16,18,18);
    _iconView=imageView;
    
    _titleLabel = [[UILabel alloc] init];
    [bgView addSubview:_titleLabel];
    _titleLabel.font =B_FONT_REGULAR(14);
    _titleLabel.textColor =BColor_Hex(@"#0B0B0B",1);
    _titleLabel.frame=CGRectMake(imageView.swf_right+10,15,260, 20);
    _titleLabel.textAlignment=NSTextAlignmentLeft;
    
}
-(void)setCellWithModel:(PMCerModel*)model{
    _iconView.image=[UIImage imageNamed:model.iconName];
    _titleLabel.text=model.title;
}
@end
