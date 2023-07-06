//
//  PoPBottomView.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/28.
//

#import "PoPBottomView.h"
#import "WFLabelCell.h"

@interface PoPBottomView()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/



@end

@implementation PoPBottomView
-(void)setTitles:(NSArray *)titles{
    _titles = titles;
    [self.tableView reloadData];
    
    CGFloat height = MIN(titles.count * 50 + WF_BottomSafeAreaHeight, WF_ScreenHeight - WF_NavigationHeight);
    self.frame = CGRectMake(0, 0, WF_ScreenWidth, height);
}

-(void)buildSubViews{
    
    [self addSubview:self.tableView];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(self);
    }];
}


#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 44;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
   
    [cell.label setText:self.titles[indexPath.row] TextColor:BColor_Hex(@"#0B0B0B", 1) Font:[UIFont systemFontOfSize:14]];
    cell.label.textAlignment = NSTextAlignmentCenter;
    cell.bottomLine.hidden = NO;
    return cell;
   
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if (self.selectBlock) {
        self.selectBlock(self.titles[indexPath.row], indexPath.row);
    }
    
}

#pragma mark - DZNEmptyDataSetSource
//// 返回图片
//- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
//    return [UIImage imageNamed:@"wuYouhui"];
//}
//
//// 返回标题文字
//- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
//    NSString *text = @"Aún no hay cupones";
//    NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:14.0f], NSForegroundColorAttributeName: BColor_Hex(@"#1B1200", 1)};
//    return [[NSAttributedString alloc] initWithString:text attributes:attribute];
//}
//
//// 标题文字与详情文字的距离
//- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
//    return 20;
//}


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
        
        _tableView.emptyDataSetSource= self;

        _tableView.emptyDataSetDelegate= self;
    }
    
    return _tableView;
}

//-(void)layoutSubviews{
//    [self upDataFrame];
//}
//
//
//-(void)upDataFrame{
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        CGFloat height = self.tableView.contentSize.height;
//
//        if (self.jk_height != height){
//            self.jk_height = height;
//
//
//        }
//    });
//
//}

@end
