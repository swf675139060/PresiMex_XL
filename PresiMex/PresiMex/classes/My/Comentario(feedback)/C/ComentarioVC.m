//
//  ComentarioVC.m
//  PresiMex
//
//  Created by shenWenFeng on 2023/5/21.
//

#import "ComentarioVC.h"
#import "WFLabelCell.h"
#import "ProblemaCell.h"
#import "WFTextViewCell.h"
#import "SelectImageCell.h"

@interface ComentarioVC ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView *tableView; /**< 列表*/


@property (nonatomic, assign) NSInteger clickIndx;


@property (nonatomic, strong) NSString * textContent;


@property (nonatomic, strong) NSMutableArray * images;


@end

@implementation ComentarioVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
}


#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
        cell.label.text = @"Seleccione su tipo de problema:";
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#0B0B0B"];
        cell.label.font = [UIFont systemFontOfSize:14];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(15, 15, 6, 15)];
        return cell;
    }else if(indexPath.row == 1){
        ProblemaCell * cell = [ProblemaCell cellWithTableView:tableView];
        WF_WEAKSELF(weakself);
        cell.clickBlock = ^(NSInteger indx) {
            weakself.clickIndx = indx;
            [weakself.tableView reloadData];
        };
        [cell updataWithProblems:@[@"11",@"11",@"11",@"11",@"11",@"11",@"11",@"11"] selectIndx:self.clickIndx];
        return  cell;
    }else if (indexPath.row == 2){
        WFTextViewCell * cell  = [WFTextViewCell cellWithTableView:tableView];
        cell.BGView.layer.cornerRadius = 15;
        cell.BGView.layer.masksToBounds = YES;
        cell.BGView.layer.borderWidth = 0.5;
        cell.BGView.layer.borderColor = [UIColor jk_colorWithHexString:@"#7C7C7C"].CGColor;
        cell.textView.placeholder = @"Describa en detalle los problemas que encontró al usar el producto…";
        WF_WEAKSELF(weakself);
        [cell.textView addTextDidChangeHandler:^(SLFPlaceHolderTextView *textView) {
            weakself.textContent = textView.text;
        }];
        
        cell.textView.text = self.textContent;
        [cell upBGFrameWithInsets:UIEdgeInsetsMake(15, 15, 15, 15) ];
        [cell upTextViewFrameWithInsets:UIEdgeInsetsMake(14, 16.5, 14, 16.5) height:125];
        return cell;
    }else if (indexPath.row == 3){
        WFLabelCell * cell = [WFLabelCell cellWithTableView:tableView];
        NSString * String = @"Subir foto (5 al máximo)";
        
        NSString * subString0 = @"Subir foto ";
        NSString * subString1 = @"(5 al máximo)";
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:String];
        [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} range:[String rangeOfString:subString0]];
        [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} range:[String rangeOfString:subString1]];
        cell.label.attributedText = attributedString;
        cell.label.textColor = [UIColor jk_colorWithHexString:@"#333333"];
        [cell upLabelFrameWithInsets:UIEdgeInsetsMake(9.5, 15, 10, 15)];
        return cell;
    }else if (indexPath.row == 4){
        SelectImageCell * cell = [SelectImageCell cellWithTableView:tableView];
        [cell updataWithImages:self.images];
        WF_WEAKSELF(weakself);
        cell.selectImageBlock = ^{
            [weakself selectImage];
        };
        cell.imageChangeBlock = ^(NSArray * _Nonnull images) {
            weakself.images = images;
        };
        return cell;
    }
    
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    
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
        _tableView.backgroundColor  = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}



- (void)selectImage {
    // 创建UIImagePickerController
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
//    picker.allowsEditing = YES;
    
//    // 判断设备是否支持相机
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//
//        UIAlertAction *takeAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//            [self presentViewController:picker animated:YES completion:nil];
//        }];
//
//        UIAlertAction *chooseAction = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//            [self presentViewController:picker animated:YES completion:nil];
//        }];
//
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//
//        [alert addAction:takeAction];
//        [alert addAction:chooseAction];
//        [alert addAction:cancelAction];
//
//        [self presentViewController:alert animated:YES completion:nil];
//    } else {
        // 不支持相机，从相册中选择
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
//    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info{
    
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.images addObject:image];
    [self.tableView reloadData];
        // 关闭照片选择器
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(NSMutableArray *)images{
    if(_images == nil){
        _images = [NSMutableArray array];
    }
    return _images;
}
@end
