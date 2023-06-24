//
//  LoanWaitingAlert.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/23.
//  借款处理中

#import "LoanWaitingAlert.h"
#import "WFStarCell.h"

#import "WFImageCell.h"
#import "WFBtnCell.h"
#import "WFLabelCell.h"

@interface LoanWaitingAlert()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/

@property (nonatomic, assign) NSInteger type;
@end

@implementation LoanWaitingAlert

//type 1:引导评价  0 不引导评价
- (instancetype)initWithFrame:(CGRect)frame withType:(NSInteger)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
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
    if (self.type == 1) {
        return 5;
    } else {
        return 3;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        WFImageCell * cell = [WFImageCell cellWithTableView:tableView];
        cell.imgV.image = [UIImage imageNamed:@""];
        cell.bottomLine.hidden = YES;
        [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(25, 27.5, 26, 27.5) height:24];
        return cell;
    }else if (indexPath.row == 1){
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
        cell.label.text = @"Su solicitud ha sido enviada. Estamos procesándola con rapidez. Tan pronto como se complete el proceso, le notificaremos. ";
        cell.label.textAlignment = NSTextAlignmentCenter;
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#1B1200"];
        cell.label.font = [UIFont systemFontOfSize:11];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(0, 23, 0, 23)];
        return cell;
    }else{
        if (self.type == 1) {
            if (indexPath.row == 2) {
                WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
                cell.label.text = @"Por favor, califique nuestra aplicación.";
                cell.label.textColor = [UIColor jk_colorWithHexString:@"#0B0B0B"];
                cell.label.textAlignment = NSTextAlignmentCenter;
                cell.label.font = [UIFont boldSystemFontOfSize:13];
                [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
                [cell upLabelFrameWithInsets:UIEdgeInsetsMake(25, 23, 0, 23)];
                return cell;
                
            }else if (indexPath.row == 3){
                WFStarCell * cell = [WFStarCell cellWithTableView:tableView];
                
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
                [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(30, 25, 20, 25) height:50];
                return cell;
            }
        } else {
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
            [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(30, 25, 20, 25) height:50];
            return cell;
        }
        
       
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
