//
//  BasicDataModel.h
//  PresiMex
//
//  Created by shenWenFeng on 2023/6/19.
//

#import <Foundation/Foundation.h>
@class BasicDataModel;

NS_ASSUME_NONNULL_BEGIN

@interface BasicData : NSObject

@property(strong, nonatomic) NSArray * Género;//性别
//@property(strong, nonatomic) NSString * CURP;//CURP
//@property(strong, nonatomic) NSString * CorreoElectrónico;//邮箱
@property(strong, nonatomic) NSArray * EstadoCivil;//婚姻状态
@property(strong, nonatomic) NSArray * NumeroDeNiños;//孩子数量
@property(strong, nonatomic) NSArray * AntecedenteEducacionales;//教育背景
//@property(strong, nonatomic) NSArray * FechaDeNacimiento;//出生日期
@property(strong, nonatomic) NSArray * EstadoDeTrabajo;//工作状态
@property(strong, nonatomic) NSArray * Industria;//行业
@property(strong, nonatomic) NSArray * IngresoMensual;//月收入
@property(strong, nonatomic) NSArray * TipoDeSalario;//工资类型
@property(strong, nonatomic) NSArray * DíaDePago1;//发薪日1
@property(strong, nonatomic) NSArray * DíaDePago2;//发薪日2
//@property(strong, nonatomic) NSArray * NombreDeLaCompañía;//公司名称
//@property(strong, nonatomic) NSArray * NúmeroDeEmpresa;//公司号码
@property(strong, nonatomic) NSArray * CiudadDonde;//工作地点所在城市
//@property(strong, nonatomic) NSArray * ÁreaDonde;//工作地点所在区
//@property(strong, nonatomic) NSArray * DirecciónDetallada;//工作地点详细地址


-(void)initData;
@end

//联系人
@interface RelaciónDataModel : NSObject

-(void)initData;
@property(strong, nonatomic) NSArray * Relación;//关系

@end

@interface BasicDataModel : NSObject

@property(assign, nonatomic) NSInteger ID;

@property(strong, nonatomic) NSString * title;

+(BasicDataModel *)createWithTitle:(NSString *)title ID:(NSInteger)ID;

@end

NS_ASSUME_NONNULL_END
