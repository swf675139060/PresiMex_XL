//
//  FeedBackAlert.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/3.
//

#import "FeedBackAlert.h"
#import "WFBtnCell.h"
#import "WFImageCell.h"
#import "WFLabelCell.h"

@interface FeedBackAlert()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/


@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSArray * titleArr;


@end


@implementation FeedBackAlert


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
        self.titleArr = @[@"Envio exitoso",@"Comentarios recibidosnos pondremos en contacto consigo pronto.",@"OK"];
    } else {
        self.titleArr = @[@"Envio fallido",@"Error al enviar comentarios, intentelo de nuevo.",@"OK"];
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
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#1B1200"];
        cell.label.font = [UIFont boldSystemFontOfSize:20];
        cell.label.textAlignment = NSTextAlignmentCenter;
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(20, 29, 20, 29)];
        return cell;
    }else if (indexPath.row == 1){
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
        cell.label.text = self.titleArr[indexPath.row];
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#1B1200"];
        cell.label.font = [UIFont systemFontOfSize:13];
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(0, 25, 0, 25)];
        return cell;
    }else{
        WFBtnCell * cell = [WFBtnCell cellWithTableView:tableView];
        [cell.btn setTitle:self.titleArr[indexPath.row] forState:UIControlStateNormal];
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
