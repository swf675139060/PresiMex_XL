//
//  YouHuiAlertCell.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/7/1.
//

#import "YouHuiAlertCell.h"

@implementation YouHuiAlertCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *ID = @"YouHuiAlertCell";
    
    YouHuiAlertCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YouHuiAlertCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell creatSubView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}



-(void)creatSubView {
    
    [self.contentView addSubview:self.item0];
    [self.contentView addSubview:self.item1];
    [self.contentView addSubview:self.item2];
    
    __weak typeof(self)weakSelf = self;
    
    [self.item0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WF_BiLi(60)));
        make.left.equalTo(@(WF_BiLi(32)));
        make.bottom.equalTo(@(0));
        make.width.equalTo(@(WF_BiLi(72)));
        make.height.equalTo(@(WF_BiLi(130)));
    }];
    
    [self.item1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WF_BiLi(60)));
        make.left.equalTo(@(WF_BiLi(125)));
        make.bottom.equalTo(@(0));
        make.width.equalTo(@(WF_BiLi(72)));
        make.height.equalTo(@(WF_BiLi(130)));
    }];
    
    [self.item2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WF_BiLi(60)));
        make.left.equalTo(@(WF_BiLi(215)));
        make.bottom.equalTo(@(0));
        make.width.equalTo(@(WF_BiLi(72)));
        make.height.equalTo(@(WF_BiLi(130)));
    }];
    
}



-(YouHuiAlertCellItem *)item0{
    if(_item0 == nil){
        _item0 = [[YouHuiAlertCellItem alloc]init];
    }
    return _item0;
}

-(YouHuiAlertCellItem *)item1{
    if(_item1 == nil){
        _item1 = [[YouHuiAlertCellItem alloc]init];
    }
    return _item1;
}
-(YouHuiAlertCellItem *)item2{
    if(_item2 == nil){
        _item2 = [[YouHuiAlertCellItem alloc]init];
    }
    return _item2;
}


-(void)upDateWithArr:(NSArray *)arr{
//    if(arr.count == 1){
//        CuponModel * model = arr[0];
        self.item0.label.text = [NSString stringWithFormat:@"$%@",@"5"];
//    }
//    if(arr.count == 2){
//        CuponModel * model = arr[1];
        self.item1.label.text = [NSString stringWithFormat:@"$%@",@"10"];
//    }
//    if(arr.count == 3){
//        CuponModel * model = arr[2];
        self.item2.label.text = [NSString stringWithFormat:@"$%@",@"5000"];
//    }
}


@end

@interface YouHuiAlertCellItem()

@property (strong, nonatomic)UIImageView * imgV;

@end


@implementation YouHuiAlertCellItem


-(void)buildSubViews{
    [self addSubview:self.imgV];
    
    [self addSubview:self.label];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(padding);
        
    }];
    
    
    UIEdgeInsets LBPadding = UIEdgeInsetsMake(WF_BiLi(82) , WF_BiLi(7), WF_BiLi(23), WF_BiLi(7));
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(LBPadding);
        
    }];
    
}

-(UIImageView *)imgV{
    if(_imgV == nil){
        _imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"youhuiItem"]];
        _imgV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgV;
}

-(UILabel *)label{
    if(_label == nil){
        _label = [[UILabel alloc] init];
        _label.numberOfLines = 1;
        _label.adjustsFontSizeToFitWidth = YES;
        _label.textAlignment = NSTextAlignmentCenter;
        [_label setText:@"" TextColor:BColor_Hex(@"#FC7700", 1) Font:[UIFont systemFontOfSize:20]];
    }
    return _label;
}

    
@end
