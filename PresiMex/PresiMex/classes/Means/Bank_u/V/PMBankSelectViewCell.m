//
//  PMBankSelectViewCell.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/6/4.
//

#import "PMBankSelectViewCell.h"



@interface PMBankSelectViewCell ()


@property (nonatomic, strong) UIButton *priaBtn;
@property (nonatomic, strong) UIButton *wanitaBtn;
@property (nonatomic, strong) UILabel  *titleLabel;
@end
@implementation PMBankSelectViewCell


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
    static NSString *ID = @"PMBankSelectViewCell";
    
    PMBankSelectViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PMBankSelectViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
-(void)setupSubViews{
    
    
    _titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_titleLabel];
    _titleLabel.font =B_FONT_REGULAR(12);
    _titleLabel.textColor =BColor_Hex(@"#1B1200",1);
    _titleLabel.text=@"Método de pago";
    _titleLabel.frame=CGRectMake(15, 20,100, 20);
    _titleLabel.textAlignment=NSTextAlignmentLeft;
    
    UIButton*priaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    priaBtn.tag=100;
    priaBtn.frame = CGRectMake(WF_ScreenWidth-80-15-20-150,15,150, 30);
    [priaBtn setTitle:@"Tarjeta de débito" forState:UIControlStateNormal];
    [priaBtn setTitleColor:BColor_Hex(@"#1B1200", 1) forState:UIControlStateNormal];
    priaBtn.titleLabel.font=B_FONT_BOLD(15);
    [priaBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:priaBtn];
    [priaBtn setImage:[UIImage imageNamed:@"select_normal"] forState:UIControlStateNormal];
    [priaBtn setImage:[UIImage imageNamed:@"select_sel"] forState:UIControlStateSelected];
    [priaBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
    priaBtn.selected=NO;
    _priaBtn=priaBtn;
    
    
    UIButton*wanitaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wanitaBtn.tag=101;
    wanitaBtn.frame = CGRectMake(WF_ScreenWidth-80-15, 15,80, 30);
    [wanitaBtn setTitle:@"CLABE" forState:UIControlStateNormal];
    [wanitaBtn setTitleColor:BColor_Hex(@"#1B1200", 1) forState:UIControlStateNormal];
    wanitaBtn.titleLabel.font=B_FONT_BOLD(15);
    [wanitaBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:wanitaBtn];
    [wanitaBtn setImage:[UIImage imageNamed:@"select_normal"] forState:UIControlStateNormal];
    [wanitaBtn setImage:[UIImage imageNamed:@"select_sel"] forState:UIControlStateSelected];
    [wanitaBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
    wanitaBtn.selected=NO;
    _wanitaBtn=wanitaBtn;
    
}

-(void)clickBtn:(UIButton*)sender{
    
    sender.selected=!sender.selected;
    
    if (sender.tag==100 && sender.selected) {
        _wanitaBtn.selected=!sender.selected;
    }
    if (sender.tag==101 && sender.selected) {
        _priaBtn.selected=!sender.selected;
    }
    if (self.wanitaBtn.selected && self.click) {
        self.click(sender.tag);
    }
    if (self.priaBtn.selected && self.click) {
        self.click(sender.tag);
    }
}

-(void)setCellWithModel:(bankcardModel*)model{
    if ([model.diameter integerValue] == 1) {
        
        _priaBtn.selected=YES;
        _wanitaBtn.selected=NO;
    } else {
        
        _priaBtn.selected=NO;
        _wanitaBtn.selected=YES;
    }
}


@end
