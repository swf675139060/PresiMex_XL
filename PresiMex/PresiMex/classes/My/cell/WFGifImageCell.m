//
//  WFGifImageCell.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/26.
//

#import "WFGifImageCell.h"

@implementation WFGifImageCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *ID = @"WFGifImageCell";
    
    WFGifImageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WFGifImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
//    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(weakSelf.contentView).with.insets(padding);
//    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(@(0));
        make.top.equalTo(@(75));
        make.bottom.equalTo(@(0));
        make.height.equalTo(@(0.5));
    }];
    
}

-(void)updateFrameWithEdgeInsets:(UIEdgeInsets )padding height:(CGFloat)height{
    __weak typeof(self)weakSelf = self;
//    [self.imgV mas_updateConstraints:^(MASConstraintMaker *make) {
//
//        make.edges.equalTo(weakSelf.contentView).with.insets(padding);
//        if (height) {
//            make.height.equalTo(@(height));
//        }
//
//
//    }];
}

-(FLAnimatedImageView *)imgV{
    if(_imgV == nil){
        _imgV = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 30, WF_ScreenWidth - 60, 24)];
        _imgV.contentMode = UIViewContentModeScaleAspectFill;
        // 获取本地数据文件路径
//        _imgV.backgroundColor = [UIColor redColor];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"loadingGif" ofType:@"gif"];
        // 创建 FLAnimatedImage 对象
        FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:filePath]];
//         animatedImage.loopCount = 1;
        _imgV.animatedImage = animatedImage;
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

