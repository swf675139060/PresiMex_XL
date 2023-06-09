//
//  PHImagePickerController.m
//  PHPocket
//
//  Created by 王二麻子 on 2021/12/3.
//

#import "PHImagePickerController.h"
#import <AVFoundation/AVFoundation.h>


@interface PHImagePickerController ()<AVCaptureMetadataOutputObjectsDelegate>
//捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
@property(nonatomic)AVCaptureDevice *device;
//AVCaptureDeviceInput 代表输入设备，他使用AVCaptureDevice 来初始化
@property(nonatomic)AVCaptureDeviceInput *input;
//当启动摄像头开始捕获输入
@property(nonatomic)AVCaptureMetadataOutput *output;
@property (nonatomic)AVCaptureStillImageOutput *ImageOutPut;
//session：由他把输入输出结合在一起，并开始启动捕获设备（摄像头）
@property(nonatomic)AVCaptureSession *session;
//图像预览层，实时显示捕获的图像
@property(nonatomic)AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic)UIButton *PhotoButton;
@property (nonatomic)UIImageView *imageView;
@property (nonatomic)UIImage *image;
@property (nonatomic)UILabel*tipsLabel;
@property (nonatomic)UIView *maskImagView;
@property (nonatomic)BOOL canCa;
@property (nonatomic)UIButton *leftButton;
@property (nonatomic)UIButton *rightButton;
@end

@implementation PHImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    _canCa = [self canUserCamear];
    if (_canCa) {
        [self customCamera];
        [self customUI];
        
    }else{
        return;
    }
    
   
}
- (void)customUI{
    
    
//    UIImageView*img=[UIImageView new];
//    img.image=[UIImage imageNamed:@"icon_dotted_frame"];
//    img.frame=self.view.frame;
//    [self.view addSubview:img];
//    img.userInteractionEnabled=YES;
//    _maskImagView=img;
    
    // 创建一个 UIView 来实现半透明效果
    UIView *transparentView = [[UIView alloc] initWithFrame:self.view.bounds];
    transparentView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.view addSubview:transparentView];
    _maskImagView=transparentView;
    // 创建一个 CAShapeLayer 来绘制中间的全透明区域
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    CGFloat screenWidth = CGRectGetWidth(self.view.bounds);
    CGFloat screenHeight = CGRectGetHeight(self.view.bounds);
    CGFloat cardWidth = screenWidth - 105;
    CGFloat cardHeight = screenHeight - 240;
    CGFloat cardX = (screenWidth - cardWidth) / 2;
    CGFloat cardY = (screenHeight - cardHeight) / 2;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, screenWidth, screenHeight)];
    
    
    // 创建带有圆角的矩形路径
    CGFloat cornerRadius = 10.0;
    UIBezierPath *cardPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(cardX, cardY, cardWidth, cardHeight) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    [path appendPath:cardPath];
    
    [path setUsesEvenOddFillRule:YES];
    maskLayer.path = path.CGPath;
    maskLayer.fillRule = kCAFillRuleEvenOdd;
    maskLayer.fillColor = [UIColor blackColor].CGColor;
    maskLayer.opacity = 0.5;
    transparentView.layer.mask = maskLayer;
    
    
    
    
    
    _PhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _PhotoButton.frame = CGRectMake(45, WF_ScreenHeight-80, 60, 60);
    _PhotoButton.jk_centerX = self.view.jk_centerX;
    UIImage *imgBtn=[UIImage imageNamed:@"icon_photo_take"];
    [_PhotoButton setImage:imgBtn forState: UIControlStateNormal];
    [_PhotoButton setImage:imgBtn forState:UIControlStateNormal];
    _PhotoButton.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [_PhotoButton addTarget:self action:@selector(shutterCamera) forControlEvents:UIControlEventTouchUpInside];
    [transparentView addSubview:_PhotoButton];
    
 
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(WF_ScreenWidth-50,WF_StatusBarHeight, 40, 40);
    [closeButton setImage:[UIImage imageNamed:@"icon_close_white"] forState: UIControlStateNormal];
    closeButton.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [closeButton addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [transparentView addSubview:closeButton];
    
    CGFloat space=(WF_ScreenWidth-210)/2;
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(space,WF_ScreenHeight-90 ,60, 60);
    [leftButton setImage:[UIImage imageNamed:@"icon_photo_cancel"] forState: UIControlStateNormal];
    leftButton.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [leftButton addTarget:self action:@selector(reTakePhoto) forControlEvents:UIControlEventTouchUpInside];
    [transparentView addSubview:leftButton];
    _leftButton=leftButton;
   
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(leftButton.swf_right+90,WF_ScreenHeight-90, 60, 60);
   
    [rightButton setImage:[UIImage imageNamed:@"icon_photo_confirm"] forState: UIControlStateNormal];
    rightButton.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [rightButton addTarget:self action:@selector(finishPicking) forControlEvents:UIControlEventTouchUpInside];
    [transparentView addSubview:rightButton];
    _rightButton=rightButton;
    _rightButton.hidden=YES;
    _leftButton.hidden=YES;
    
    _tipsLabel = [[UILabel alloc] init];
    _tipsLabel.frame = CGRectMake(400, 50,400, 30);
    CGPoint center = self.view.center;
    center.x = 21.5 + 15;
    _tipsLabel.center = center;
    _tipsLabel.text = @"Tome una foto de su indentificacion dentro del marco";
    _tipsLabel.textColor = [UIColor whiteColor];
    _tipsLabel.textAlignment = NSTextAlignmentCenter;
    _tipsLabel.font = [UIFont systemFontOfSize:13.0f];
    [transparentView addSubview:_tipsLabel];
    _tipsLabel.transform = CGAffineTransformMakeRotation(M_PI/2);
    


}
- (void)customCamera{
    self.view.backgroundColor = [UIColor whiteColor];
    //使用AVMediaTypeVideo 指明self.device代表视频，默认使用后置摄像头进行初始化
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //使用设备初始化输入
    self.input = [[AVCaptureDeviceInput alloc]initWithDevice:self.device error:nil];
    
    //生成输出对象
    self.output = [[AVCaptureMetadataOutput alloc]init];
    self.ImageOutPut = [[AVCaptureStillImageOutput alloc] init];
 
    //生成会话，用来结合输入输出
    self.session = [[AVCaptureSession alloc]init];
    if ([self.session canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
        
        self.session.sessionPreset = AVCaptureSessionPreset1280x720;
        
    }
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    
    if ([self.session canAddOutput:self.ImageOutPut]) {
        [self.session addOutput:self.ImageOutPut];
    }
    
    //使用self.session，初始化预览层，self.session负责驱动input进行信息的采集，layer负责把图像渲染显示
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    
    
//    CGFloat screenWidth = CGRectGetWidth(self.view.bounds);
//    CGFloat screenHeight = CGRectGetHeight(self.view.bounds);
//    CGFloat cardWidth = screenWidth - 105;
//    CGFloat cardHeight = screenHeight - 240;
//    CGFloat cardX = (screenWidth - cardWidth) / 2;
//    CGFloat cardY = (screenHeight - cardHeight) / 2;
    self.previewLayer.frame = CGRectMake(0, 0, WF_ScreenWidth, WF_ScreenHeight);
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.previewLayer];
    
    //开始启动
    [self.session startRunning];
    if ([_device lockForConfiguration:nil]) {
        if ([_device isFlashModeSupported:AVCaptureFlashModeAuto]) {
            [_device setFlashMode:AVCaptureFlashModeAuto];
        }
        //自动白平衡
        if ([_device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
            [_device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
        }
        [_device unlockForConfiguration];
    }
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position ) return device;
    return nil;
}


#pragma mark - 截取照片
- (void) shutterCamera
{
    _rightButton.hidden=NO;
    _leftButton.hidden=NO;
    AVCaptureConnection * videoConnection = [self.ImageOutPut connectionWithMediaType:AVMediaTypeVideo];
    if (!videoConnection) {
        NSLog(@"take photo failed!");
        _rightButton.hidden=YES;
        _leftButton.hidden=YES;
        return;
    }
    _PhotoButton.hidden=YES;
    [self.ImageOutPut captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == NULL) {
            return;
        }
        NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        self.image = [UIImage imageWithData:imageData];
        [self.session stopRunning];
        self.imageView = [[UIImageView alloc]initWithFrame:self.previewLayer.frame];
        [self.view insertSubview:self.imageView belowSubview:self.maskImagView];
        self.imageView.layer.masksToBounds = YES;
        self.imageView.image =self.image;
        NSLog(@"image size = %@",NSStringFromCGSize(self.image.size));
    }];
}



#pragma mark - 检查相机权限
- (BOOL)canUserCamear{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Please open camera permissions" message:@"Settings - Privacy - Camera" delegate:self cancelButtonTitle:@"Confirm" otherButtonTitles:@"Cancel", nil];
        alertView.tag = 100;
        [alertView show];
        return NO;
    }
    else{
        return YES;
    }
    return YES;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0 && alertView.tag == 100) {
        
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            
            [[UIApplication sharedApplication] openURL:url];
            
        }
    }
}
//取消
-(void)cancle{
    
    [self.imageView removeFromSuperview];
    [self.session startRunning];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//完成
-(void)finishPicking{

    if (_delegate) {
        [_delegate customImagePickerController:self didFinishPickingImage:self.self.imageView.image];
    }
    [self cancle];

}
//重拍
-(void)reTakePhoto{
    
    _rightButton.hidden=YES;
    _leftButton.hidden=YES;
    _PhotoButton.hidden=NO;
    [self.imageView removeFromSuperview];
    [self.session startRunning];
    
}


@end
