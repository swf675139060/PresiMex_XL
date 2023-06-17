//
//  PMIDAuthViewController.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/30.
//

#import "PMIDAuthViewController.h"
#import "PMIDAuthModel.h"
#import "PMIDAuthViewCell.h"
#import "PMIDAuthTextViewCell.h"
#import "PMIDAuthHeaderView.h"
#import "PMBasicViewController.h"
#import "PHImagePickerController.h"

@interface PMIDAuthViewController ()<UITableViewDelegate,UITableViewDataSource,PHImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PMIDAuthViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitleLabel.text=@"Autenticación de identidad";
    [self addRightBarButtonWithImag:@"bai_kefu"];
    [self modelWithData];
    [self getCamearAuthSeletsAlert];
    //[self tableView];
    [self requestImagPic];
}
- (void)modelWithData{

    PMIDAuthModel *model1 = [[PMIDAuthModel alloc] init];
    model1.title     = @"Foto del frente de la tarjeta de identificación";
    model1.desTitle    = @"Haga clic para tomar la foto";
    model1.type=0;
    [self.dataArray addObject:model1];
    
    PMIDAuthModel *model2 = [[PMIDAuthModel alloc] init];
    model2.title     = @"Foto del dorso de la tarjeta de identificación";
    model2.desTitle    = @"Haga clic para tomar la foto";
    model2.type=1;
    [self.dataArray addObject:model2];
    
    PMIDAuthModel *model3 = [[PMIDAuthModel alloc] init];
    model3.title     = @"Autenticación biométrica";
    model3.desTitle    = @"Haga clic para la autenticación biométrica";
    model3.type=2;
    [self.dataArray addObject:model3];
    
    PMIDAuthModel *model4 = [[PMIDAuthModel alloc] init];
    model4.title     =@"Nombre";
    model4.type=3;
    model4.placeHold=@"Por favor llénelo";
    [self.dataArray addObject:model4];
    
    PMIDAuthModel *model5 = [[PMIDAuthModel alloc] init];
    model5.title     =@"Número de identificación";
    model5.type=4;
    model5.placeHold=@"Por favor llénelo";
    [self.dataArray addObject:model5];
  
    [self.tableView reloadData];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, WF_ScreenWidth, WF_ScreenHeight-WF_StatusBarHeight-WF_NavigationHeight-WF_BottomSafeAreaHeight)];
        [self.tempView addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.tableHeaderView=[UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 15.0, *)) {
            self.tableView.sectionHeaderTopPadding = 0;
        }
        [self setupHeadView];
        [self setupFootView];
        
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PMIDAuthModel *model=self.dataArray[indexPath.row];
    
    if (indexPath.row<3) {
        PMIDAuthViewCell *cell=[PMIDAuthViewCell cellWithTableView:tableView];
        [cell setCellWithModel:model];
        return cell;
    } else {
        PMIDAuthTextViewCell *cell=[PMIDAuthTextViewCell cellWithTableView:tableView];
        [cell setCellWithModel:model];
        return cell;
    }
   
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row<3) {
        return 208;
    } else {
        return 64;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        [self selectPhoto];
    } else {
        
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}
-(void)setupHeadView{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, 165)];
    headerView.backgroundColor=[UIColor whiteColor];
    PMIDAuthHeaderView *header = [[PMIDAuthHeaderView alloc] initViewWithType:1];
    [headerView addSubview:header];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.numberOfLines = 0;
    tipLabel.text=@"Consejo: asegúrese de que todas las imágenes de los documentos se tomen con claridad y sean las más recientes para obtener el préstamo al instante.";
    [headerView addSubview:tipLabel];
    tipLabel.textColor=BColor_Hex(@"#FFB602", 1);
    tipLabel.textAlignment = NSTextAlignmentLeft;
    tipLabel.font=B_FONT_REGULAR(11);
    CGSize size=[UILabel sizeWithText:tipLabel.text fontSize:11 andMaxsize:WF_ScreenWidth-30];
    tipLabel.frame = CGRectMake(15,header.swf_bottom+12,WF_ScreenWidth-30,size.height);
    
    self.tableView.tableHeaderView=headerView;
    
}
-(void)setupFootView{
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth, 110)];
    footer.backgroundColor=[UIColor whiteColor];
    
    UIButton* submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.tag=1;
    submitBtn.frame = CGRectMake(15,30,WF_ScreenWidth-30,50);
    [submitBtn setTitle:@"Próximo paso" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(clickSubmitBtn) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.layer.cornerRadius=13;
    submitBtn.layer.masksToBounds=YES;
    [footer addSubview:submitBtn];
    [submitBtn addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth - 30, 50) withColors:@[(id)[UIColor jk_colorWithHexString:@"#FFB602"].CGColor,(id)[UIColor jk_colorWithHexString:@"#FC7500"].CGColor] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:13];
    self.tableView.tableFooterView=footer;
}

-(void)clickSubmitBtn{
    PMBasicViewController*Vc=[PMBasicViewController new];
    [self.navigationController pushViewController:Vc animated:YES];
}

-(void)selectPhoto{
    if ([self canUserCamear]) {
        PHImagePickerController*vc=[PHImagePickerController  new];
        vc.delegate=self;
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:vc animated:YES completion:nil];
    }
}
//#pragma mark - 检查相机权限
-(BOOL)canUserCamear{
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Please open camera permissions" message:@"Settings - Privacy - Camera" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *enAction=[UIAlertAction actionWithTitle:@"Setting" style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * _Nonnull action) {
            
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
         [[UIApplication sharedApplication] openURL:url];
        }
        }];
        UIAlertAction *action_cancel=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:enAction];
        [alert addAction:action_cancel];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    else{
        return YES;
    }
    return YES;
 
}

-(void)getCamearAuthSeletsAlert{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
    }];

}

//点击拍证件照片
-(void)clickIDCardCamera{
    
    if ([self canUserCamear]) {
        PHImagePickerController*vc=[PHImagePickerController  new];
        vc.delegate=self;
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:vc animated:YES completion:nil];
    }
}
//点击证件照片的拍照回调
-(void)customImagePickerController:(PHImagePickerController *)picker didFinishPickingImage:(UIImage *)image{
    image = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationUp];
    
    if (image!=nil) {
        UIImage *im=[UIImage imageNamed:@"moxi1.jpg"];
        [self submitPhoto:im withType:@"1" withSelType:@"1"];
    }
   
}

-(void)requestImagPic{
    
    [self show];
    NSMutableDictionary*dict=[NSMutableDictionary new];

    [PMBaseHttp get:GET_OCR_USER_INFO parameters:dict success:^(id  _Nonnull responseObject) {
        [self dismiss];
        if ([responseObject[@"retail"]intValue]==200) {
            PMIDAuthModel*model=[PMIDAuthModel yy_modelWithDictionary:responseObject[@"shame"]];
            PMIDAuthModel*model1=self.dataArray[0];
            model1.held=model.held;
            [self.dataArray replaceObjectAtIndex:0 withObject:model1];
            PMIDAuthModel*model2=self.dataArray[1];
            model2.silent=model.silent;
            [self.dataArray replaceObjectAtIndex:1 withObject:model2];
            PMIDAuthModel*model3=self.dataArray[2];
            model3.acoustic=model.acoustic;
            [self.dataArray replaceObjectAtIndex:2 withObject:model3];
            PMIDAuthModel*model4=self.dataArray[3];
            model4.cartoon=model.cartoon;
            [self.dataArray replaceObjectAtIndex:3 withObject:model4];
            PMIDAuthModel*model5=self.dataArray[4];
            model5.cartoon=model.cartoon;
            [self.dataArray replaceObjectAtIndex:4 withObject:model4];
            [self.tableView reloadData];
        } else {
            
        }
        NSLog(@"%@",responseObject);
    } failure:^(NSError * _Nonnull error) {
        [self dismiss];
        NSLog(@"%@",error);
    }];
}

-(void)submitPhoto:(UIImage*)img withType:(NSString*)type withSelType:(NSString*)selType{
    
    [self show];
    NSMutableDictionary*dict=[NSMutableDictionary new];
    dict[@"monroe"]=type;//类型 1:正面 2:反面
    dict[@"router"]=selType;//1:拍照,2:相册上传
    [PMBaseHttp uploadImg:img parameter:dict success:^(id  _Nonnull responseObject) {
        NSLog(@"证件照==%@",responseObject);
        [self dismiss];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"证件照==%@",error);
        
    }];
}
@end
