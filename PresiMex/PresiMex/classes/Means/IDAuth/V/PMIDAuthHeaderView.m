//
//  PMIDAuthHeaderView.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/30.
//

#import "PMIDAuthHeaderView.h"

@implementation PMIDAuthHeaderView

-(instancetype)initViewWithType:(NSInteger)type{
   
    self = [super init];
    if (self) {
        self.frame=CGRectMake(0, 0,WF_ScreenWidth, 80);
        self.backgroundColor=BColor_Hex(@"#FFB602", 0.06);;
        [self setupSubViewsWithType:type];
        
    }
    return self;
}

-(void)setupSubViewsWithType:(NSInteger)type{
    
    UIView *pgBgV=[UIView new];
    pgBgV.frame=CGRectMake(15, 17.5,WF_ScreenWidth-30,8);
    pgBgV.layer.cornerRadius=4;
    pgBgV.layer.masksToBounds=YES;
    pgBgV.backgroundColor=BColor_Hex(@"#FFE1C1", 1);
    [self addSubview:pgBgV];
    UIView *gress = [[UIView alloc] init];
    gress.layer.cornerRadius=4;
    gress.layer.masksToBounds=YES;
    [pgBgV addSubview:gress];
    
    UILabel *typeLabel = [[UILabel alloc] init];
    typeLabel.frame = CGRectMake(15,pgBgV.swf_bottom+16,21,15);
    typeLabel.font=B_FONT_MEDIUM(13);
    typeLabel.textColor=BColor_Hex(@"#1B1200", 1);
    typeLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:typeLabel];

    CGSize size=CGSizeMake((WF_ScreenWidth-30)/4, 8);;
    if (type==1) {
        gress.frame=CGRectMake(0, 0, (WF_ScreenWidth-30)/4, 8);
         size=CGSizeMake((WF_ScreenWidth-30)/4, 8);
        typeLabel.text=@"1/4";
        
    } else if (type==2){
        gress.frame=CGRectMake(0, 0, (WF_ScreenWidth-30)/2, 8);
        size=CGSizeMake((WF_ScreenWidth-30)/2, 8);
        typeLabel.text=@"2/4";
        
    }else if (type==3){
        gress.frame=CGRectMake(0, 0, (WF_ScreenWidth-30)*3/4, 8);
        size=CGSizeMake((WF_ScreenWidth-30)*3/4, 8);
        typeLabel.text=@"3/4";
    }else if (type==4){
        gress.frame=CGRectMake(0, 0, (WF_ScreenWidth-30), 8);
        size=CGSizeMake((WF_ScreenWidth-30), 8);
        typeLabel.text=@"4/4";
    }
    NSArray *colors = @[(id)[UIColor jk_colorWithHexString:@"#FAA83C"].CGColor, (id)[UIColor jk_colorWithHexString:@"#F36F1D"].CGColor];
    [gress addLinearGradientwithSize:size withColors:colors startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0) maskedCorners:kCALayerMinXMaxYCorner cornerRadius:0];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.frame = CGRectMake(typeLabel.swf_right+15,pgBgV.swf_bottom+16,270,15);
    [self addSubview:tipLabel];
    tipLabel.text=@"Puede obtener los cupones después de la autenticación";
    tipLabel.font=B_FONT_REGULAR(10);
    tipLabel.textColor=BColor_Hex(@"#7C7C7C", 1);
    tipLabel.textAlignment = NSTextAlignmentLeft;
    
    UIImageView*imageView = [[UIImageView alloc] init];
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    [self addSubview:imageView];
    imageView.frame=CGRectMake(WF_ScreenWidth-15-18.5,18.5,21,27.5);
    imageView.image=[UIImage imageNamed:@"cer_icon"];
    imageView.swf_centerY=tipLabel.swf_centerY;
}
@end
