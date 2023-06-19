//
//  PMIDAuthModel.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PMIDAuthModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desTitle;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic, copy) NSString *cardNumbber;
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *placeHold;
@property (nonatomic, copy) NSString *content;
//活体照片URL（用于App显示,带Token）
@property (nonatomic, copy) NSString *acoustic;
//身份证号
@property (nonatomic, copy) NSString *cartoon;
//用户名字
@property (nonatomic, copy) NSString *davis;
//证件照正面(ocr正面时返回此信息)
@property (nonatomic, copy) NSString *held;
//证件照正面(ocr反面时返回此信息)
@property (nonatomic, copy) NSString *silent;


//保存时提交的活体照片URL
@property (nonatomic, copy) NSString *thanks;

//自己加
@property (nonatomic, strong) UIImage *heldImage;
@property (nonatomic, strong) UIImage *silentImage;
@property (nonatomic, strong) UIImage *acousticImage;//活体认证图片
@property (nonatomic, strong) NSString *livenessId;//活体认证ID
@property (nonatomic, strong) NSString *livenessBitmapBase64Str;//活体认证图片Base64Str


@end
//acoustic = "https://sst-apk.cashimex.mx/liveness/20230512/202cb962ac59075b964b07152d234b707778639_20230512014215310.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230617T085225Z&X-Amz-SignedHeaders=host&X-Amz-Expires=599&X-Amz-Credential=AKIARRN2AWT5RDG4YK44%2F20230617%2Fus-west-1%2Fs3%2Faws4_request&X-Amz-Signature=b55f5da4a284d891290966d3c04df3827a02309733fb45b66dcb4f32180c88f4";
//cartoon = BERE800903HSRRZD08;
//davis = "EDGARD GERARDO";
//held = "https://sst-apk.cashimex.mx/id_card/20230512/202cb962ac59075b964b07152d234b707778639_20230512014136994.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230617T085225Z&X-Amz-SignedHeaders=host&X-Amz-Expires=600&X-Amz-Credential=AKIARRN2AWT5RDG4YK44%2F20230617%2Fus-west-1%2Fs3%2Faws4_request&X-Amz-Signature=893fa3ec13fcb238b9df4a472be08ae9a774f27931aac3c2d1922d62865732a7";
//silent = "https://sst-apk.cashimex.mx/id_card/20230512/202cb962ac59075b964b07152d234b707778639_20230512014146166.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230617T085225Z&X-Amz-SignedHeaders=host&X-Amz-Expires=600&X-Amz-Credential=AKIARRN2AWT5RDG4YK44%2F20230617%2Fus-west-1%2Fs3%2Faws4_request&X-Amz-Signature=9156c02f13e7fca5acdec4156f01b24b83f733cb0ebc6f74188472f5d672442b";
//thanks = "https://sst-apk.s3.us-west-1.amazonaws.com/liveness/20230512/202cb962ac59075b964b07152d234b707778639_20230512014215310.jpg";
NS_ASSUME_NONNULL_END
