//
//  PMTextField.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/6/3.
//

#import "PMTextField.h"

@interface PMTextField ()<UITextFieldDelegate>



@end

@implementation PMTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = self;
        [self addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //比对文本是否和上次一直
    NSString *text = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (self.endEditingHandler) {
        self.endEditingHandler(text);
    }
    
    
    NSString * endtime = [PMACQInfoModel GetTimestampString];
    self.duration = [endtime doubleValue]  - [self.beginTime doubleValue];
   
}

-(void)textFieldTextChange:(UITextField *)textField{
    
    if (self.maxCount != 0) {
        if ([self.text length] >= self.maxCount) {
            self.text = [self.text substringToIndex:self.maxCount];
        }
    }
    
    if (self.changeHandler) {
        self.changeHandler(textField.text);
    }
    
      
  
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (!self.beginTime) {
        self.beginTime = [PMACQInfoModel GetTimestampString];
    }
}



@end
