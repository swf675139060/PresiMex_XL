////
////  JKPickerViewAppearance.m
////  OPESO
////
////  Created by 撒旦二哈 on 2021/10/22.
////
//
//#define   BACK_HEIGHT  55.5+180+10+45+15
//
//
//typedef void(^dataBlock)(id responseObjct,NSInteger indx);
//
//
//#import "JKPickerViewAppearance.h"
//
//@interface JKPickerViewAppearance ()<JKPickerViewDelegate>
//
//@property (nonatomic, copy) dataBlock dataBlock;
//@property (nonatomic, strong) UIView *backView;
//@property (nonatomic, strong) JKPickerView *dataPicker;
//@property (nonatomic, strong) UILabel *titleLabel;
//@property (nonatomic, strong) NSString *title;
//@property (nonatomic, assign) NSInteger row;
//@property (nonatomic, strong) NSArray *datas;
//@end
//
//@implementation JKPickerViewAppearance
//
//
//
//- (instancetype)initWithPickerViewTilte:(NSString*)tilte withData:(NSArray*)data pickerCompleteBlock:(void (^)(id responseObjct,NSInteger indx))completeBlock{
//    
//    self =[super init];
//    if (self) {
//       
//        [self setupUI:tilte withData:data];
//        self.frame = CGRectMake(0, 0, WF_ScreenWidth, WF_ScreenHeight);
//        _dataBlock = completeBlock;
//    }
//    return self;
//}
//
//- (void)setupUI:(NSString*)title withData:(NSArray*)data{
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
//    [self addGestureRecognizer:tap];
//    
//    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, WF_ScreenHeight, WF_ScreenWidth, BACK_HEIGHT)];
//    _backView.backgroundColor = [UIColor whiteColor];
//    
//    UIView *colorView=[UIView new];
//    colorView.backgroundColor =BColor_Hex(@"#F5F6FA", 1);
//    colorView.frame=CGRectMake(0, 0, WF_ScreenWidth, 44);
//    
//    
//    UIButton *canclBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 65, 44)];
//    [canclBtn setTitle:@"cancel" forState:UIControlStateNormal];
//    [canclBtn addTarget:self action:@selector(doneClick:) forControlEvents:UIControlEventTouchUpInside];
//    [canclBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [colorView addSubview:canclBtn];
//    canclBtn.titleLabel.font=[UIFont boldSystemFontOfSize:15];
//    canclBtn.tag=0;
//    
//    
//    UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(WF_ScreenWidth-65-10, 0, 65, 44)];
//   
//    [confirmBtn setTitle:@"Confirm" forState:UIControlStateNormal];
//    [confirmBtn addTarget:self action:@selector(doneClick:) forControlEvents:UIControlEventTouchUpInside];
//    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [colorView addSubview:confirmBtn];
//    confirmBtn.titleLabel.font=[UIFont boldSystemFontOfSize:15];
//    confirmBtn.tag=1;
//    
//    
//    UILabel *titleLabel=[UILabel new];
//    [colorView addSubview:titleLabel];
//    titleLabel.frame=CGRectMake(0, 12, WF_ScreenWidth, 20);
//    titleLabel.font=[UIFont systemFontOfSize:13];
//    titleLabel.textAlignment=NSTextAlignmentCenter;
//    _titleLabel=titleLabel;
//    _titleLabel.text=title;
//    
//    UIView *line=[UIView new];
//    line.backgroundColor=BColor_Hex(@"#E5E6E7",1);
//    line.frame=CGRectMake(0, colorView.swf_bottom, WF_ScreenWidth, 0.5);
//    [self.backView addSubview:line];
//    
//    UIView *pickerline=[UIView new];
//    pickerline.backgroundColor=BColor_Hex(@"#E5E6E7",1);
//    pickerline.frame=CGRectMake(40, 70, WF_ScreenWidth-80, 1);
//
//    UIView *pickerline1=[UIView new];
//    pickerline1.backgroundColor=BColor_Hex(@"#E5E6E7",1);
//    pickerline1.frame=CGRectMake(40, 110, WF_ScreenWidth-80, 1);
//  
//    _dataPicker=[[JKPickerView alloc] initWithDataPickerWithArr:data];
//    _dataPicker.frame = CGRectMake(0, line.swf_bottom, WF_ScreenWidth, 180);
//    _dataPicker.dvDelegate=self;
//    _dataPicker.backgroundColor=[UIColor whiteColor];
//    [_dataPicker addSubview:pickerline];
//    [_dataPicker addSubview:pickerline1];
//    _datas=data;
//   
//
//    
//    [self.backView addSubview:colorView];
//    [self.backView addSubview:_dataPicker];
//    [self addSubview:self.backView];
//}
//
//- (void)doneClick:(UIButton*)sender {
//    if (self.title.length==0&&self.datas.count) {
//        self.title=self.datas[0];
//        self.row=0;
//    }
//   
//    if (sender.tag==1) {
//        if (_dataBlock) {
//            _dataBlock(self.title,self.row);
//        }
//    }
//    [self hide];
//}
//
//
//- (void)show {
//    [[UIApplication sharedApplication].keyWindow addSubview:self];
//    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
//    [UIView animateWithDuration:0.25 animations:^{
//        self.backView.frame = CGRectMake(0, WF_ScreenHeight-(55.5+180+10+45+15), WF_ScreenWidth, BACK_HEIGHT);
//        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
//    }];
//}
//
//
//-(void)hide {
//    [UIView animateWithDuration:0.2 animations:^{
//        self.backView.frame = CGRectMake(0, WF_ScreenHeight, WF_ScreenWidth, BACK_HEIGHT);
//        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//    }];
//}
//
//
////
//-(void)datePicker:(JKPickerView *)datePicker didSelectedDate:(NSString *)title row:(NSInteger)row{
//
//    self.title=title;
//    self.row=row;
//}
//@end
