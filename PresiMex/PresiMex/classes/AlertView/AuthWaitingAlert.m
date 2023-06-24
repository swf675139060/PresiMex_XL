//
//  AuthWaitingAlert.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/22.
//

#import "AuthWaitingAlert.h"

#import "WFLabelCell.h"
@interface AuthWaitingAlert()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)UIImageView * imgV;
@property (nonatomic, strong) UITableView *tableView; /**< 列表*/

@property (nonatomic, strong) NSString *Conttent;

@property (nonatomic, strong) NSString *time;

@end

@implementation AuthWaitingAlert


- (instancetype)initWithFrame:(CGRect)frame withConttent:(NSString *)Conttent{
    self = [super initWithFrame:frame];
    if (self) {
        self.Conttent = [NSString stringWithFormat:@"Hemos recibido su información y el sistema está evaluando su límite. Esto debería tomar %@  segundos.",Conttent] ;
        self.time  = Conttent;
        [self buildSubViews1];
    }
    return self;
}

-(void)uptime:(NSInteger)time{
    self.time  = [NSString stringWithFormat:@"%ld",time];
    self.Conttent = [NSString stringWithFormat:@"Hemos recibido su información y el sistema está evaluando su límite. Esto debería tomar %ld  segundos.",time] ;
    [self.tableView reloadData];
}

-(void)buildSubViews1{
  
    [self addSubview:self.tableView];
    [self addSubview:self.imgV];
   
    
    
    __weak typeof(self)weakSelf = self;
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@(90));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(45);
        make.left.bottom.right.equalTo(self);
    }];
    
    [self upDataFrame];
    
}


#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WFLabelCell * cell = [WFLabelCell cornerCellWithTableView:tableView];
//    cell.label.text = self.Conttent;
    cell.label.textColor = [UIColor jk_colorWithHexString:@"#1B1200"];
    cell.label.font = [UIFont boldSystemFontOfSize:11];
    cell.label.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:self.Conttent attributes: @{NSFontAttributeName:B_FONT_REGULAR(11),NSForegroundColorAttributeName: BColor_Hex(@"#1B1200", 1)}];
    NSRange range=[[attStr string]rangeOfString:self.time];
    [attStr addAttributes:@{NSForegroundColorAttributeName: BColor_Hex(@"#FC7500", 1),NSFontAttributeName:B_FONT_REGULAR(14)} range:range];
    
    cell.label.attributedText = attStr;
    [cell upLabelFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [cell upBGFrameWithInsets:UIEdgeInsetsMake(75, 25, 45, 25) maskedCorners: kCALayerMinXMinYCorner| kCALayerMaxXMinYCorner cornerRadius:0.1];
    return cell;
    
}



#pragma mark -- init

-(UIImageView *)imgV{
    if(_imgV == nil){
        _imgV = [[UIImageView alloc]init];
        _imgV.image = [UIImage imageNamed:@""];
        _imgV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgV;
}


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
        _tableView.layer.cornerRadius = 15;
        _tableView.layer.masksToBounds = YES;
    }
    
    return _tableView;
}
    

-(void)layoutSubviews{
    [self upDataFrame];
}


-(void)upDataFrame{
    dispatch_async(dispatch_get_main_queue(), ^{

        CGFloat height = self.tableView.contentSize.height + 45;
       
        if (self.jk_height != height){
            self.jk_height = height;

            
        }
    });

}
    
    


@end
