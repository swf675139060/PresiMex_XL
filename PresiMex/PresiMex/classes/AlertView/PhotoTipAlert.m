//
//  PhotoTipAlert.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/24.
//

#import "PhotoTipAlert.h"
#import "WFLeftRightBtnCell.h"
#import "WFImageCell.h"
#import "WFBtnCell.h"
#import "WFLabelCell.h"

@interface PhotoTipAlert()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/

@property (nonatomic, assign) NSInteger type;

@end
@implementation PhotoTipAlert


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
    
    if(indexPath.row == 0){
        
        WFLeftRightBtnCell * cell = [WFLeftRightBtnCell cellWithTableView:tableView];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(20, 5, 25, 5) height:20];
        [cell.leftBtn setTitle:@"" forState:UIControlStateNormal];
      
        [cell.leftBtn setImage:[UIImage imageNamed:@"zhengque"] forState:UIControlStateNormal];
        [cell.rightBtn setText:@"Ejemplo correcto" TextColor:BColor_Hex(@"#A8A8A8", 1) Font:[UIFont systemFontOfSize:11] forState:UIControlStateNormal];
        cell.rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
       
        [cell.rightBtn sizeToFit];
        CGFloat width = cell.rightBtn.bounds.size.width;
        [cell.leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@((WF_ScreenWidth - width - 20 - 60 - 10)/2));
            make.top.equalTo(@(0));
            make.bottom.equalTo(@(0));
            make.width.equalTo(@(20));

        }];
        
        [cell.rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(@(0));
            make.bottom.equalTo(@(0));
            make.width.equalTo(@(width));
            make.left.equalTo(cell.leftBtn.mas_right).offset(10);
            
        }];
       
        return cell;
    }else if (indexPath.row == 1) {
        WFImageCell * cell = [WFImageCell cellWithTableView:tableView];
        
        cell.bottomLine.hidden = YES;
        if (self.type == 0) {
            
            cell.imgV.image = [UIImage imageNamed:@"ren1"];
            [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(0, 27.5, 20, 27.5) height:122];
        } else if (self.type == 1) {

            cell.imgV.image = [UIImage imageNamed:@"ren2"];
            [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(0, 27.5, 20, 27.5) height:122];
        }else{
            
            cell.imgV.image = [UIImage imageNamed:@"ren3"];
            [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(0, 27.5, 20, 27.5) height:150];
        }
        return cell;
    }else if (indexPath.row == 2){
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
        
        if (self.type == 0) {
            cell.label.text = @"Coloque la tarjeta de identificación en un lugar plano.";
        } else if (self.type == 1) {
            cell.label.text = @"Coloque la tarjeta de identificación en un lugar plano.";
        }else{
            cell.label.text = @"Asegúrese de que su rostro esté enmarcado correctamente en la cámara y que la iluminación sea adecuada.";
        }
        cell.label.textAlignment = NSTextAlignmentLeft;
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#1B1200"];
        cell.label.font = [UIFont systemFontOfSize:12];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(0, 40, 0, 40)];
        return cell;
    }else {
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
        [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(25, 25, 20, 25) height:50];
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
