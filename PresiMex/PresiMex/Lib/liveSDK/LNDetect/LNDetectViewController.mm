//
//  DetectViewController.m
//  YOLOv5NCNN
//
//  Created by Benjamin Wang on 2022/9/9.
//  Copyright © 2022 TENG. All rights reserved.
//

#import "LNDetectViewController.h"
//#import <opencv2/opencv.hpp>  // download opencv2.framework to project
//#include <opencv2/imgcodecs/ios.h>
//#include <ncnn/ncnn/net.h>  // 新版本(如果报错请尝试从官网下载后重新导入。download ncnn.framework/openmp.framework from ncnn and replace)
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AudioToolbox/AudioToolbox.h>
#import "AFNetworking/AFNetworking.h"
#import "ELCameraControlCapture.h"
#import "LNDetector.h"
#import "UIImage+Animated.h"
#import "LNLogger.h"

typedef enum LNSoundType: NSUInteger {
    LNSoundTypeNone,
    LNSoundTypeSuccess,
    LNSoundTypeFailed,
    LNSoundTypeHead,
    LNSoundTypeMouth,
    LNSoundTypeBlink,
} LNSoundType;

@interface LNDetectViewController () <LNDetectorDelegate>
@property (strong, nonatomic) IBOutlet UIView *preView;
@property (strong, nonatomic) IBOutlet UILabel *timeoutLabel;
@property (strong, nonatomic) IBOutlet UILabel *hintLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *voiceButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) ELCameraControlCapture *cameraCapture;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *preLayer;
@property (nonatomic, assign) BOOL muteSound;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, assign) int language; // 1 西班牙语（墨西哥） 2 印尼
@property LNDetector *detector;
@property (nonatomic, assign) BOOL failed;
@property (nonatomic, strong) NSString *livenessID;
@end

@implementation LNDetectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self startDetect];
    });
}

- (void)dealloc {
//    [self.detector cancel];
    NSLog(@"DetectViewController dealloc");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self cleanup];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
//    self.preLayer.frame = CGRectMake(5, screen.size.height - 145 - insets.bottom - 5, 110, 145);
    self.preLayer.frame = self.preView.bounds;
}

// MARK: - LNDetectorDelegate
- (void)detectorWillStartDetectType:(LNDetectionType)detectionType {
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (detectionType) {
            case LNDetectionTypeBlink:
            {
                if (self.language == 1) {
                    self.hintLabel.text = @"Parpadee.";
                } else {
                    self.hintLabel.text = @"Silakan berkedip";
                }
                NSURL *url = [[NSBundle mainBundle] URLForResource:@"blink" withExtension:@"gif"];
                self.imageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
                [self playSound:LNSoundTypeBlink];
                break;
            }
            case LNDetectionTypeMouth:
            {
                if (self.language == 1) {
                    self.hintLabel.text = @"Abra la boca y ciérrela.";
                } else {
                    self.hintLabel.text = @"Mohon buka dan tutup mulut Anda";
                }
                NSURL *url2 = [[NSBundle mainBundle] URLForResource:@"mouth" withExtension:@"gif"];
                self.imageView.image = [UIImage animatedImageWithAnimatedGIFURL:url2];
                [self playSound:LNSoundTypeMouth];
                break;
            }
            case LNDetectionTypePosYaw:
            {
                if (self.language == 1) {
                    self.hintLabel.text = @"Gire la cabeza hacia la izquierda o hacia la derecha (&lt;30 grados).";
                } else {
                    self.hintLabel.text = @"Silakan tengok kiri atau kanan";
                }
                NSURL *url3 = [[NSBundle mainBundle] URLForResource:@"yaw" withExtension:@"gif"];
                self.imageView.image = [UIImage animatedImageWithAnimatedGIFURL:url3];
                [self playSound:LNSoundTypeHead];
                break;
            }
            default:
                break;
        }
    });
}

- (void)detectorDetectionFailed:(LNDetectionFailedType)failedType resultDict:(NSDictionary *)resultDict code:(LNDetectionResultCode)code {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self detectionFailedExit:resultDict code:code];
    });
}

- (void)detectorDetectionSuccess:(LNDetectionType)successType resultDict:(NSDictionary *)resultDict code:(LNDetectionResultCode)code bestImgBase64:(NSString *)best {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (successType == LNDetectionTypeDone) {
            [self detectionSuccessExit:resultDict code:code bestImgBase64:best];
        }
    });
}

- (void)detectorDetectionTimeout:(NSTimeInterval)interval resultDict:(nonnull NSDictionary *)resultDict {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (interval < 0) {
            if (self.language == 1) {
                self.hintLabel.text = @"Se ha acabado el tiempo.";
            } else {
                self.hintLabel.text = @"Mohon lihat lurus ke layar";
            }
            [self detectionFailedExit:resultDict code:LNDetectionResultErrorTimeOut];
        } else {
            self.timeoutLabel.text = [NSString stringWithFormat:@"%.fs", interval];
        }
    });
}

- (void)detectorFrameDetected:(DetectionFrame *)frame warnCode:(LNWarnCode)warnCode {
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (warnCode) {
            case LNWarnCodeFaceLarge:
                if (self.language == 1) {
                    self.hintLabel.text = @"Aléjese la cara de la pantalla.";
                } else {
                    self.hintLabel.text = @"Silakan gerakkan wajah Anda lebih jauh dari layar";
                }
                break;
            case LNWarnCodeFaceSmall:
                if (self.language == 1) {
                    self.hintLabel.text = @"Muévese la cara más cerca de la pantalla.";
                } else {
                    self.hintLabel.text = @"Silakan dekatkan wajah Anda ke layar";
                }
                break;
            case LNWarnCodeFaceNotCenter:
                if (self.language == 1) {
                    self.hintLabel.text = @"Muévese la cara al centro del marco.";
                } else {
                    self.hintLabel.text = @"Deteksi liveness sukses";
                }
                break;
            case LNWarnCodeFaceNotStill:
                if (self.language == 1) {
                    self.hintLabel.text = @"Manténgase inmóvil e inicie la prueba.";
                } else {
                    self.hintLabel.text = @"Deteksi Liveness gagal, silakan coba lagi";
                }
                break;
            case LNWarnCodeFaceMultiple:
                if (self.language == 1) {
                    
                } else {
                    
                }
                self.hintLabel.text = @"有好几个头";
                break;
            case LNWarnCodeFaceNotFrontal:
                if (self.language == 1) {
                    self.hintLabel.text = @"Por favor no te cubras la cara";
                } else {
                    self.hintLabel.text = @"Mohon tidak menutupi wajah Anda";
                }
                break;
            default:
                break;
        }
    });
}

- (void)detectorFaceReady {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.language == 1) {
        } else {
        }
    });
}

// MARK: - Property
- (ELCameraControlCapture *)cameraCapture {
    if (!_cameraCapture) {
        _cameraCapture = [[ELCameraControlCapture alloc] init];
    }
    return _cameraCapture;
}

// MARK: - Private
- (void)voiceButtonPressed:(UIButton *)button {
    if (self.muteSound == NO) {
        self.muteSound = YES;
        [self.voiceButton setImage:[UIImage imageNamed:@"liveness_close_voice"] forState:UIControlStateNormal];
        [self.audioPlayer stop];
    } else {
        self.muteSound = NO;
        [self.voiceButton setImage:[UIImage imageNamed:@"liveness_open_voice"] forState:UIControlStateNormal];
        [self playSound:[self soundTypeForDetectionType:self.detector.detectionType]];
    }
}

- (LNSoundType)soundTypeForDetectionType:(LNDetectionType)detectionType {
    switch (detectionType) {
        case LNDetectionTypeDone:
            return LNSoundTypeSuccess;
        case LNDetectionTypeBlink:
            return LNSoundTypeBlink;
        case LNDetectionTypeMouth:
            return LNSoundTypeMouth;
        case LNDetectionTypePosYaw:
            return LNSoundTypeHead;
        default:
            break;
    }
    return LNSoundTypeNone;
}

- (void)playSound:(LNSoundType)soundType {
    if (soundType == LNSoundTypeNone) {
        return;
    }
    if (self.muteSound == YES) {
        return;
    }
    [self.audioPlayer stop];
    NSString *soundFile;
    switch (soundType) {
        case LNSoundTypeHead:
            if (self.language == 1) {
                soundFile = [[NSBundle mainBundle]
                                       pathForResource:@"action_turn_head" ofType:@"mp3"];
            } else {
                soundFile = [[NSBundle mainBundle]
                                       pathForResource:@"action_turn_head_in" ofType:@"mp3"];
            }
            break;
        case LNSoundTypeBlink:
            if (self.language == 1) {
                soundFile = [[NSBundle mainBundle]
                                       pathForResource:@"action_blink" ofType:@"mp3"];
            } else {
                soundFile = [[NSBundle mainBundle]
                                       pathForResource:@"action_blink_in" ofType:@"mp3"];
            }
            break;
        case LNSoundTypeMouth:
            if (self.language == 1) {
                soundFile = [[NSBundle mainBundle]
                                       pathForResource:@"action_open_mouth" ofType:@"mp3"];
            } else {
                soundFile = [[NSBundle mainBundle]
                                       pathForResource:@"action_open_mouth_in" ofType:@"mp3"];
            }
            break;
        case LNSoundTypeSuccess:
            if (self.language == 1) {
                soundFile = [[NSBundle mainBundle]
                                       pathForResource:@"detection_success" ofType:@"mp3"];
            } else {
                soundFile = [[NSBundle mainBundle]
                                       pathForResource:@"detection_success_in" ofType:@"mp3"];
            }
            break;
        case LNSoundTypeFailed:
            if (self.language == 1) {
                soundFile = [[NSBundle mainBundle]
                                       pathForResource:@"detection_failed" ofType:@"mp3"];
            } else {
                soundFile = [[NSBundle mainBundle]
                                       pathForResource:@"detection_failed_in" ofType:@"mp3"];
            }
            break;
        default:
            return;
    }
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    NSURL *fileURL = [NSURL fileURLWithPath:soundFile];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    [self.audioPlayer setCurrentTime:0];
    [self.audioPlayer play];
}

- (void)startDetect {
    if (self.detector.detecting == YES) {
        return;
    }
    [self.cameraCapture startSession];
    [self.detector detect];
}

- (void)detectionFailedExit:(NSDictionary *)resultDict code:(LNDetectionResultCode)code {
    if (self.failed == YES) {
        return;
    }
    [self.activityIndicatorView setHidden:NO];
    [self.activityIndicatorView startAnimating];
    [self.cameraCapture stopSession];
    self.failed = YES;
    if (self.language == 1) {
        self.hintLabel.text = @"La detección de vivacidad se ha fallado, inténtela de nuevo.";
    } else {
        self.hintLabel.text = @"Jangan bergerak dan mulai pengecekan";
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:@"icon_liveness_fail" ofType:@"jpg"];
    self.imageView.image = [UIImage imageWithContentsOfFile:path];
    [self playSound: LNSoundTypeFailed];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if (self.language == 1) {
            
        } else {
            
        }
//        self.hintLabel.text = @"正在保存结果";
        __weak typeof(self) weakSelf = self;
        [[LNLogger sharedInstance] callSaveResultAPI:resultDict code:code userID:self.userID livenessID:self.livenessID completion:^(BOOL success) {
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf cleanup];
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [strongSelf.navigationController popViewControllerAnimated:NO];
                LivenessFailResult *result = new LivenessFailResult();
                result->livenessId = self.livenessID;
                result->errorCode = code;
                result->errorMsg = [self errorCodeToString:code];
                [strongSelf.delegate detectFailed:result];
            });
        }];
    });
}

// 检测成功调用接口
- (void)detectionSuccessExit:(NSDictionary *)resultDict code:(LNDetectionResultCode)code bestImgBase64:(NSString *)best {
    [self.activityIndicatorView setHidden:NO];
    [self.activityIndicatorView startAnimating];
    [self.cameraCapture stopSession];
    if (self.language == 1) {
        self.hintLabel.text = @"Detección de vivacidad exitosa";
    } else {
        self.hintLabel.text = @"Sesuaikan wajah Anda ke tengah bingkai yang tersedia";
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:@"icon_liveness_success" ofType:@"jpg"];
    self.imageView.image = [UIImage imageWithContentsOfFile:path];
    [self playSound: LNSoundTypeSuccess];
        
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        self.hintLabel.text = @"正在保存结果";
        __weak typeof(self) weakSelf = self;
        [[LNLogger sharedInstance] callSaveResultAPI:resultDict code:code userID:self.userID livenessID:self.livenessID completion:^(BOOL success) {
            __strong typeof(self) strongSelf = weakSelf;
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [strongSelf cleanup];
                [strongSelf.navigationController popViewControllerAnimated:NO];
                if (success) {
                    LivenessSuccessResult *result = new LivenessSuccessResult();
                    result->livenessId = self.livenessID;
                    result->livenessBitmapBase64Str = best;
                    NSData *bestImgData = [[NSData alloc] initWithBase64EncodedString:best options:0];
                    result->livenessBitmap = [[UIImage alloc]initWithData:bestImgData];
                    [strongSelf.delegate detectSuccess:result];
                } else {
                    LivenessFailResult *result = new LivenessFailResult();
                    result->livenessId = self.livenessID;
                    result->errorCode = code;
                    result->errorMsg = [self errorCodeToString:code];
                    [strongSelf.delegate detectFailed:result];
                }
            });
        }];
    });
}

- (void)setup {
    self.livenessID = [[NSUUID UUID] UUIDString];
    NSLog(@"livenessID: %@", self.livenessID);
    [self.activityIndicatorView setHidden:YES];
    self.muteSound = NO;
    NSString *lang = [[NSLocale preferredLanguages] firstObject];
    if ([lang hasPrefix:@"zh"]) {
        self.language = 1;
    } else {
        self.language = 2;
    }
    [self.voiceButton setTitle:nil forState:UIControlStateNormal];
    [self.voiceButton addTarget:self action:@selector(voiceButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _detector = [[LNDetector alloc] initWithDelegate:self userID:self.userID livenessID:self.livenessID];
    if (self.detector == nil) {
        [[LNLogger sharedInstance] callLogAPI:@"initModelError" log:@"model error" userID:self.userID livenessID:self.livenessID];
    } else {
        [[LNLogger sharedInstance] callLogAPI:@"initModelSuccess" log:@"init model successful" userID:self.userID livenessID:self.livenessID];
    }
    self.preLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.cameraCapture.captureSession];
    UIEdgeInsets insets = self.view.safeAreaInsets;
    CGRect screen = [[UIScreen mainScreen] bounds];
    self.preLayer.frame = CGRectMake(5, screen.size.height - 145 - insets.bottom - 5, 110, 145);
    self.preLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.preView.layer addSublayer:self.preLayer];
    self.preView.layer.masksToBounds = YES;
    self.preView.layer.cornerRadius = [[UIScreen mainScreen] bounds].size.width * 0.72 * 0.5;
    self.preView.layer.borderColor = [UIColor colorWithRed:70/255.0 green:179/255.0 blue:0/255.0 alpha:1.0].CGColor;
    self.preView.layer.borderWidth = 2.6;
    __weak typeof(self) weakSelf = self;
    self.cameraCapture.imageBlock = ^(UIImage *image) {
        __strong typeof(self) strongSelf = weakSelf;
//        // 根据方向旋转图片
        __block float degrees = 0.0f;
        __block UIImage *temp = nil;
        dispatch_sync(dispatch_get_main_queue(), ^{
            if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait) {
                degrees = 90.0f;
            } else {
                degrees = -90.0f;
            }
            temp = [strongSelf rotatedByDegrees:degrees image:image];
            [strongSelf.detector enqueueDetectImage:temp];
        });
    };
}

- (void)cleanup {
    [self.detector cancel];
    _detector = nil;
    [self.cameraCapture stopSession];
}

- (CGFloat)degreesToRadians:(CGFloat)degrees {
    return M_PI * (degrees / 180.0);
}

- (UIImage *)rotatedByDegrees:(CGFloat)degrees image:(UIImage *)image {
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation([self degreesToRadians:degrees]);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    // Rotate the image context
    CGContextRotateCTM(bitmap, [self degreesToRadians:degrees]);
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-image.size.width / 2, -image.size.height / 2, image.size.width, image.size.height), [image CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (NSString *)errorCodeToString:(LNDetectionResultCode)code {
    switch(code) {
        case LNDetectionResultErrorNoFace: return @"No Face";
        case LNDetectionResultErrorTimeOut: return @"Time Out";
        case LNDetectionResultErrorMultipleAction: return @"Multiple Action";
        case LNDetectionResultErrorUserCancel: return @"User Cancel";
        case LNDetectionResultErrorModelInitFailed: return @"Model Init Failed";
        case LNDetectionResultErrorNetworkError: return @"Network Error";
        case LNDetectionResultErrorMultipleFace: return @"Multiple Face";
        case LNDetectionResultErrorInitFailed: return @"Init Failed";
        case LNDetectionResultErrorDetectionFailed: return @"Detection Failed";
        default:return @"";
    };
}

@end
