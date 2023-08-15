//
//  MyViewController.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/9.
//

#import "MyViewController.h"
#import "MyHeaderView.h"

#import "ComentarioVC.h"//反馈
#import "SobreVC.h"//关于我们
#import "AjustesVC.h"//设置
#import "CuponVC.h"//优惠卷
#import "OrderVC.h"//  订单
#import "KeFuVC.h"
#import "PMLoginViewController.h" //登录页面
#import "PMQuestionnaireViewController.h"//调查问卷

#import "PMAuthModel.h"
#import "PMCertificationCoreViewController.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray<NSString *> *titles; /**< 标题*/

@property (nonatomic, copy) NSArray<NSString *> *CellImages; /**< 图片名*/



@property (nonatomic, strong) UITableView *tableView; /**< 列表*/
@property (nonatomic,strong) MyHeaderView *headerView; /**< 头*/

@property (nonatomic, assign) BOOL UserStatePass;//授信是否通过

@property (nonatomic, assign) BOOL isShowDelete; /**< 是否显示注销账号按钮*/
@property (nonatomic,strong) PMAuthModel * model;//用户信息
@end


@implementation MyViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    
    
    WF_WEAKSELF(weakself);
    self.headerView.clickLoginBlock = ^{

        if (![PMAccountTool isLogin]) {
            [weakself pushLoginVc];
            
            
        }else{
//            if([weakself.model.shop integerValue] == 20){
//
//            }
            [weakself pushCerVc];
        }
       
       
    };
    
    self.headerView.clickLeftBtnBlock = ^{
        OrderVC *vc = [[OrderVC alloc] init];
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    self.headerView.clickRightBtnBlock = ^{
        
        CuponVC *vc = [[CuponVC alloc] init];
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    
   
    
}

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleDefault;
//}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    NSLog(@"%@",[PMAccountTool account].token);
    if([PMAccountTool isLogin]){
        [self GETUserAuthInfo];
    }else{
        [self.headerView updataHeaderViewWithModel:self.model];
        [self.tableView reloadData];
        
        //我的未登录 页面
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_mine_no_login content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}



#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = self.titles[indexPath.row];
    cell.textLabel.textColor = [UIColor jk_colorWithHexString:@"#1B1200"];
    cell.imageView.image = [UIImage imageNamed:self.CellImages[indexPath.row]];
//    let arrowImageView = UIImageView(image: UIImage(named: "custom_arrow"))
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (![PMAccountTool isLogin]) {
        [self pushLoginVc];
        return;
    }
    
    if(indexPath.row == 0){
        //评分
        [[PMConfigManager sharedInstance] gotoStore];

    }else if (indexPath.row == 1){
        // 隐私协议
        WFWebViewController * vc = [[WFWebViewController alloc] init];
        vc.urlString = H5_privacy;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 2){
        //反馈
        ComentarioVC * vc = [[ComentarioVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 3){
        //客服
        KeFuVC * vc = [[KeFuVC alloc] init];
            vc.urlString = H5_help;
            [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 4){
        //关于我们
        
            WFWebViewController * vc = [[WFWebViewController alloc] init];
            vc.urlString = H5_weAre;
            [self.navigationController pushViewController:vc animated:YES];
        
        
        
        //关于我们页
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_about_us content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
//        SobreVC * vc = [SobreVC new];
//        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 5){
        //设置
        AjustesVC * vc = [AjustesVC new];
        [self.navigationController pushViewController:vc animated:YES];
        
        
        //设置页 
        PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_setting content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
        [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
    }

    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    [_headerView scrollViewDidScrolling:scrollView.contentOffset.y];
}

#pragma mark -- init
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        _tableView.backgroundColor  = [UIColor whiteColor];
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

- (MyHeaderView *)headerView
{
    if (!_headerView) {
        
        _headerView = [[MyHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        
        [_headerView updataHeaderViewWithModel:self.model];
    }
    
    return _headerView;
}

- (NSArray<NSString *> *)titles
{
    if (!_titles) {
        _titles = @[@"Calificar",
                    @"Acuerdo de privacidad",
                    @"Comentario",
                    @"Asistencia",
                    @"Sobre nosotros",
                    @"Ajustes",
        ];

    }
    
    return _titles;
}


- (NSArray<NSString *> *)CellImages
{
    if (!_CellImages) {
        _CellImages = @[@"pingfenshezhi_h",
                    @"yinsixieyi",
                    @"fankui",
                    @"duihua",
                    @"guanyuwomen",
                    @"shezhi"
        ];

    }
    
    return _CellImages;
}
-(void)pushLoginVc{
    
    PMLoginViewController*Vc=[PMLoginViewController new];
    [self.navigationController pushViewController:Vc animated:YES];
    
    //待登录按钮点击
    PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq03_mine_wait_to_login content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
    [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
}


//获取用户授信信息
-(void)GETUserAuthInfo{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
  
    WF_WEAKSELF(weakself);
    [PMBaseHttp get:GET_User_Auth_Info parameters:pars success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"retail"] intValue]==200) {
            NSDictionary * shame = responseObject[@"shame"];
            
            PMAuthModel * model = [PMAuthModel mj_objectWithKeyValues:shame];
            
            weakself.model = model;
            [weakself.headerView updataHeaderViewWithModel:weakself.model];
            [weakself.tableView reloadData];
            
            if ([model.shop intValue] == 20) {
                //我的授信成功 页面
                PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_mine_credit_succ content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
                [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
            } else {
                //我的登录未验证完成 页面
                PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq01_mine_login_no_auth content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
                [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];
            }
            
        }else{
            
//            [SLFToast showWithContent:responseObject[@"entire"] afterDelay:2];
            weakself.model = nil;
            [weakself.headerView updataHeaderViewWithModel:weakself.model];
            [weakself.tableView reloadData];
        
            [weakself dismiss];
            [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
    } failure:^(NSError * _Nonnull error) {
        [weakself dismiss];
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        
    }];
}
-(void)pushCerVc{
    PMCertificationCoreViewController*vc=[PMCertificationCoreViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    //待认证按钮点击
    PMACQInfoModel * InfoModel = [[PMACQInfoModel alloc] initWithIdName:acq03_mine_wait_to_auth content:@"" beginTime:[PMACQInfoModel GetTimestampString] Duration:0];
    [[PMDotManager sharedInstance] POSTDotACQ50Withvalue: InfoModel];

}
@end
