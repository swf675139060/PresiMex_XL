//
//  BankConfrimAlert.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/24.
//

#import "BankConfrimAlert.h"
#import "WFImageCell.h"
#import "WFLeftRightBtnCell.h"
#import "WFLabelCell.h"
#import "bankcardCell.h"

@interface BankConfrimAlert()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/

@property (nonatomic, assign) NSInteger type; 

@end
@implementation BankConfrimAlert


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
        return 4;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
        cell.label.text = @"Por favor, confirme los detalles de su cuenta.";
        cell.label.textAlignment = NSTextAlignmentCenter;
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#1B1200"];
        cell.label.font = [UIFont boldSystemFontOfSize:11];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(21.5, 54, 0, 54)];
        return cell;
    }else if (indexPath.row == 1){
        bankcardCell * cell = [bankcardCell alertCellWithTableView:tableView];
        [cell updataWithModel:self.bankModel indx:indexPath.row];
        return cell;
    }else if (indexPath.row == 2){
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView identifier:@"2"];
        if (self.type == 1) {
            
            NSString * text = @"";
            cell.label.attributedText = [[NSMutableAttributedString alloc] initWithString:text];
        } else {
            
            NSString * text = [NSString stringWithFormat:@"El monto de la transacción:$ %@",self.money];
            NSString * subText = [NSString stringWithFormat:@"$ %@",self.money];
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text attributes: @{NSFontAttributeName:B_FONT_REGULAR(14),NSForegroundColorAttributeName: BColor_Hex(@"#7C7C7C", 1)}];
            NSRange range=[text rangeOfString:subText];
            [attStr addAttributes:@{NSFontAttributeName:B_FONT_REGULAR(18),NSForegroundColorAttributeName: BColor_Hex(@"#FC7500", 1)} range:range];
            
            cell.label.attributedText = attStr;
        }
       
        
        cell.label.textAlignment = NSTextAlignmentCenter;
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(19, 23, 0, 23)];
        return cell;
    }else {
        
        WFLeftRightBtnCell * cell = [WFLeftRightBtnCell cellWithTableView:tableView];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(18, 12, 25, 12) height:50];
        [cell.leftBtn setTitle:@"Modificar" forState:UIControlStateNormal];
        [cell.leftBtn setTitleColor:[UIColor jk_colorWithHexString:@"#CCCCCC"]  forState:UIControlStateNormal];
        cell.leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        cell.leftBtn.layer.cornerRadius = 13;
        cell.leftBtn.layer.masksToBounds = YES;
        cell.leftBtn.layer.borderWidth = 1;
        cell.leftBtn.layer.borderColor = BColor_Hex(@"#CCCCCC", 1).CGColor;
        
        
        [cell.rightBtn setText:@"Quedarse" TextColor:BColor_Hex(@"#FFFFFF", 1) Font:[UIFont systemFontOfSize:13] forState:UIControlStateNormal];
        
        [cell.rightBtn addLinearGradientwithSize:CGSizeMake((WF_ScreenWidth - 79)/2, 50) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:13];
        
        [cell.leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(0));
            make.top.equalTo(@(0));
            make.bottom.equalTo(@(0));
            make.width.equalTo(@((WF_ScreenWidth - 79)/2));

        }];
        
        [cell.rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(0));
            make.top.equalTo(@(0));
            make.bottom.equalTo(@(0));
            make.left.equalTo(cell.leftBtn.mas_right).offset(11);
            make.width.equalTo(@((WF_ScreenWidth - 79)/2));
            

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
