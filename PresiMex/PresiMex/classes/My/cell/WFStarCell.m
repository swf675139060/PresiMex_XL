//
//  WFStarCell.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/23.
//

#import "WFStarCell.h"

@implementation WFStarCell



+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *ID = @"WFStarCell";
    
    WFStarCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WFStarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell creatSubView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}



-(void)creatSubView {
    
    [self.contentView addSubview:self.starV];
    [self.contentView addSubview:self.bottomLine];
    
    //设置距离父视图边界距离

    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.top.equalTo(@(45));
        make.height.equalTo(@(0.5));
    }];
    
}


-(XHStarRateView *)starV{
    if(_starV == nil){
        CGFloat width = 152 + 28*2;
        _starV = [[XHStarRateView alloc] initWithFrame:CGRectMake((WF_ScreenWidth - 60 -width)/2 , 17, width, 28) numberOfStars:5 rateStyle:WholeStar isAnination:YES finish:^(CGFloat currentScore) {
            NSLog(@"4----  %f",currentScore);
            
        }];
        [_starV setCurrentScore:4];
    }
    return _starV;
}

-(UIView *)bottomLine{
    if(_bottomLine == nil){
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor jk_colorWithHexString:@"#DDDDDD"];
        _bottomLine.hidden = YES;
    }
    return _bottomLine;
}

@end
