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
#import "LNDetectViewController.h"
#import "liveSetModel.h"
#import "LiveStartModel.h"

#import "LNDetector.h"
#import "PhotoTipAlert.h"
#import "AllFailAlert.h"

@interface PMIDAuthViewController ()<UITableViewDelegate,UITableViewDataSource,PHImagePickerControllerDelegate,DetectViewControllerDelegate>

@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) liveSetModel *LiveSetModel;

@property (nonatomic, strong) LiveStartModel *LiveSTModel;
//
@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *userID;

@property (nonatomic, strong) UIImage *livenessBitmap;//活体认证照片





@end

@implementation PMIDAuthViewController

-(void)leftItemAction{
    [self shoWYouHuiAlert:@[]];
}

//arr:优惠卷数组
-(void)shoWYouHuiAlert:(NSArray *)arr{
    
    
    CGFloat biLi = WF_ScreenWidth/360;
    
    YouHuiAlert * alert = [[YouHuiAlert alloc] initWithFrame:CGRectMake(0, 0, biLi * 320, biLi * 400) withArr:arr] ;
 
    WFCustomAlertView *  AlertView = [[WFCustomAlertView alloc] initWithContentView:alert];
    
    [AlertView show];
    WF_WEAKSELF(weakself);
    [alert setClickBtnBlock:^(NSInteger indx) {
        [AlertView dismiss];
        if (indx == 0) {
            [weakself.navigationController popViewControllerAnimated:YES];
//            NSArray *viewControllers = weakself.navigationController.viewControllers;
//            for (UIViewController *viewController in viewControllers) {
//                if ([viewController isKindOfClass:[PMCertificationCoreViewController class]]) {
//                    [weakself.navigationController popToViewController:viewController animated:YES];
//                    break;
//                }
//            }
        } else {
            
        }
    }];
}
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
    [self GETOftenCharged];
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
     
        WF_WEAKSELF(weakself);
        [cell setEndEditingHandler:^(NSString * _Nonnull title, NSString * _Nonnull text) {
            if (indexPath.row == 3) {
                //名字
                weakself.userName = text;
            } else {
                //号码
                weakself.userID = text;
            }
        }];
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
    
   
    
    [self showPhotoTipAlert:indexPath.row];
    
}


//   显示照片提示弹出框
-(void)showPhotoTipAlert:(NSInteger)type{
    PhotoTipAlert * alert = [[PhotoTipAlert alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth - 60, 331) withType:type] ;
    WFCustomAlertView *  AlertView = [[WFCustomAlertView alloc] initWithContentView:alert];
    [AlertView show];
    WF_WEAKSELF(weakself);
    [alert setClickBtnBlock:^{
        [AlertView dismiss];
        
        if (type==0) {
            [weakself selectPhoto];
        } else if (type==1) {
            [weakself selectBackPhoto];
        }else if (type==2) {
            [weakself POSTORCAUTH];
        }else{
            
        }
    }];
}

//   显示照片 失败弹出框
-(void)showAllFailAlert:(NSInteger)type{
    
    NSString *content;
    if (type==0) {
        content = @"El sistema no pudo reconocer el frente de la tarjeta de identificación, tome otra foto.";
    } else if (type==1) {
        content = @"Falló el reconocimiento del sistema en el reverso de la tarjeta de identificación, tome otra foto.";
    }else if (type==2) {
        content = @"La comparación en vivo falló, inténtalo de nuevo.";
    }else{
        
    }
    AllFailAlert * alert = [[AllFailAlert alloc] initWithFrame:CGRectMake(0, 0, WF_ScreenWidth - 60, 210) withTitle:@"Asegúrese de tener suficiente luz en el entorno, sin obstrucciones ni sobreexposiciones." content:content];
    WFCustomAlertView *  AlertView = [[WFCustomAlertView alloc] initWithContentView:alert];
    [AlertView show];
    WF_WEAKSELF(weakself);
    [alert setClickBtnBlock:^{
        [AlertView dismiss];
        
    }];
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
    [submitBtn addTarget:self action:@selector(POSTOcrKYC) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.layer.cornerRadius=13;
    submitBtn.layer.masksToBounds=YES;
    [footer addSubview:submitBtn];
    [submitBtn addLinearGradientwithSize:CGSizeMake(WF_ScreenWidth - 30, 50) withColors:@[(id)[UIColor jk_colorWithHexString:@"#FFB602"].CGColor,(id)[UIColor jk_colorWithHexString:@"#FC7500"].CGColor] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:13];
    self.tableView.tableFooterView=footer;
}

-(void)clickNextBtn{
    
    
    PMBasicViewController*Vc=[PMBasicViewController new];
    [self.navigationController pushViewController:Vc animated:YES];
}

-(void)selectPhoto{
    if ([self canUserCamear]) {
        PHImagePickerController*vc=[PHImagePickerController  new];
        vc.type = 0;
        vc.delegate=self;
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:vc animated:YES completion:nil];
    }
}

-(void)selectBackPhoto{
    if ([self canUserCamear]) {
        PHImagePickerController*vc=[PHImagePickerController  new];
        vc.type = 1;
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

//点击证件照片的拍照回调
-(void)customImagePickerController:(PHImagePickerController *)picker didFinishPickingImage:(UIImage *)image{
    image = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationUp];
    
    if (image!=nil) {
        //        image=[UIImage imageNamed:@"moxi1.jpg"];
        if (picker.type == 0) {
            [self submitPhoto:image withType:@"1" withSelType:@"1"];
        } else {
            [self submitPhoto:image withType:@"2" withSelType:@"1"];
        }
    }
    
}


//跳转活体认证界面
- (void)pushLNDetectViewController:(NSString *)userID {
    LNDetectViewController *vc = [[LNDetectViewController alloc] initWithNibName:@"LNDetectViewController" bundle:nil];
    vc.userID = @"testios1";//TODO
    [self.navigationController pushViewController:vc animated:NO];
    vc.delegate = self;
}

- (void)detectFailed:(LivenessFailResult*) result {
    //TODO
//    [self.tableView reloadData];
    [self showAllFailAlert:2];
}

- (void)detectSuccess:(LivenessSuccessResult*) result {
    //TODO
    //验证活体
    
    self.livenessBitmap = result->livenessBitmap;
    [self POSTLIFEQuery:result->livenessId img:result->livenessBitmap];
//    PMIDAuthModel * model = self.dataArray[2];
//    model.acousticImage = result->livenessBitmap;
//    model.livenessId = result->livenessId;
//    model.livenessBitmapBase64Str = result->livenessBitmapBase64Str;
//
//
//    [self.tableView reloadData];
}

//15002 - Ocr回显接口(类型合并+活体照+字段)
-(void)requestImagPic{
    
    [self show];
    NSMutableDictionary*dict=[NSMutableDictionary new];
    WF_WEAKSELF(weakself);
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
            model4.davis=model.davis;
            self.userName = model.davis;
            [self.dataArray replaceObjectAtIndex:3 withObject:model4];
            PMIDAuthModel*model5=self.dataArray[4];
            model5.cartoon=model.cartoon;
            self.userID = model.cartoon;
            [self.dataArray replaceObjectAtIndex:4 withObject:model5];
            [self.tableView reloadData];
        }  else{
            [weakself dismiss];
            [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
    } failure:^(NSError * _Nonnull error) {
        [weakself dismiss];
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        
    }];
}

//上传身份证
-(void)submitPhoto:(UIImage*)img withType:(NSString*)type withSelType:(NSString*)selType{
    
    [self show];
    NSMutableDictionary*dict=[NSMutableDictionary new];
    dict[@"monroe"]=type;//类型 1:正面 2:反面
    dict[@"router"]=selType;//1:拍照,2:相册上传
    WF_WEAKSELF(weakself);
    [PMBaseHttp uploadImg:img parameter:dict type:1 success:^(id  _Nonnull responseObject) {
        
        [weakself dismiss];
        NSLog(@"证件照==%@",responseObject);
        
        if ([responseObject[@"retail"] intValue] == 200) {
            
            PMIDAuthModel*model=[PMIDAuthModel yy_modelWithDictionary:responseObject[@"shame"]];
            
//            PMIDAuthModel*model3=self.dataArray[2];
//            model3.acoustic=model.acoustic;
//            [self.dataArray replaceObjectAtIndex:2 withObject:model3];
            
            if ([type integerValue] == 1) {
                
                PMIDAuthModel*model1=weakself.dataArray[0];
                model1.heldImage = img;
                model1.held=model.held;
                [weakself.dataArray replaceObjectAtIndex:0 withObject:model1];
                
                PMIDAuthModel*model4=self.dataArray[3];
                model4.davis=model.davis;
                self.userName = model.davis;
                [self.dataArray replaceObjectAtIndex:3 withObject:model4];
                PMIDAuthModel*model5=self.dataArray[4];
                model5.cartoon=model.cartoon;
                self.userID = model.cartoon;
                [self.dataArray replaceObjectAtIndex:4 withObject:model5];
            } else {
                PMIDAuthModel*model2=weakself.dataArray[1];
                model2.silent=model.silent;
                model2.silentImage = img;
                [weakself.dataArray replaceObjectAtIndex:1 withObject:model2];
            }
            [weakself.tableView reloadData];
        }else{
            
            if ([type integerValue] == 1) {
                [weakself showAllFailAlert:0];
            }else{
                [weakself showAllFailAlert:1];
            }
        }
        
        
    } failure:^(NSError * _Nonnull error) {
        
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        [weakself dismiss];
        NSLog(@"证件照==%@",error);
        
    }];
}


//15003 - 开始进行活体
-(void)POSTORCAUTH{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
    pars[@"copies"]= self.LiveSetModel.copies;
    
    [self show];
    WF_WEAKSELF(weakself);
    [PMBaseHttp post:POST_ORC_AUTH parameters:pars success:^(id  _Nonnull responseObject) {
        [weakself dismiss];
        if ([responseObject[@"retail"] intValue]==200) {
        
            NSDictionary * shame = responseObject[@"shame"];
            weakself.LiveSTModel = [LiveStartModel mj_objectWithKeyValues:shame];
            
            [weakself pushLNDetectViewController:weakself.LiveSTModel.versions];
            
        }else{
            [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
    } failure:^(NSError * _Nonnull error) {
        
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        [weakself dismiss];
        
    }];
    
}


//15004 - 活体照上传,提交KYC
-(void)POSTOcrKYC{
    if (!self.LiveSTModel.shaw || self.LiveSTModel.shaw.length == 0) {
        [self showTip:@"Tome la foto primero"];
        return;
    } else
        if(!self.userName || self.userName.length == 0){
        [self showTip:@"Verifique los campos obligatorios."];
        return;
    } else if(!self.userID || self.userID.length == 0){
        [self showTip:@"Verifique los campos obligatorios."];
        return;
    }
    
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
    pars[@"perspective"]= self.userName;//用户名字
    pars[@"cartoon"]= self.userID;//身份证号
    pars[@"expiration"]= self.LiveSTModel.shaw;//活体照片
    
    [self show];
    WF_WEAKSELF(weakself);
    [PMBaseHttp postJson:POST_Ocr_KYC parameters:pars success:^(id  _Nonnull responseObject) {
        [weakself dismiss];
        if ([responseObject[@"retail"] intValue]==200) {
            [weakself clickNextBtn];
        }else{
            [weakself showTip:responseObject[@"entire"]];//（对）
            
        }
        
    } failure:^(NSError * _Nonnull error) {
        
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        [weakself dismiss];
        
    }];
    
}

//15005 - 活体结果查询
-(void)POSTLIFEQuery:(NSString *)passion img:(UIImage *)img{
  
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
    pars[@"passion"]= passion;//
    pars[@"versions"]= self.LiveSTModel.versions;//
    
    WF_WEAKSELF(weakself);
    [PMBaseHttp uploadImg:img parameter:pars type:2 success:^(id  _Nonnull responseObject) {
        [weakself dismiss];
        if ([responseObject[@"retail"] intValue]==200) {
            NSDictionary * shame = responseObject[@"shame"];
            weakself.LiveSTModel = [LiveStartModel mj_objectWithKeyValues:shame];
            
            
            PMIDAuthModel * model = weakself.dataArray[2];
            model.acousticImage = weakself.livenessBitmap;
            model.acoustic = weakself.LiveSTModel.shaw;
//            model.livenessId = result->livenessId;
//            model.livenessBitmapBase64Str = result->livenessBitmapBase64Str;
            
            
            [weakself.tableView reloadData];
        }else{
            [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"证件照==%@",error);
        
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        
    }];
    
//
//    [self show];
//    WF_WEAKSELF(weakself);
//    [PMBaseHttp postJson:POST_Ocr_KYC parameters:pars success:^(id  _Nonnull responseObject) {
//        [weakself dismiss];
//        if ([responseObject[@"retail"] intValue]==200) {
//            PMIDAuthModel * model = self.dataArray[2];
////            model.acousticImage = result->livenessBitmap;
////            model.livenessId = result->livenessId;
////            model.livenessBitmapBase64Str = result->livenessBitmapBase64Str;
//
//
//            [self.tableView reloadData];
//        }else{
//
//        }
//
//    } failure:^(NSError * _Nonnull error) {
//
//        [weakself dismiss];
//
//    }];
    
 
    
}



//15006 - 活体配置选择
-(void)GETOftenCharged{
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
    
    
    WF_WEAKSELF(weakself);
    [self show];
    [PMBaseHttp get:GET_often_charged parameters:pars success:^(id  _Nonnull responseObject) {
        [weakself dismiss];
        if ([responseObject[@"retail"] intValue]==200) {
            NSDictionary * shame = responseObject[@"shame"];
            weakself.LiveSetModel = [liveSetModel mj_objectWithKeyValues:shame];
            
            [LNDetector setAppName:weakself.LiveSetModel.jerry.barely partnerCode:weakself.LiveSetModel.jerry.physicians partnerKey:weakself.LiveSetModel.jerry.persian];
            
        }else{
            [weakself showTip:responseObject[@"entire"]];//（对）
        }
    } failure:^(NSError * _Nonnull error) {
        
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        [weakself dismiss];
    }];
    
}



@end
