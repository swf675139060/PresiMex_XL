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
    
    if(indexPath.row == 0){
        PMQuestionnaireViewController*vc=[PMQuestionnaireViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        
    }else if (indexPath.row == 2){
        ComentarioVC * vc = [[ComentarioVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 3){
        
    }else if (indexPath.row == 4){
        SobreVC * vc = [SobreVC new];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 5){
        
        AjustesVC * vc = [AjustesVC new];
        [self.navigationController pushViewController:vc animated:YES];
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
                    @"Acuerdo de privacida",
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
}

//获取用户当前状态
//-(void)requestUserState{
//    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
//
//    WF_WEAKSELF(weakself);
//    [PMBaseHttp get:Get_User_Status parameters:pars success:^(id  _Nonnull responseObject) {
//        if ([responseObject[@"retail"] intValue]==200) {
//            NSInteger fare = [responseObject[@"fare"] integerValue];
//            if(fare == 71 || fare > 72){
//                //授信通过
//                weakself.UserStatePass = YES;
//                [weakself.headerView updataHeaderViewWithType:2];
//            }else{
//                weakself.UserStatePass = NO;
//                [weakself.headerView updataHeaderViewWithType:1];
//            }
//
//        }
//
////        用户当前状态 10:注册完成, 20:问卷调查完成 30:kyc完成, 40:基本信息完成, 50:联系人完成,60:账户完成, 70:授信中, 71:授信通过, 72:授信拒绝 80:交易验证, 81:交易验证部分通过, 82:交易验证拒绝 83:交易验证通过, 84:放款失败需要处理'
//
//
//    } failure:^(NSError * _Nonnull error) {
//
//    }];
//}

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
            
        }else{
            
//            [SLFToast showWithContent:responseObject[@"entire"] afterDelay:2];
            weakself.model = nil;
            [weakself.headerView updataHeaderViewWithModel:weakself.model];
            [weakself.tableView reloadData];
        }
        
        
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
-(void)pushCerVc{
    PMCertificationCoreViewController*vc=[PMCertificationCoreViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
