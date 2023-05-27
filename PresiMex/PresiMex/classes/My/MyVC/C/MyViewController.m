//
//  MyViewController.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/9.
//

#import "MyViewController.h"
#import "MyHeaderView.h"

#import "ComentarioVC.h"
#import "SobreVC.h"

#import "PMLoginViewController.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray<NSString *> *titles; /**< 标题*/

@property (nonatomic, copy) NSArray<NSString *> *CellImages; /**< 图片名*/



@property (nonatomic, strong) UITableView *tableView; /**< 列表*/
@property (nonatomic,strong) MyHeaderView *headerView; /**< 头*/

@property (nonatomic, assign) BOOL isShowDelete; /**< 是否显示注销账号按钮*/

@end


@implementation MyViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.headerView updataHeaderViewWithType:1];
    
}

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleDefault;
//}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
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
 
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushLoginVc];
    if(indexPath.row == 0){
        
    }else if (indexPath.row == 1){
        
    }else if (indexPath.row == 2){
        ComentarioVC * vc = [[ComentarioVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 3){
        
    }else if (indexPath.row == 4){
        SobreVC * vc = [SobreVC new];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 5){
        
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
@end
