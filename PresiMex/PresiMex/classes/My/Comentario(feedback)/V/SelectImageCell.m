//
//  SelectImageCell.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/21.
//

#import "SelectImageCell.h"

@implementation SelectImageCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *ID = @"SelectImageCell";
    
    SelectImageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SelectImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


-(void)updataWithImages:(NSArray *)Images{
    NSMutableArray * ImagesDicArr = [NSMutableArray array];
    for (int i = 0; i < Images.count; i++) {
        [ImagesDicArr addObject:@{@"type":@"1",@"image":Images[i]}];
    }
    if(Images.count < 5){
        [ImagesDicArr addObject:@{@"type":@"0",@"image":[UIImage imageNamed:@"addImage"]}];
    }
    
    // 创建2列btn
    NSInteger columnCount = 4;
    CGFloat labelWidth =  (WF_ScreenWidth - 30 - 18 - 30)/columnCount;
    CGFloat labelHeight = labelWidth;
    CGFloat horizontalSpacing = 10.0;
    CGFloat verticalSpacing = 10.0;

    // 计算每个btn的位置
    CGFloat x = 9;
    CGFloat y = 15;
    for (NSInteger i = 0; i < ImagesDicArr.count; i++) {
        // 删除上次创建的
        for (UIView *subview in self.contentView.subviews) {
            if ([subview isKindOfClass:[UIButton class]]) {
                [subview removeFromSuperview];
            }
        }
        
        
        // 创建Label
        UIButton *btn = [[UIButton alloc] init];
//        [btn setBackgroundImage:ImagesDicArr[i][@"image"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateNormal];
        
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        btn.tag = i;
        btn.backgroundColor = [UIColor redColor];
        
        // 添加到父视图
        [self.contentView addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(x));
            make.top.equalTo(@(y));
            make.width.equalTo(@(labelWidth));
            make.height.equalTo(@(labelHeight));
            if(i == ImagesDicArr.count-1){
                make.bottom.equalTo(@(-10));
            }
        }];
        
        if(i == ImagesDicArr.count-1){
            [btn addTarget:self action:@selector(selectImage) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        
        // 计算下一个btn的位置
        if ((i + 1) % columnCount == 0) {
            x = 9;
            y += labelHeight + verticalSpacing;
        } else {
            x += labelWidth + horizontalSpacing;
        }
        
        
        //添加删除按钮
//        if([ImagesDicArr[i][@"type"] integerValue] == 1){
//
//            // 创建Label
////            UIButton *deleteBtn = [[UIButton alloc] init];
////            [deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
////            deleteBtn.tag = i;
////
////            [btn addSubview:deleteBtn];
////
////            [deleteBtn addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
////
////            [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
////                make.centerX.equalTo(btn.mas_right);
////                make.centerY.equalTo(btn.mas_top);
////                make.width.equalTo(@(20));
////                make.height.equalTo(@(20));
////
////            }];
//        }
        
        
        
    }
    
}
    
-(void)selectImage{
    
    if(self.selectImageBlock){
        self.selectImageBlock();
    }
    
}
-(void)clickItem:(UIButton *)btn{
    if(self.imageChangeBlock){
        self.imageChangeBlock(@[]);
    }
}




@end
