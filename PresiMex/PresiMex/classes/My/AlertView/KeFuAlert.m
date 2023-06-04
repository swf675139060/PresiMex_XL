//
//  KeFuAlert.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/3.
//

#import "KeFuAlert.h"
#import "WFLeftImageTwolabelCell.h"
#import "WFLabelCell.h"

@interface KeFuAlert()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/


@end

@implementation KeFuAlert


-(void)buildSubViews1{
    
   
    [self addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(self);
    }];
    
    [self upDataFrame];
    
}


#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        WFLeftImageTwolabelCell * cell = [WFLeftImageTwolabelCell cellWithTableView:tableView];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(33.5, 26.5, 20, 0)];
        [cell upLabelsFrameWithInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
        cell.imageV.image = [UIImage imageNamed:@"phoneNumber"];
        [cell.topLabel setText:@"Atención al cliente (whatsapp)" TextColor:BColor_Hex(@"#7C7C7C", 1) Font:[UIFont systemFontOfSize:11]];
        [cell.bottomLabel setText:@"+52 XXXXXXXXX" TextColor:BColor_Hex(@"#008DFC", 1) Font:[UIFont systemFontOfSize:12]];
        
        
        return cell;
    } else if (indexPath.row == 1) {
        WFLeftImageTwolabelCell * cell = [WFLeftImageTwolabelCell cellWithTableView:tableView];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(33.5, 26.5, 20, 0)];
        [cell upLabelsFrameWithInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
        cell.imageV.image = [UIImage imageNamed:@"youJian"];
        [cell.topLabel setText:@"Correo electrónico" TextColor:BColor_Hex(@"#7C7C7C", 1) Font:[UIFont systemFontOfSize:11]];
        [cell.bottomLabel setText:@"XXXXXXXXXXX@gmail.com" TextColor:BColor_Hex(@"#008DFC", 1) Font:[UIFont systemFontOfSize:12]];
        return cell;
    }else{
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
        cell.label.text = @"Horario de Atención al Cliente: 9:30 - 18:30";
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#1B1200"];
        cell.label.font = [UIFont boldSystemFontOfSize:12];
        cell.label.textAlignment = NSTextAlignmentCenter;
        cell.BGView.backgroundColor = BColor_Hex(@"#1B1200", 1);
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(17, 10, 17, 10)];
        return cell;
    }
    
    return [UITableViewCell new];
    
}



#pragma mark -- init
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor  = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}
    

-(void)layoutSubviews{
    [self upDataFrame];
}


-(void)upDataFrame{
    dispatch_async(dispatch_get_main_queue(), ^{

        CGFloat height = self.tableView.contentSize.height;
       
        if (self.jk_height != height){
            self.jk_height = height;

            
        }
    });

}
    

@end
