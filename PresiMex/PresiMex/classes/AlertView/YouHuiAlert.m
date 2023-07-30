//
//  YouHuiAlert.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/7/1.
//

#import "YouHuiAlert.h"
#import "WFImageCell.h"
#import "WFLeftRightBtnCell.h"
#import "WFLabelCell.h"
#import "bankcardCell.h"
#import "YouHuiAlertCell.h"

@interface YouHuiAlert()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/


@property (nonatomic, strong) NSArray *Arr;

@end
@implementation YouHuiAlert


- (instancetype)initWithFrame:(CGRect)frame withArr:(NSArray *)Arr{
    self = [super initWithFrame:frame];
    if (self) {
        self.Arr = Arr;
        [self buildSubViews1];
    }
    return self;
}

-(void)buildSubViews1{
    
    [self addSubview:self.tableView];
    
//    CGFloat biLi = WF_ScreenWidth/360;
    
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.bottom.right.equalTo(self);
//        make.width.equalTo(@(biLi * (WF_ScreenWidth - 40)));
//        make.height.equalTo(@(biLi * 400));
//    }];
    
//    [self upDataFrame];
    
}


#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return 4;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat biLi = WF_ScreenWidth/360;
    
    if (indexPath.row == 0) {
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
        cell.label.text = @"Si se desconecta ahora, el sistema eliminará su cupón.";
        cell.label.textAlignment = NSTextAlignmentCenter;
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#0B0B0B"];
        cell.label.font = [UIFont boldSystemFontOfSize:16];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(biLi * 52, biLi * 61, 0, biLi * 61)];
        return cell;
    }else if (indexPath.row == 1){
        YouHuiAlertCell * cell = [YouHuiAlertCell cellWithTableView:tableView];
        [cell upDateWithArr:self.Arr];
        return cell;
    }else if (indexPath.row == 2){
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView identifier:@"2"];
      
        
        [cell.label setText:@"¿Está seguro de que quiera cancelar la autenticación?" TextColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:11]];
        cell.label.textAlignment = NSTextAlignmentCenter;
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(biLi * 21, 0, biLi * 14, 0)];
        return cell;
    }else {
        
        WFLeftRightBtnCell * cell = [WFLeftRightBtnCell cellWithTableView:tableView];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, biLi * 15, biLi * 0) height:50];
        
        [cell.leftBtn setText:@"Salir" TextColor:BColor_Hex(@"#FFFFFF", 1) Font:[UIFont systemFontOfSize:13] forState:UIControlStateNormal];
        cell.leftBtn.layer.cornerRadius = 13;
        cell.leftBtn.layer.masksToBounds = YES;
        cell.leftBtn.backgroundColor = [UIColor clearColor];
        cell.leftBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        cell.leftBtn.layer.borderWidth = 0.5;
        
        
        [cell.rightBtn setTitle:@"Quedarse" forState:UIControlStateNormal];
        [cell.rightBtn setTitleColor:[UIColor jk_colorWithHexString:@"#C56F04"]  forState:UIControlStateNormal];
        cell.rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        cell.rightBtn.layer.cornerRadius = 13;
        cell.rightBtn.layer.masksToBounds = YES;
        cell.rightBtn.backgroundColor = [UIColor whiteColor];
        
        [cell.leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(biLi * 30));
            make.top.equalTo(@(0));
            make.bottom.equalTo(@(0));
            make.width.equalTo(@(biLi * 110));
//            make.height.equalTo(@(biLi * 50));

        }];
        
        [cell.rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(@(0));
            make.bottom.equalTo(@(0));
            make.left.equalTo(cell.leftBtn.mas_right).offset(biLi * 10);
            make.width.equalTo(@(biLi * 140));
            

        }];
        
        WF_WEAKSELF(weakself);
        [cell setClickBtnBlock:^(NSInteger indx) {
            if (weakself.clickBtnBlock) {
                weakself.clickBtnBlock(indx);
            }
            
        }];
        return cell;
    }
    
    
}



#pragma mark -- init
- (UITableView *)tableView
{
    if (!_tableView) {
        
        CGFloat biLi = WF_ScreenWidth/360;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, biLi * 320, biLi * 400)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor  = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.backgroundView = [[UIImageView alloc] initWithImage:@"youhuiBG"];
        
        // 创建 UIImageView 并设置其图片
        UIImage *backgroundImage = [UIImage imageNamed:@"youhuiBG"];
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];

        
        // 设置 UIImageView 的 frame 和 contentMode
        backgroundImageView.frame = _tableView.bounds;
        backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;

        // 将 UIImageView 添加到 UITableView 的 backgroundView 中
        _tableView.backgroundView = backgroundImageView;
    }
    
    return _tableView;
}
    

//-(void)layoutSubviews{
//    [self upDataFrame];
//}


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
