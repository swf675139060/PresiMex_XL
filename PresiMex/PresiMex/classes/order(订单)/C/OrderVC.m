//
//  OrderVC.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/27.
//

#import "OrderVC.h"
#import "PMOrderTopView.h"
#import "OrderCell.h"
#import "OrderModel.h"
#import "OrderDetailsVC.h"
#import "ConfirmAccountVC.h"
#import "HomeDetailView.h"

@interface OrderVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/

@property (nonatomic, strong) PMOrderTopView *topView;


@property (nonatomic, strong) NSMutableArray *leftArr;

@property (nonatomic, strong) NSMutableArray *rightArr;

@property (nonatomic, assign) NSInteger indx;

@property (nonatomic, assign) NSInteger requestCount;

@property (nonatomic,strong) HomeDetailView * detailView;//付款界面

@end

@implementation OrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tempView addSubview:self.topView];
    WF_WEAKSELF(weakself);
    [self.topView setClickLeftBtnBlock:^{
        weakself.indx = 0;
        [weakself.tableView reloadData];
        
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq03_bill_no_repay_order content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
        
        
    }];
    [self.topView setClickRightBtnBlock:^{
        weakself.indx = 1;
        [weakself.tableView reloadData];
        
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq03_bill_repay_order content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
    }];
    [self.tempView addSubview:self.tableView];
    self.navTitleLabel.text = @"Lista de facturas";
    
    
    [self.view show];
    [self GETUserOder:0];
    
    
    [self GETUserOder:1];
    PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_bill content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
    [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.view show];
    [self GETUserOder:0];
    
    
    [self GETUserOder:1];
}


#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.indx == 0) {
        return  self.leftArr.count;
    } else {
        return  self.rightArr.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OrderCell * cell = [OrderCell cellWithTableView:tableView];
    OrderModel * model;
    if (self.indx == 0) {
        model = self.leftArr[indexPath.row];
    } else {
        model = self.rightArr[indexPath.row];
    }
    [cell updataWithModel:model indx:indexPath.row];

    cell.clickUseBlock = ^(NSInteger indx) {

    };
    
    return cell;
   
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [tableView deselectRowAtIndexPath:indexPath animated:true];
    OrderModel * model;
    if (self.indx  == 0) {
        model = self.leftArr[indexPath.row];
    }else{
        model = self.rightArr[indexPath.row];
    }
    
    if([model.lexus integerValue] == 50){
        OrderDetailsVC * vc = [[OrderDetailsVC alloc] init];
        vc.repayId = model.prairie;
        vc.beOverdue = NO;
        
        [self.navigationController pushViewController:vc animated:YES];
        
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq03_bill_to_repay content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
         [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];

    }else if ([model.lexus integerValue] == 90){
        OrderDetailsVC * vc = [[OrderDetailsVC alloc] init];
        vc.repayId = model.prairie;
        vc.beOverdue = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq03_bill_to_repay content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
         [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];

    }else if ([model.lexus integerValue] == 60){
        //橘黄色:银行帐户错误，请修改并重试
        ConfirmAccountVC * VC = [[ConfirmAccountVC alloc] init];
        //            VC.bankModel = bankModel;
        VC.orderModel = model;
        VC.reLoan = YES;
        //            WF_WEAKSELF(weakself);
        //            VC.clickConfirmBlock = ^(bankcardModel * _Nonnull bankModel) {
        //                [weakself GETUserOder:0];
        //                [weakself GETUserOder:1];
        //            };
        [self.navigationController pushViewController:VC animated:YES];
        
        
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq03_bill_draw_money_again content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
         [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];

    }
    //    }
    
}


#pragma mark - DZNEmptyDataSetSource
// 返回图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"beiju"];
}

// 返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"Oportunidades";
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:14.0f], NSForegroundColorAttributeName: BColor_Hex(@"#1B1200", 1)};
    return [[NSAttributedString alloc] initWithString:text attributes:attribute];
}

// 返回详情文字
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView { NSString *text = @"Todavía no tiene ninguna factura para procesar. Vaya a la página de préstamo y elija su producto.";
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:12.0f], NSForegroundColorAttributeName: BColor_Hex(@"#7C7C7C", 1), NSParagraphStyleAttributeName: paragraph};
    return [[NSAttributedString alloc] initWithString:text attributes:attribute];
}

// 返回可以点击的按钮 上面带文字
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f], NSForegroundColorAttributeName: BColor_Hex(@"#FFFFFF", 1)};
    return [[NSAttributedString alloc] initWithString:@"DE ACUERDO" attributes:attribute];
}

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{

    return [UIView gradientImageWithSize:CGSizeMake(WF_ScreenWidth - 30, 50) startColor:BColor_Hex(@"#FFB602", 1) endColor:BColor_Hex(@"#FC7500", 1) cornerRadius:13];
}


//#pragma mark - DZNEmptyDataSetDelegate
// 处理按钮的点击事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    
        [self.tabBarController setSelectedIndex:0];
        
        [self.navigationController popToRootViewControllerAnimated:NO];

    
    
//    //                weakself.view.bounds
//    self.detailView = [[HomeDetailView alloc] initWithFrame: CGRectMake(0, 0, WF_ScreenWidth, WF_ScreenHeight - WF_TabBarHeight)];
//    //                UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    [self.view addSubview:self.detailView ];
//    // 点击修改银行卡
//    WF_WEAKSELF(weakself);
//    [self.detailView  setClickBankBlock:^(bankcardModel * _Nonnull bankModel) {
//
//        ConfirmAccountVC * VC = [[ConfirmAccountVC alloc] init];
//        VC.bankModel = bankModel;
//
//        VC.clickConfirmBlock = ^(bankcardModel * _Nonnull bankModel) {
//            weakself.detailView.bankModel = bankModel;
//            [weakself.detailView.tableView reloadData];
//        };
//        [weakself.navigationController pushViewController:VC animated:YES];
//    }];
//    // 提交借款
//    [self.detailView setClickNextBlock:^(BOOL success) {
//        [weakself POSTLoanApply];
//
//    }];
}

//24002 借款申请
//-(void)POSTLoanApply{
//    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
//
//    pars[@"detailed"] = self.homeModel.building;
//
//    NSMutableArray * duringArr = [NSMutableArray array];
//    for (PMHomeProductModel * model in self.homeModel.pledge) {
//
//        NSMutableDictionary * duringDic = [NSMutableDictionary dictionary];
//        duringDic[@"demanding"] = model.demanding;
//        duringDic[@"madison"] = model.flip;
//        [duringArr addObject:duringDic];
//    }
//    pars[@"during"] = duringArr;
//
//    WF_WEAKSELF(weakself);
//    [self show];
//    [PMBaseHttp postJson:POST_Loan_Apply parameters:pars success:^(id  _Nonnull responseObject) {
//
//        [weakself dismiss];
//        if ([responseObject[@"retail"] intValue]==200) {
////            NSDictionary * shame = responseObject[@"shame"];
//
////            [weakself GetUserOderStatus];
//            [weakself getConfigModel];
//
//
//        }else{
//            [weakself showLoanFailAlert];
////            [weakself showTip:responseObject[@"entire"]];//（对）
//        }
//
//    } failure:^(NSError * _Nonnull error) {
//        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
//        [weakself dismiss];
//
//    }];
//}
// 标题文字与详情文字的距离
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 15;
}

// 返回空白区域的颜色自定义
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor whiteColor];
}

// 标题文字与详情文字同时调整垂直偏移量
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -50;
}


#pragma mark -- init
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, WF_ScreenWidth, WF_ScreenHeight - WF_NavigationHeight - 70)];
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

-(PMOrderTopView *)topView{
    if(_topView == nil){
        _topView = [[PMOrderTopView alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, 70)];
        [_topView selectIndx:0];
    }
    return _topView;
}

-(NSMutableArray *)leftArr{
    if(_leftArr == nil){
        _leftArr = [NSMutableArray array];
    }
    return _leftArr;
}

-(NSMutableArray *)rightArr{
    if(_rightArr == nil){
        _rightArr = [NSMutableArray array];
    }
    return _rightArr;
}


//获取用户订单接口
-(void)GETUserOder:(NSInteger)indx{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
  
    if (indx == 0) {
        pars[@"cos"] = @"0";
    } else {
        pars[@"cos"] = @"1";
    }
    WF_WEAKSELF(weakself);
    [PMBaseHttp get:GET_User_Oder parameters:pars success:^(id  _Nonnull responseObject) {
        
        weakself.requestCount += 1;
        if(self.requestCount >= 2){
            [weakself.view dismiss];
        }
        if ([responseObject[@"retail"] intValue]==200) {
            NSArray * pledge = responseObject[@"shame"][@"pledge"];
            NSArray *modelArr = [OrderModel mj_objectArrayWithKeyValuesArray:pledge];
            if (indx == 0) {
                weakself.leftArr = [NSMutableArray arrayWithArray:modelArr];
                
            } else {
                weakself.rightArr = [NSMutableArray arrayWithArray:modelArr];
            }
            
            [weakself.tableView reloadData];
            
            
        }else{
            [weakself.view showTipC:responseObject[@"entire"]];
        }
        
        
        
    } failure:^(NSError * _Nonnull error) {
        
        [weakself.view dismiss];
    }];
}
@end
