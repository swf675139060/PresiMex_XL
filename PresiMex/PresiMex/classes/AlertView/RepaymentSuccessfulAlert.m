//
//  RepaymentSuccessfulAlert.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/15.
//

#import "RepaymentSuccessfulAlert.h"
#import "WFLeftRightBtnCell.h"
#import "WFLabelCell.h"
#import "WFBtnCell.h"

@interface RepaymentSuccessfulAlert()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)UIImageView * imgV;
@property (nonatomic, strong) UITableView *tableView; /**< 列表*/

@property (nonatomic, strong) NSString *Conttent;



@end
@implementation RepaymentSuccessfulAlert

- (instancetype)initWithFrame:(CGRect)frame withConttent:(NSString *)Conttent btnTitel:(NSString *)btnTitle{
    self = [super initWithFrame:frame];
    if (self) {
        self.Conttent = [NSString stringWithFormat:@"Felicitaciones, en %@  has liquidado tu deuda con éxito, Puedes solicitar en este producto inmediatamente.",Conttent];
        
        
        
        
        [self buildSubViews1];
    }
    return self;
}

-(void)buildSubViews1{
   
//
    
    [self addSubview:self.imgV];
   
    [self addSubview:self.tableView];
    
    
    __weak typeof(self)weakSelf = self;
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@(148));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.imgV.mas_bottom).offset(20);
        make.left.bottom.right.equalTo(self);
    }];
    
    [self upDataFrame];
    
}


#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        WFLabelCell * cell = [WFLabelCell cornerCellWithTableView:tableView];
        cell.label.text = self.Conttent;
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#1B1200"];
        cell.label.font = [UIFont boldSystemFontOfSize:11];
        cell.label.textAlignment = NSTextAlignmentLeft;
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(39.5, 25, 33, 25) maskedCorners: kCALayerMinXMinYCorner| kCALayerMaxXMinYCorner cornerRadius:0.1];
        return cell;
    }else{

        WFBtnCell * cell = [WFBtnCell cellWithTableView:tableView];
        [cell.btn setTitle:@"Resolicitar todo" forState:UIControlStateNormal];
        cell.btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        WF_WEAKSELF(weakself);
        [cell setClickBtnBlock:^{
            if(weakself.clickBtnBlock){
                weakself.clickBtnBlock(0);
            }
        }];
        [cell.btn addLinearGradientwithSize:CGSizeMake(self.jk_width - 50, 50) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:13];
        [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(0, 15, 20, 15) height:50];
        return cell;
        
//        WFLeftRightBtnCell * cell = [WFLeftRightBtnCell cellWithTableView:tableView];
//        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 20, 0) height:50];
//        [cell.leftBtn setTitle:@"Regresar" forState:UIControlStateNormal];
//        [cell.leftBtn setTitleColor:[UIColor jk_colorWithHexString:@"#FC7500"]  forState:UIControlStateNormal];
//        cell.leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
//        cell.leftBtn.layer.cornerRadius = 13;
//        cell.leftBtn.layer.masksToBounds = YES;
//        cell.leftBtn.layer.borderWidth = 1;
//        cell.leftBtn.layer.borderColor = BColor_Hex(@"#FC7500", 1).CGColor;
//
//
//        [cell.rightBtn setText:@"Resolicitar todo" TextColor:BColor_Hex(@"#FFFFFF", 1) Font:[UIFont systemFontOfSize:13] forState:UIControlStateNormal];
//
//        [cell.rightBtn addLinearGradientwithSize:CGSizeMake((self.jk_width - 41)/2, 50) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:13];
//
//        [cell.leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@(15));
//            make.top.equalTo(@(0));
//            make.bottom.equalTo(@(0));
//            make.width.equalTo(@((self.jk_width - 41)/2));
//
//        }];
//
//        [cell.rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(@(-15));
//            make.top.equalTo(@(0));
//            make.bottom.equalTo(@(0));
//            make.left.equalTo(cell.leftBtn.mas_right).offset(11);
//            make.width.equalTo(@((self.jk_width - 41)/2));
//
//
//        }];
//
//        WF_WEAKSELF(weakself);
//        [cell setClickBtnBlock:^(NSInteger indx) {
//            if(weakself.clickBtnBlock){
//                weakself.clickBtnBlock(indx);
//            }
//
//        }];
//        return cell;
    }
    
    
}



#pragma mark -- init

-(UIImageView *)imgV{
    if(_imgV == nil){
        _imgV = [[UIImageView alloc]init];
        _imgV.image = [UIImage imageNamed:@"repaymentSuc"];
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

        CGFloat height = self.tableView.contentSize.height + 148 + 20;
       
        if (self.jk_height != height){
            self.jk_height = height;

            
        }
    });

}
    
    

@end
