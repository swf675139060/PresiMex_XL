//
//  WFImageCell.m
//  RVIHome
//
//  Created by shenWenFeng on 2023/4/13.
//

#import "WFImageCell.h"

@implementation WFImageCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *ID = @"WFImageCell";
    
    WFImageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WFImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell creatSubView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}



-(void)creatSubView {
    
    [self.contentView addSubview:self.imgV];
    [self.contentView addSubview:self.bottomLine];
    
    //设置距离父视图边界距离
    UIEdgeInsets padding = UIEdgeInsetsMake(4, 0, 8, 0);
    __weak typeof(self)weakSelf = self;
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentView).with.insets(padding);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.height.equalTo(@(0.5));
    }];
    
}

-(void)updateFrameWithEdgeInsets:(UIEdgeInsets )padding height:(CGFloat)height{
    __weak typeof(self)weakSelf = self;
    [self.imgV mas_updateConstraints:^(MASConstraintMaker *make) {
     
        make.edges.equalTo(weakSelf.contentView).with.insets(padding);
        if (height) {
            make.height.equalTo(@(height));
        }
       
 
    }];
}

-(UIImageView *)imgV{
    if(_imgV == nil){
        _imgV = [[UIImageView alloc]init];
        _imgV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgV;
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
