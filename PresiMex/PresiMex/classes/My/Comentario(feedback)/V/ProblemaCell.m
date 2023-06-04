//
//  ProblemaCell.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/21.
//

#import "ProblemaCell.h"

@interface ProblemaCell()

@property(strong, nonatomic) NSMutableArray * items;

@end

@implementation ProblemaCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *ID = @"ProblemaCell";
    
    ProblemaCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ProblemaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


-(void)updataWithProblems:(NSArray *)Problems selectIndx:(NSInteger)indx{
    // 删除上次创建的
       for (UIView *subview in self.contentView.subviews) {
           if ([subview isKindOfClass:[UIButton class]]) {
               [subview removeFromSuperview];
           }
       }
    
    // 创建2列btn
    NSInteger columnCount = 2;
    CGFloat labelWidth =  (WF_ScreenWidth - 50)/2;
    CGFloat labelHeight = 40.0;
    CGFloat horizontalSpacing = 20.0;
    CGFloat verticalSpacing = 15.0;

    // 计算每个btn的位置
    CGFloat x = horizontalSpacing;
    CGFloat y = 7.5;
    for (NSInteger i = 0; i < Problems.count; i++) {
      
        // 创建Label
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:Problems[i][@"greene"] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 20;
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = [UIColor jk_colorWithHexString:@"#7C7C7C"].CGColor;
        btn.tag = i;
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        
        [btn addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];

        if(indx == i){
            
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [btn addLinearGradientwithSize:CGSizeMake(labelWidth, labelHeight) withColors:@[(id)[UIColor jk_colorWithHexString:@"#FFB602"].CGColor,(id)[UIColor jk_colorWithHexString:@"#FC7500"].CGColor] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:20];
        }else{
            [btn setTitleColor:[UIColor jk_colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor whiteColor];
            
        }
        
        
        
        
        
        
        // 添加到父视图
        [self.contentView addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(x));
            make.top.equalTo(@(y));
            make.width.equalTo(@(labelWidth));
            make.height.equalTo(@(labelHeight));
            if(i == Problems.count-1){
                make.bottom.equalTo(@(-10));
            }
        }];
        
        // 计算下一个btn的位置
        if ((i + 1) % columnCount == 0) {
            x = horizontalSpacing;
            y += labelHeight + verticalSpacing;
        } else {
            x += labelWidth + horizontalSpacing;
        }
    }

}
    

-(void)clickItem:(UIButton *)btn{
    if(self.clickBlock){
        self.clickBlock(btn.tag);
    }
}



@end
