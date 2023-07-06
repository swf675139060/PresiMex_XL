//
//  OrderCell.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/27.
//

#import "OrderCell.h"

@interface OrderCell()

@property(strong, nonatomic) UIView * BGView;


@property(strong, nonatomic) UIView * topBGview;

@property(strong, nonatomic) UIView * centerBGView;

@property(strong, nonatomic) UIView * bottomBGView;

@property(strong, nonatomic) UIImageView * userIcon;

@property(strong, nonatomic) UILabel * userName;

@property(strong, nonatomic) UIButton * PagarBtn;//支付

@property(strong, nonatomic) UILabel * moneyStr;

@property(strong, nonatomic) UILabel * moneynumber;

@property(strong, nonatomic) UILabel * dateSre;

@property(strong, nonatomic) UILabel * dateNumber;

@property(strong, nonatomic) UIView * line;

@property(strong, nonatomic) UILabel * stateLB;

@property(assign, nonatomic)NSInteger indx;
@end

@implementation OrderCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *ID = @"OrderCell";
    
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell creatSubView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


-(void)creatSubView{
    [self.contentView addSubview:self.BGView];
    
    [self.BGView jk_shadowWithColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:0.5000] offset:CGSizeMake(0,1) opacity:1 radius:5];
    [self.BGView addSubview:self.topBGview];
    [self.BGView addSubview:self.centerBGView];
    [self.BGView addSubview:self.bottomBGView];
    [self.topBGview addSubview:self.userIcon];
    [self.topBGview addSubview:self.userName];
    [self.topBGview addSubview:self.PagarBtn];
    
    
    [self.centerBGView addSubview:self.dateNumber];
    [self.centerBGView addSubview:self.dateSre];
    [self.centerBGView addSubview:self.moneynumber];
    [self.centerBGView addSubview:self.moneyStr];
    [self.centerBGView addSubview:self.line];
    
    
    [self.bottomBGView addSubview:self.stateLB];
    
    
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 15, 10, 15);
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
        
    }];
    
    [self.topBGview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.BGView);
        make.height.equalTo(@(50));
        
    }];
    
    [self.centerBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.BGView);
        make.top.equalTo(self.topBGview.mas_bottom);
        make.height.equalTo(@(85));
        
    }];
    [self.bottomBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.BGView);
        make.top.equalTo(self.centerBGView.mas_bottom);
        make.height.equalTo(@(34.5));
        
    }];
    
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topBGview);
        make.left.equalTo(@(15));
        make.width.height.equalTo(@(36));
        
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topBGview);
        make.left.equalTo(self.userIcon.mas_right).offset(10);
        
    }];
    
    [self.PagarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topBGview);
        make.right.equalTo(@(-10));
        make.width.equalTo(@(115));
        make.height.equalTo(@(33));
        
    }];
    
    [self.moneyStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.centerBGView).offset(19);
        make.left.equalTo(@(15));
        
    }];
    
    [self.moneynumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyStr.mas_bottom).offset(10);
        make.left.equalTo(@(15));
        
    }];
    
    [self.dateSre mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.centerBGView).offset(19);
        make.right.equalTo(@(-15));
        
    }];
    
    [self.dateNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyStr.mas_bottom).offset(10);
        make.right.equalTo(@(-15));
        
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.centerBGView);
        make.height.equalTo(@(0.5));
        
    }];
    
    [self.stateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bottomBGView);
        make.left.equalTo(self.bottomBGView).offset(36);
        make.right.equalTo(self.bottomBGView).offset(-36);
        
    }];
    
    
}

-(UIView *)BGView{
    if(_BGView == nil){
        _BGView = [[UIView alloc] init];
        _BGView.backgroundColor = [UIColor whiteColor];
    }
    return _BGView;
}

-(UIView *)topBGview{
    if(_topBGview == nil){
        _topBGview = [[UIView alloc] init];
        
    }
    return _topBGview;
}
-(UIView *)centerBGView{
    if(_centerBGView == nil){
        _centerBGView = [[UIView alloc] init];
    }
    return _centerBGView;
}

-(UIView *)bottomBGView{
    if(_bottomBGView == nil){
        _bottomBGView = [[UIView alloc] init];
    }
    return _bottomBGView;
}

-(UIImageView *)userIcon{
    if(_userIcon == nil){
        _userIcon = [[UIImageView alloc] init];
        _userIcon.layer.cornerRadius = 5;
        _userIcon.layer.masksToBounds = YES;
    }
    return _userIcon;
}

-(UILabel *)userName{
    if(_userName == nil){
        _userName = [[UILabel alloc] init];
        _userName.numberOfLines = 0;
    }
    return _userName;
}

-(UIButton *)PagarBtn{
    if(_PagarBtn == nil){
        _PagarBtn = [[UIButton alloc] init];
        [_PagarBtn setTitleColor:[UIColor jk_colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        _PagarBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [_PagarBtn setTitle:@"Usar" forState:UIControlStateNormal];
        _PagarBtn.layer.cornerRadius = 12.5;
        _PagarBtn.layer.masksToBounds = YES;
        _PagarBtn.userInteractionEnabled = NO;
        
        [_PagarBtn addTarget:self action:@selector(clickUseBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _PagarBtn;
}

-(UILabel *)moneyStr{
    if(_moneyStr == nil){
        _moneyStr = [[UILabel alloc] init];
        _moneyStr.numberOfLines = 0;
        
        
    }
    return _moneyStr;
}

-(UILabel *)moneynumber{
    if(_moneynumber == nil){
        _moneynumber = [[UILabel alloc] init];
        
        
    }
    return _moneynumber;
}


-(UILabel *)dateSre{
    if(_dateSre == nil){
        _dateSre = [[UILabel alloc] init];
        _dateSre.numberOfLines = 2;
        
        
    }
    return _dateSre;
}

-(UILabel *)dateNumber{
    if(_dateNumber == nil){
        _dateNumber = [[UILabel alloc] init];
        
        
    }
    return _dateNumber;
}


-(UIView *)line{
    if(_line == nil){
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor jk_colorWithHexString:@"#DDDDDD"];
    }
    return _line;
}
-(UILabel *)stateLB{
    if(_stateLB == nil){
        _stateLB = [[UILabel alloc] init];
        _stateLB.textAlignment = NSTextAlignmentCenter;
        
    }
    return _stateLB;
}



-(void)clickUseBtn{
    if(self.clickUseBlock){
        self.clickUseBlock(self.indx);
    }
}

-(void)updataWithModel:(OrderModel *)model indx:(NSInteger)indx;{
    self.indx = indx;
    
    [_userName setText:model.nu TextColor:[UIColor jk_colorWithHexString:@"#D74257"] Font:[UIFont systemFontOfSize:13]];
    [_userIcon sd_setImageWithURL:[NSURL URLWithString:model.engage] placeholderImage:nil];
    [_PagarBtn setBackgroundColor:[UIColor jk_colorWithHexString:@"#FF0000"]];
    
    [_moneyStr setText:@"Monto del préstamo" TextColor:[UIColor jk_colorWithHexString:@"#1B1200"] Font:[UIFont systemFontOfSize:11]];
    [_moneynumber setText:model.barbie TextColor:[UIColor jk_colorWithHexString:@"#1B1200"] Font:[UIFont boldSystemFontOfSize:20]];
    [_dateSre setText:@"Monto del préstamo" TextColor:[UIColor jk_colorWithHexString:@"#1B1200"] Font:[UIFont systemFontOfSize:11]];
    [_dateNumber setText:model.cook TextColor:[UIColor jk_colorWithHexString:@"#1B1200"] Font:[UIFont boldSystemFontOfSize:20]];
    [self.PagarBtn setTitle:@"Reembolsado" forState:UIControlStateNormal];
    [self.stateLB setText:@"" TextColor:[UIColor jk_colorWithHexString:@"#7C7C7C"] Font:[UIFont systemFontOfSize:11]];
    
    
    
  
    int type = 3;
    //订单状态 0-待审核 10-审核中 20-审核通过 30-审核失败 40-放款中 50-待还款 60-放款失败 70-已还款 80-展期中 90-已逾期 100取消贷款
    if([model.lexus integerValue] == 90){
        //过期，红色
        self.topBGview.backgroundColor = [[UIColor jk_colorWithHexString:@"#FF0000"] colorWithAlphaComponent:0.1];
        [self.PagarBtn setBackgroundColor:[UIColor jk_colorWithHexString:@"#FF0000"]];
        self.stateLB.textColor = [UIColor jk_colorWithHexString:@"#FF0000"];
        
        [self.PagarBtn setTitle:@"Pagar" forState:UIControlStateNormal];
        self.stateLB.text = @"5 días de mora";
    }else if ([model.lexus integerValue] == 50){
        // 绿色  :等待付款
        self.topBGview.backgroundColor = [[UIColor jk_colorWithHexString:@"#00CB69"] colorWithAlphaComponent:0.1];
        [self.PagarBtn setBackgroundColor:[UIColor jk_colorWithHexString:@"#00D36D"]];
        self.stateLB.textColor = [UIColor jk_colorWithHexString:@"#00CB69"];
        
        [self.PagarBtn setTitle:@"Pagar" forState:UIControlStateNormal];
        self.stateLB.text = @"Esperando pago";
    }else if ([model.lexus integerValue] == 60){
        //橘黄色:银行帐户错误，请修改并重试
        self.topBGview.backgroundColor = [[UIColor jk_colorWithHexString:@"#FC7500"] colorWithAlphaComponent:0.1];
        [self.PagarBtn setBackgroundColor:[UIColor jk_colorWithHexString:@"#FC7500"]];
        self.stateLB.textColor = [UIColor jk_colorWithHexString:@"#FC7500"];
        
        [self.PagarBtn setTitle:@"Retirar de nuevo" forState:UIControlStateNormal];
        self.stateLB.text = @"Error de cuenta bancaria, modifíquelo e inténtelo de nuevo";
    }else if ([model.lexus integerValue] == 20 || [model.lexus integerValue] == 30 || [model.lexus integerValue] == 40){
        //橘黄色:耐心等待/支付中
        self.topBGview.backgroundColor = [[UIColor jk_colorWithHexString:@"#FC7500"] colorWithAlphaComponent:0.1];
        [self.PagarBtn setBackgroundColor:[UIColor jk_colorWithHexString:@"#FC7500"]];
        self.stateLB.textColor = [UIColor jk_colorWithHexString:@"#FC7500"];
        
        [self.PagarBtn setTitle:@"Desembolso" forState:UIControlStateNormal];
        self.stateLB.text = @"Espere pacientemente";
    }else if ([model.lexus integerValue] == 0 || [model.lexus integerValue] == 10){
        //橘黄色:耐心等待/正在审查中
        self.topBGview.backgroundColor = [[UIColor jk_colorWithHexString:@"#FC7500"] colorWithAlphaComponent:0.1];
        [self.PagarBtn setBackgroundColor:[UIColor jk_colorWithHexString:@"#FC7500"]];
        self.stateLB.textColor = [UIColor jk_colorWithHexString:@"#FC7500"];
        
        [self.PagarBtn setTitle:@"Bajo revisión" forState:UIControlStateNormal];
        self.stateLB.text = @"Espere pacientemente";
    }else if ([model.lexus integerValue] == 100){
        //灰色:取消
        [_userName setTextColor:[UIColor jk_colorWithHexString:@"#1B1200"]];
    
        [_PagarBtn setBackgroundColor:[UIColor jk_colorWithHexString:@"#CCCCCC"]];

        [_moneyStr setTextColor:[UIColor jk_colorWithHexString:@"#7C7C7C"]];
        [_moneynumber setTextColor:[UIColor jk_colorWithHexString:@"#7C7C7C"]];
        [_dateSre setTextColor:[UIColor jk_colorWithHexString:@"#7C7C7C"]];
        [_dateNumber setTextColor:[UIColor jk_colorWithHexString:@"#7C7C7C"]];
        [self.stateLB setTextColor:[UIColor jk_colorWithHexString:@"#7C7C7C"]];
        
        self.topBGview.backgroundColor = [UIColor jk_colorWithHexString:@"#F5F5F5"];
        
        [self.PagarBtn setTitle:@"Cancelado" forState:UIControlStateNormal];
        self.stateLB.text = @"El pedido se ha cancelado debido a problemas bancarios. Por favor, inténtelo de nuevo.";
        
    }else if ([model.lexus integerValue] == 80){
        //灰色:取消
        [_userName setTextColor:[UIColor jk_colorWithHexString:@"#1B1200"]];
    
        [_PagarBtn setBackgroundColor:[UIColor jk_colorWithHexString:@"#CCCCCC"]];

        [_moneyStr setTextColor:[UIColor jk_colorWithHexString:@"#7C7C7C"]];
        [_moneynumber setTextColor:[UIColor jk_colorWithHexString:@"#7C7C7C"]];
        [_dateSre setTextColor:[UIColor jk_colorWithHexString:@"#7C7C7C"]];
        [_dateNumber setTextColor:[UIColor jk_colorWithHexString:@"#7C7C7C"]];
        [self.stateLB setTextColor:[UIColor jk_colorWithHexString:@"#7C7C7C"]];
        
        self.topBGview.backgroundColor = [UIColor jk_colorWithHexString:@"##F5F5F5"];
        
        [self.PagarBtn setTitle:@"Extendido" forState:UIControlStateNormal];
        self.stateLB.text = [NSString stringWithFormat:@"Tiempo pagado %@",model.resorts];
        
    }else if ([model.lexus integerValue] == 70){
        //灰色:取消
        [_userName setTextColor:[UIColor jk_colorWithHexString:@"#1B1200"]];
    
        [_PagarBtn setBackgroundColor:[UIColor jk_colorWithHexString:@"#CCCCCC"]];

        [_moneyStr setTextColor:[UIColor jk_colorWithHexString:@"#7C7C7C"]];
        [_moneynumber setTextColor:[UIColor jk_colorWithHexString:@"#7C7C7C"]];
        [_dateSre setTextColor:[UIColor jk_colorWithHexString:@"#7C7C7C"]];
        [_dateNumber setTextColor:[UIColor jk_colorWithHexString:@"#7C7C7C"]];
        [self.stateLB setTextColor:[UIColor jk_colorWithHexString:@"#7C7C7C"]];
        
        self.topBGview.backgroundColor = [UIColor jk_colorWithHexString:@"##F5F5F5"];
        
        [self.PagarBtn setTitle:@"Reembolsado" forState:UIControlStateNormal];
        self.stateLB.text = [NSString stringWithFormat:@"Tiempo pagado %@",model.resorts];
        
    }
    
    
    
}
@end
