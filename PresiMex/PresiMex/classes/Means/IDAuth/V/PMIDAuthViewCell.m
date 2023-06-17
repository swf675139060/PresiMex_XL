//
//  PMIDAuthViewCell.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/30.
//

#import "PMIDAuthViewCell.h"
#import "UIImageView+WebCache.h"

@interface PMIDAuthViewCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UILabel  *desTitleLabel;
@end

@implementation PMIDAuthViewCell

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
    static NSString *ID = @"PMIDAuthViewCell";
    
    PMIDAuthViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PMIDAuthViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}


-(void)setupSubViews{
    
    UIView *titleBg = [[UIView alloc] init];
    titleBg.frame = CGRectMake(0,0,WF_ScreenWidth,44);
    titleBg.backgroundColor=BColor_Hex(@"#F8F7F6", 1);
    [self.contentView addSubview:titleBg];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(15,12,300,20);
    [titleBg addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text=@"Autenticación biométrica";
    titleLabel.font=B_FONT_BOLD(13);
    titleLabel.textColor=BColor_Hex(@"#1B1200", 1);
    _titleLabel=titleLabel;
   
    UIImageView *imgView=[[UIImageView alloc] init];
    [self.contentView addSubview:imgView];
    imgView.contentMode=UIViewContentModeScaleAspectFit;
    imgView.frame=CGRectMake((WF_ScreenWidth-215)/2, titleBg.swf_bottom+15, 215, 122);
    imgView.userInteractionEnabled=YES;
    _imgView=imgView;

    UILabel *desTitleLabel = [[UILabel alloc] init];
    desTitleLabel.frame = CGRectMake(5,87,205,13);
    [imgView addSubview:desTitleLabel];
    desTitleLabel.font=B_FONT_REGULAR(10);
    desTitleLabel.textAlignment = NSTextAlignmentCenter;
    desTitleLabel.textColor=[UIColor whiteColor];
    _desTitleLabel=desTitleLabel;




}


-(void)setCellWithModel:(PMIDAuthModel*)model{
    _titleLabel.text=model.title;
    _desTitleLabel.text=model.desTitle;
    
    if (model.type==0) {
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.held] placeholderImage:[UIImage imageNamed:@"ID_Auth_Default_1"]];
        if (model.held.length!=0) {
            _desTitleLabel.hidden=YES;
        } else {
            _desTitleLabel.hidden=NO;
        }
        
    }else if (model.type==1){
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.silent] placeholderImage:[UIImage imageNamed:@"ID_Auth_Default_2"]];
        if (model.silent.length!=0) {
            _desTitleLabel.hidden=YES;
        } else {
            _desTitleLabel.hidden=NO;
        }
    }else if (model.type==2){
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.acoustic] placeholderImage:[UIImage imageNamed:@"ID_Auth_Default_3"]];
        if (model.acoustic.length!=0) {
            _desTitleLabel.hidden=YES;
        } else {
            _desTitleLabel.hidden=NO;
        }
    }
  

}
@end
