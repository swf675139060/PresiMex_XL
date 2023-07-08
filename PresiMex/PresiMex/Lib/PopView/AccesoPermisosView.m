//
//  AccesoPermisosView.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/7/8.
//

#import "AccesoPermisosView.h"
#import "WFLabelCell.h"
#import "WFBtnCell.h"

@interface AccesoPermisosView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/

@end

@implementation AccesoPermisosView

-(void)setTitles:(NSArray *)titles{
    _titles = titles;
    [self.tableView reloadData];
    
    CGFloat height = MIN(112- 19 + (titles.count/2 - 1) * 85 + 90 + WF_BottomSafeAreaHeight, WF_ScreenHeight - WF_NavigationHeight);
    self.frame = CGRectMake(0, 0, WF_ScreenWidth, height);
}

-(void)buildSubViews{
    NSArray * titles = @[
        @"Acceso a permisos",
        @"Para que pueda disfrutar de nuestros servicios de alta calidad,obtendremos los siguientes permisos de su teléfono móvil.",
        @"Permisos de ubicació",//定位
        @"Para que pueda disfrutar de nuestro servicio de alta calidad,obtendremos los siguientes permisos de su teléfono móvil.",
        @"Permisos fotográficos",//照片
        @"Configurar información y fotos de avatares",
        @"Permisos de la Cámara",//相机
        @"Configurar información y fotos de avatares",
        @"Permisos de libreta de direcciones",//通讯录
        @"Al acceder a la libreta de direcciones, el objetivo es ayudarnos a ofrecerle un mejor servicio."
    ];
    self.titles = titles;
    
    
    [self addSubview:self.tableView];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(self);
    }];
}


#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count  + 1;
}

//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 44;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 40;
    } else if (indexPath.row == 1) {
        return 15 + 38;
    } else if (indexPath.row == 2) {
        return 19 + 18;
    }else if (indexPath.row == 3) {
        return 10 + 38;
    } else if (indexPath.row == 4) {
        return 19 + 18;
    }else if (indexPath.row == 5) {
        return 10 + 38;
    }else if (indexPath.row == 6) {
        return 19 + 18;
    }else if (indexPath.row == 7) {
        return 10 + 38;
    }else if (indexPath.row == 8) {
        return 19 + 18;
    }else if (indexPath.row == 9) {
        return 10 + 38;
    }else{
        return 90;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
   
    cell.label.textAlignment = NSTextAlignmentLeft;
    cell.label.adjustsFontSizeToFitWidth = YES;
    if (indexPath.row == 0) {
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(22, 13, 0, 13)];
        [cell.label setText:self.titles[indexPath.row] TextColor:BColor_Hex(@"#1B1200", 1) Font:[UIFont boldSystemFontOfSize:18]];
    } else if (indexPath.row == 1) {
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(15, 13, 0, 13)];
        [cell.label setText:self.titles[indexPath.row] TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:12]];
    } else if (indexPath.row == 2) {
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(19, 13, 0, 13)];
        [cell.label setText:self.titles[indexPath.row] TextColor:BColor_Hex(@"#1B1200", 1) Font:[UIFont boldSystemFontOfSize:18]];
    }else if (indexPath.row == 3) {
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(10, 13, 0, 13)];
        [cell.label setText:self.titles[indexPath.row] TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:12]];
    } else if (indexPath.row == 4) {
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(19, 13, 0, 13)];
        [cell.label setText:self.titles[indexPath.row] TextColor:BColor_Hex(@"#1B1200", 1) Font:[UIFont boldSystemFontOfSize:18]];
    }else if (indexPath.row == 5) {
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(10, 13, 0, 13)];
        [cell.label setText:self.titles[indexPath.row] TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:12]];
    }else if (indexPath.row == 6) {
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(19, 13, 0, 13)];
        [cell.label setText:self.titles[indexPath.row] TextColor:BColor_Hex(@"#1B1200", 1) Font:[UIFont boldSystemFontOfSize:18]];
    }else if (indexPath.row == 7) {
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(10, 13, 0, 13)];
        [cell.label setText:self.titles[indexPath.row] TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:12]];
    }else if (indexPath.row == 8) {
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(19, 13, 0, 13)];
        [cell.label setText:self.titles[indexPath.row] TextColor:BColor_Hex(@"#1B1200", 1) Font:[UIFont boldSystemFontOfSize:18]];
    }else if (indexPath.row == 9) {
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(10, 13, 0, 13)];
        [cell.label setText:self.titles[indexPath.row] TextColor:BColor_Hex(@"#333333", 1) Font:[UIFont systemFontOfSize:12]];
    }else if (indexPath.row == 10) {
        WFBtnCell * cell = [WFBtnCell cellWithTableView:tableView];
        [cell.btn setTitle:@"OK" forState:UIControlStateNormal];
        cell.btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        WF_WEAKSELF(weakself);
        [cell setClickBtnBlock:^{
            [PrivateInfo requestContactAuthor];
            [PrivateInfo requestPhotoAuthor];
            [PrivateInfo requestMediaStatusAuthor];
            [PrivateInfo requestLocationAuthor];
            
            if(weakself.selectBlock){
                weakself.selectBlock();
            }
        }];
        [cell.btn addLinearGradientwithSize:CGSizeMake(self.jk_width - 30, 50) maskedCorners:kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner cornerRadius:13];
        [cell updateFrameWithEdgeInsets:UIEdgeInsetsMake(15, 15, 25, 15) height:50];
        return cell;
    }
    
    
    cell.bottomLine.hidden = YES;
    return cell;
   
    
    
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

@end
