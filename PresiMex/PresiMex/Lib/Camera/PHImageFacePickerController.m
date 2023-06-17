//
//  PHImageFacePickerController.m
//  PHPocket
//
//  Created by 王二麻子 on 2022/2/15.
//

#import "PHImageFacePickerController.h"
#import <AVFoundation/AVFoundation.h>
@interface PHImageFacePickerController ()<AVCaptureMetadataOutputObjectsDelegate>
//捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
@property(nonatomic)AVCaptureDevice *device;
//AVCaptureDeviceInput 代表输入设备，他使用AVCaptureDevice 来初始化
@property(nonatomic)AVCaptureDeviceInput *input;
//当启动摄像头开始捕获输入
@property(nonatomic)AVCaptureMetadataOutput *output;
@property(nonatomic)AVCaptureStillImageOutput *ImageOutPut;
//session：由他把输入输出结合在一起，并开始启动捕获设备（摄像头）
@property(nonatomic)AVCaptureSession *session;
//图像预览层，实时显示捕获的图像
@property(nonatomic)AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic)UIButton *PhotoButton;
@property (nonatomic)UIImageView *imageView;
@property (nonatomic)UIImage *image;
@property (nonatomic)UILabel*tipsLabel;
@property (nonatomic)UIImageView *maskImagView;
@property (nonatomic)UIButton *leftButton;
@property (nonatomic)UIButton *rightButton;
@property (nonatomic)UIView *photoBtnBgView;
@property (nonatomic)UIButton *closeButton;
@end

@implementation PHImageFacePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customCamera];
    [self customUI];
}
- (void)customUI{
    
   
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(10,WF_StatusBarHeight, 40, 40);
    [closeButton setImage:[UIImage imageNamed:@"icon_close_white"] forState: UIControlStateNormal];
    closeButton.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [closeButton addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    _closeButton=closeButton;
    
    UIButton *switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    switchButton.frame = CGRectMake(WF_ScreenHeight-50,WF_StatusBarHeight, 40, 40);
    //[switchButton setImage:[UIImage imageNamed:@"camera_switch"] forState: UIControlStateNormal];
    switchButton.imageView.contentMode=UIViewContentModeScaleAspectFit;
   // [switchButton addTarget:self action:@selector(tapSwitchCamera) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:switchButton];
    
    
    UIImageView*img=[UIImageView new];
    img.image=[UIImage imageNamed:@"icon_face_photo_bg"];
    img.frame=CGRectMake(0, WF_NavigationHeight, WF_ScreenHeight,  1.4*WF_ScreenHeight);
    [self.view addSubview:img];
    img.image = [img.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    //[img setTintColor:AppColorBs];
    img.userInteractionEnabled=YES;
    _maskImagView=img;
   
    
    _photoBtnBgView=[UIView new];
    [self.view addSubview:_photoBtnBgView];
    _photoBtnBgView.frame=CGRectMake((WF_ScreenWidth-55)/2, WF_ScreenHeight-60-WF_BottomSafeAreaHeight-20, 60, 60);
    _photoBtnBgView.backgroundColor=[UIColor whiteColor];
    _photoBtnBgView.layer.cornerRadius=30;
    _photoBtnBgView.layer.masksToBounds=YES;
    
    _PhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _PhotoButton.frame = CGRectMake(5, 5, 50, 50);
    //_PhotoButton.backgroundColor=AppColorBs;
    _PhotoButton.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [_PhotoButton addTarget:self action:@selector(shutterCamera) forControlEvents:UIControlEventTouchUpInside];
    _PhotoButton.layer.cornerRadius=25;
    _PhotoButton.layer.masksToBounds=YES;
    [_photoBtnBgView addSubview:_PhotoButton];
    
   
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(10,WF_StatusBarHeight, 40, 40);
    [leftButton setImage:[UIImage imageNamed:@"camer_back"] forState: UIControlStateNormal];
    leftButton.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [leftButton addTarget:self action:@selector(reTakePhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    _leftButton=leftButton;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 60, 60);
    [rightButton setImage:[UIImage imageNamed:@"icon_photo_confirm_check"] forState: UIControlStateNormal];
    rightButton.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [rightButton addTarget:self action:@selector(finishPicking) forControlEvents:UIControlEventTouchUpInside];
    //rightButton.backgroundColor=AppColorBs;
    rightButton.imageView.image = [rightButton.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [rightButton.imageView setTintColor:[UIColor whiteColor]];
    rightButton.layer.cornerRadius=30;
    rightButton.layer.masksToBounds=YES;
    [_photoBtnBgView addSubview:rightButton];
    
    _rightButton=rightButton;
    _rightButton.hidden=YES;
    _leftButton.hidden=YES;
    


}
- (void)customCamera{
    self.view.backgroundColor = [UIColor whiteColor];
    //使用AVMediaTypeVideo 指明self.device代表视频，默认使用后置摄像头进行初始化
//    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.device = [self cameraWithPosition:AVCaptureDevicePositionFront];
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
    self.previewLayer.frame = CGRectMake(0, 0, WF_ScreenWidth, WF_ScreenHeight);
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.previewLayer];
    
    //开始启动
    [self.session startRunning];

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
    _closeButton.hidden=YES;
    AVCaptureConnection * videoConnection = [self.ImageOutPut connectionWithMediaType:AVMediaTypeVideo];
    if (!videoConnection) {
        NSLog(@"take photo failed!");
        _rightButton.hidden=YES;
        _leftButton.hidden=YES;
        _closeButton.hidden=NO;

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

//取消
-(void)cancle{
    
    [self.imageView removeFromSuperview];
    [self.session startRunning];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//完成
-(void)finishPicking{

    if (_delegate) {
        [_delegate customImageFacePickerController:self didFinishPickingImage:self.self.imageView.image];
    }
    [self cancle];

}
//重拍
-(void)reTakePhoto{
    
    _rightButton.hidden=YES;
    _leftButton.hidden=YES;
    _PhotoButton.hidden=NO;
    _closeButton.hidden=NO;
    [self.imageView removeFromSuperview];
    [self.session startRunning];
    
}


/**
 切换摄像头按钮的点击方法的实现
 */
-(void)tapSwitchCamera{
    //获取摄像头的数量（该方法会返回当前能够输入视频的全部设备，包括前后摄像头和外接设备）
    NSInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    //摄像头的数量小于等于1的时候直接返回
    if (cameraCount <= 1) {
        return;
    }
    AVCaptureDevice *newCamera = nil;
    AVCaptureDeviceInput *newInput = nil;
    //获取当前相机的方向（前/后）
    AVCaptureDevicePosition position = [[self.input device] position];
    
    if (position == AVCaptureDevicePositionFront) {
        newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
    }else if (position == AVCaptureDevicePositionBack){
        newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
    }
    //输入流
    newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
    if (newInput != nil) {
        [self.session beginConfiguration];
        //先移除原来的input
        [self.session removeInput:self.input];
        if ([self.session canAddInput:newInput]) {
            [self.session addInput:newInput];
            self.input = newInput;
        }else{
            //如果不能加现在的input，就加原来的input
            [self.session addInput:self.input];
        }
        [self.session commitConfiguration];
    }
    
}
@end

