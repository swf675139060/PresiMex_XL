//
//  PMEmergencyContactViewController.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/6/3.
//

#import "PMEmergencyContactViewController.h"
#import "BasicDataModel.h"
#import "PMEmergencyContactModel.h"
#import "PMEmergencyContactCell.h"
#import "PMIDAuthHeaderView.h"

#import "PMAddBankViewController.h"

#import <ContactsUI/ContactsUI.h>


@interface PMEmergencyContactViewController ()<UITableViewDelegate,UITableViewDataSource,CNContactPickerDelegate>

@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;


@property (nonatomic, assign) NSInteger curentIndx;//通讯录

@end

@implementation PMEmergencyContactViewController



-(void)modelWithData{
    
    
    RelaciónDataModel * dataModel = [RelaciónDataModel new];
    [dataModel initData];
    
    _dataArray = [NSMutableArray array];
    PMEmergencyContactModel *relationModel = [[PMEmergencyContactModel alloc] init];
    relationModel.title=@"Contacto de emergencia 1";
    relationModel.type  =@"0";
    relationModel.contentArr = dataModel.Relación;
    
    [_dataArray addObject:relationModel];
    
    
    PMEmergencyContactModel *relationModel1 = [[PMEmergencyContactModel alloc] init];
    relationModel1.title=@"Contacto de emergencia 2";
    //relationModel1.relation =[self setInitStringWithKey:PS_EmContact_Relation2]; ;
    relationModel1.type  =@"1";
    relationModel1.contentArr = dataModel.Relación;
    //relationModel1.name   = [self setInitStringWithKey:PS_EmContact_Relation_Name2];
   // relationModel1.telephone= [self setInitStringWithKey:PS_EmContact_Relation_Number2];
    [_dataArray addObject:relationModel1];
    [self.tableView reloadData];
}
   

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitleLabel.text=@"Información del personal";
    [self addRightBarButtonWithImag:@"bai_kefu"];
    [self modelWithData];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, WF_ScreenWidth,WF_ScreenHeight-WF_StatusBarHeight-WF_NavigationHeight-WF_BottomSafeAreaHeight)];
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
        [self setupFootView];
        [self setupHeadView];
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
    
    PMEmergencyContactModel *model=self.dataArray[indexPath.row];
    PMEmergencyContactCell *cell=[PMEmergencyContactCell cellWithTableView:tableView];
    [cell setCellWithModel:model];
    WF_WEAKSELF(weakself);
    cell.inputBlock = ^(NSString * _Nonnull content,NSInteger type) {
        model.telephone = content;
    };
    
    cell.guanXiClickBlock = ^(NSInteger type) {
        [weakself sutupAlertViewWithIndx:type];
    };
    cell.tongXunLUClickBlock = ^(NSInteger type) {
        weakself.curentIndx = type;
        [weakself selectPersonContactPickerVc];
    };
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 235;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
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
    PMIDAuthHeaderView *header = [[PMIDAuthHeaderView alloc] initViewWithType:3];
    [headerView addSubview:header];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.frame = CGRectMake(15,12,WF_ScreenWidth,36);
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


-(void)sutupAlertViewWithIndx:(NSInteger)indxP{
    [self.view endEditing:YES];
    
    
    NSMutableArray * arr = [NSMutableArray array];
    PMEmergencyContactModel * model = self.dataArray[indxP];
    
    for (BasicDataModel * dataModel in model.contentArr) {
        [arr addObject:dataModel.title];
    }
    
    weakify(self);
    JKPickerViewAppearance *alert=[[JKPickerViewAppearance alloc] initWithPickerViewTilte:model.title withData:arr pickerCompleteBlock:^(id  _Nonnull responseObjct,NSInteger indx) {
        strongify(self);
        PMEmergencyContactModel * model = self.dataArray[indxP];
        model.indx = indx;
       
        [self.tableView reloadData];

    }];
    [alert show] ;
}



#pragma mark - 先弹出联系人控制器
-(void)selectPersonContactPickerVc{
    
    // 1. 创建控制器
    CNContactPickerViewController * picker = [CNContactPickerViewController new];
    
    picker.delegate = self;
    picker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController: picker  animated:YES completion:nil];
}

// 1.选择联系人时使用（不展开详情）
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    
    NSString *name = [CNContactFormatter stringFromContact:contact style:CNContactFormatterStyleFullName];
    NSArray * phoneNums = contact.phoneNumbers;
    CNLabeledValue *labelValue = phoneNums.firstObject;
    NSString *phoneValue = [labelValue.value stringValue];
    NSString *phoneStr = [phoneValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@"+63" withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@"+52" withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@"(" withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@")" withString:@""];
    if(phoneStr && phoneStr.length){
        
        PMEmergencyContactModel * model = self.dataArray[self.curentIndx];
        model.telephone = phoneStr;
    }else{
        
        PMEmergencyContactModel * model = self.dataArray[self.curentIndx];
        model.telephone = @"";
    }
    [self.tableView reloadData];
    
    
    
//    if(([phoneStr hasPrefix:@"9"]|[phoneStr hasPrefix:@"09"]|[phoneStr hasPrefix:@"639"]|[phoneStr hasPrefix:@"0639"]|[phoneStr hasPrefix:@"8"]|[phoneStr hasPrefix:@"08"]|[phoneStr hasPrefix:@"638"]|[phoneStr hasPrefix:@"0638"])){
//        //[self setupContactWithName:name withPhone:phoneStr withType:self.secetion];
//    }else{
//        [self showTip:@"Please fill in the valid emergency contact information,we will contact them randomly for verification !"];
//        return;
//    }
    
}


-(void)clickSubmitBtn{
    
    
    PMEmergencyContactModel * model0 = self.dataArray[0];
    if(model0.indx < 0){
        [self showTip:@"Seleccione la relación con el contacto."];
        return;
    }else if( !model0.telephone || model0.telephone.length == 0){
        [self showTip:@"Seleccione un contacto."];
        return;
    }
    
    PMEmergencyContactModel * model1 = self.dataArray[1];
    
    if(model1.indx < 0){
        //请选择联系人关系
        [self showTip:@"Seleccione la relación con el contacto."];
        return;
    }else if( !model1.telephone || model1.telephone.length == 0){
        //请选择联系人
        [self showTip:@"Seleccione un contacto."];
        return;
    }else if([model1.telephone isEqualToString:model0.telephone]){
        //紧急联系人不能为同一个
        [self showTip:@"Los contactos de emergencia no pueden ser los mismos."];
        return;
    }
    
    [self POSTContactsInfo];
}

-(void)POSTContactsInfo{

    
    NSMutableDictionary *pars1=[NSMutableDictionary dictionary];
    PMEmergencyContactModel * model1 = self.dataArray[0];
    BasicDataModel * dataModel1 = model1.contentArr[model1.indx];
    pars1[@"univ"] = [NSNumber numberWithLong:dataModel1.ID];//与用户本人关系
    pars1[@"schedules"] = model1.telephone;//联系方式
    
    
    NSMutableDictionary *pars2=[NSMutableDictionary dictionary];
    PMEmergencyContactModel * model2 = self.dataArray[1];
    BasicDataModel * dataModel2 = model2.contentArr[model2.indx];
    pars2[@"rental"] = [NSNumber numberWithLong:dataModel2.ID];//性别:
    pars2[@"schedules"] = model2.telephone;//联系方式
   
    
    [self show];
    WF_WEAKSELF(weakself);
    [PMBaseHttp postJson:POST_Contacts_Info parameters:@[pars1,pars2] success:^(id  _Nonnull responseObject) {
        [weakself dismiss];
        if ([responseObject[@"retail"] intValue]==200) {
            
            
            PMAddBankViewController*vc=[PMAddBankViewController new];
            [weakself.navigationController pushViewController:vc animated:YES];
            
        }else{
            [weakself showTip:responseObject[@"entire"]];//（对）
        }
        
    } failure:^(NSError * _Nonnull error) {
        [weakself showTip:@"Por favor, inténtelo de nuevo más tarde"];
        [weakself dismiss];
        
    }];
    
}
@end
