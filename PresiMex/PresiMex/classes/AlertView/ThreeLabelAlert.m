//
//  ThreeLabelAlert.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/10.
//

#import "ThreeLabelAlert.h"
#import "WFBtnCell.h"
#import "WFImageCell.h"
#import "WFLabelCell.h"

@interface ThreeLabelAlert()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/


@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSArray * titleArr;


@end
@implementation ThreeLabelAlert


//type 1: 成功 0 失败
- (instancetype)initWithFrame:(CGRect)frame withType:(NSInteger)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        [self buildSubViews1];
    }
    return self;
}

-(void)buildSubViews1{
    
    if (self.type == 1) {
        self.titleArr = @[
            @"Tarifa de prórroga",
            @"La tarifa de prórroga es igual a la tarifa de servicio de préstamo original más la tarifa de vencimiento, si corresponde. ",
            @"La prórroga solo debe solicitarse en situaciones de dificultades financieras reales cuando no se puede pagar el préstamo en su totalidad. Se recomienda pagar el préstamo en su totalidad si tiene suficientes fondos disponibles."];
    } else {
        self.titleArr = @[
            @"Cargo por mora",
                          
            @"La tasa de cargo por vencimiento es de una cierta proporción diaria y se aplica después de que el plazo del préstamo ha vencido.",
            @"Para evitar mayores problemas financieros, es importante que pague su préstamo a tiempo. Si tiene dificultades financieras, puede considerar solicitar una prórroga."];
    }
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
        cell.label.text = self.titleArr[indexPath.row];
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#0B0B0B"];
        cell.label.font = [UIFont boldSystemFontOfSize:20];
        cell.label.textAlignment = NSTextAlignmentCenter;
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(25, 29, 15, 29)];
        return cell;
    }else if (indexPath.row == 1){
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
        cell.label.text = self.titleArr[indexPath.row];
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#1B1200"];
        cell.label.font = [UIFont systemFontOfSize:11];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(0, 24.5, 0, 24.5)];
        return cell;
    }else{
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
        cell.label.text = self.titleArr[indexPath.row];
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#FFB739"];
        cell.label.font = [UIFont systemFontOfSize:11];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(15, 24.5, 32, 24.5)];
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
