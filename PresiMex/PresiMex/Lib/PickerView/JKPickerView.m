////
////  JKPickerView.m
////  OPESO
////
////  Created by 撒旦二哈 on 2021/10/22.
////
//#define LABEL_TAG 43
//#import "JKPickerView.h"
//
//@interface JKPickerView ()
//
//@property(strong ,nonatomic) NSArray *dataArr;
//@end
//
//
//@implementation JKPickerView
//
//-(instancetype)initWithDataPickerWithArr:(NSArray*)data
//{
//    if (self = [super init])
//    {
//        [self loadDefaultsParameters:data];
//       
//    }
//    return self;
//}
//
//-(void)loadDefaultsParameters:(NSArray*)data
//{
//    
//    self.dataArr =data;
//    self.delegate = self;
//    self.dataSource = self;
//    [self selectRow:self.dataArr.count inComponent:0 animated:YES];
//    if (self.subviews.count>0) {
//        self.subviews[1].backgroundColor = [UIColor clearColor];
//    }
//    
//    
//    
//}
//#pragma mark - UIPickerViewDelegate
//-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
//{
//    return 1;
//}
//-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
//{
//    return self.dataArr.count;
//}
//
//-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
//{
//    return 40;
//}
//
//-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    NSString*title=[self.dataArr objectAtIndex:row];
//    return title;
//  
//    
//}
//
//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    NSString*title=[self.dataArr objectAtIndex:row];
//    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:title];
//
//    [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, title.length)];
//    return attributedText;
//}
//-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//{
//    
//   
//    if ([self.dvDelegate respondsToSelector:@selector(datePicker:didSelectedDate:row:)]) {
//        [self.dvDelegate datePicker:self didSelectedDate:self.dataArr[row] row:row];
//        
//    }
//    
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//@end
