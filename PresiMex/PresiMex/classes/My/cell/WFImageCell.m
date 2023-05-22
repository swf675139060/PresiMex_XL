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
    
    //设置距离父视图边界距离
    UIEdgeInsets padding = UIEdgeInsetsMake(4, 0, 8, 0);
    __weak typeof(self)weakSelf = self;
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentView).with.insets(padding);
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

@end
