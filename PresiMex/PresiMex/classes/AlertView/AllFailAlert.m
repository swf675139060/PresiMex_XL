//
//  AllFailAlert.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/24.
//

#import "AllFailAlert.h"
#import "WFBtnCell.h"
#import "WFLabelCell.h"

@interface AllFailAlert()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/


@property (nonatomic, strong) NSString * titleStr;

@property (nonatomic, strong) NSString * contentStr;


@end

@implementation AllFailAlert

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title  content:(NSString *)content{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleStr = title;
        self.contentStr = content;
        [self buildSubViews1];
    }
    return self;
}

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
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
        cell.label.text = self.titleStr;
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#FFA402"];
        cell.label.font = [UIFont systemFontOfSize:11];
        cell.label.textAlignment = NSTextAlignmentCenter;
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(9.5, 25, 9, 25)];
        cell.BGView.backgroundColor = BColor_Hex(@"#FC7500", 0.2);
        return cell;
    }else if (indexPath.row == 1){
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
        cell.label.text = self.contentStr;
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#1B1200"];
        cell.label.font = [UIFont systemFontOfSize:11];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(25, 24, 20, 24)];
        return cell;
    }else{
        WFBtnCell * cell = [WFBtnCell cellWithTableView:tableView];
        [cell.btn setTitle:@"OK" forState:UIControlStateNormal];
        cell.btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        WF_WEAKSELF(weakself);
        [cell setClickBtnBlock:^{
            if(weakself.clickBtnBlock){
                weakself.clickBtnBlock();
            }
        }];
        [cell.btn addLinearGradientwithSize:CGSizeMake(self.jk_width - 50, 50) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:13];
        [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(0, 25, 20, 25) height:50];
        return cell;
    }
    
    
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
