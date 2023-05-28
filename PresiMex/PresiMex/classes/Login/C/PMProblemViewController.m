//
//  PMProblemViewController.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/28.
//

#import "PMProblemViewController.h"

@interface PMProblemViewController ()

@end

@implementation PMProblemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarView.hidden=YES;
    self.tempView.hidden=YES;
    self.view.backgroundColor = [BColor_Hex(@"#000000",1) colorWithAlphaComponent:0.6];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [self.view addGestureRecognizer:tap];
}

-(void)hide{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
