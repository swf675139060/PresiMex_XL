//
//  PMDeviceModel.h
//  PresiMex
//
//  Created by shenwenfeng on 2023/7/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PMDeviceModel : NSObject

@property(strong,nonatomic)NSString *  batteryPct;//电池百分比
@property(strong,nonatomic)NSString * batteryState;//ios系统字段，电池充电状态
@property(strong,nonatomic)NSString * currentSystemTime;//设备当前时间
@property(strong,nonatomic)NSString * elapsedRealTime;//，开机时间到现在的毫秒数（包括睡眠时间）
@property(strong,nonatomic)NSString * isUsingProxyPort;//，是否使用代理
@property(strong,nonatomic)NSString * isUsingVpn;//是否使用vpn
//@property(strong,nonatomic)NSString * mac;//设备物理地址
@property(strong,nonatomic)NSString * networkOperatorName;//网络运营商名称
@property(strong,nonatomic)NSString * networkType;//网络类型 2G、3G、4G、5G、wifi、other、none
@property(strong,nonatomic)NSString * phoneType;//指示设备电话类型的常量。这表示用于传输语音呼叫的无线电的类型
@property(strong,nonatomic)NSString * serviceCurrentRadioAccessTechnology;//ios系统字段，运营商无线接入技术
@property(strong,nonatomic)NSString * allowsVOIP;//ios系统字段，是否允许VoIP
@property(strong,nonatomic)NSString * mobileCountryCode;//ios系统字段，移动设备国家代码MCC
@property(strong,nonatomic)NSString * mobileNetworkCode;//ios系统字段，移动设备网络代码MNC
//@property(strong,nonatomic)NSString * wifiMac;//ios系统字段，mac 地址
@property(strong,nonatomic)NSString * deviceHeight;//分辨率高
@property(strong,nonatomic)NSString * deviceWidth;//分辨率宽
@property(strong,nonatomic)NSString * deviceName;//，设备名称
@property(strong,nonatomic)NSString * model;//，设备型号
@property(strong,nonatomic)NSString * physicalSize;//物理尺寸
@property(strong,nonatomic)NSString * release1;//系统版本
//@property(strong,nonatomic)NSString * ip;//ip
@property(strong,nonatomic)NSString * totalMemory;//ios系统字段，总内存大小
@property(strong,nonatomic)NSString * freeMemory;//ios系统字段，内存空闲大小
@property(strong,nonatomic)NSString * purgableMemory;//ios系统字段，可清理内存
@property(strong,nonatomic)NSString * inActiveMemory;//ios系统字段，不活动内存
@property(strong,nonatomic)NSString * activeMemory;//ios系统字段，活动内存
@property(strong,nonatomic)NSString * wiredMemory;//ios系统字段，保留内存
@property(strong,nonatomic)NSString * usedMemory;//ios系统字段，已用内存
@property(strong,nonatomic)NSString * keyboard;//连接到设备的键盘种类
@property(strong,nonatomic)NSString * lastBootTime;//最后一次启动时间
@property(strong,nonatomic)NSString * rootJailbreak;//是否root
@property(strong,nonatomic)NSString * simulator;//是否为模拟器
@property(strong,nonatomic)NSString * dbmClass;//ios系统字段，手机信号强度
@property(strong,nonatomic)NSString * createTime;//抓取时间
@property(strong,nonatomic)NSString * osType;//设备系统类型 android/ios
@property(strong,nonatomic)NSString * osVersion;//设备系统版本
@property(strong,nonatomic)NSString * longitude;//经度
@property(strong,nonatomic)NSString * latitude;//纬度
@property(strong,nonatomic)NSString * battery;//电量（剩余电量百分比）
@property(strong,nonatomic)NSString * lastLoginTime;//上次活跃时间（最后一次登陆，用户登录长期有效的就可以取最后一次退出app的时间）
@property(strong,nonatomic)NSString * memory;//内存大小2.75 G/200 MB/20123 KB（值与ramTotalSize一样）
@property(strong,nonatomic)NSString * storage;//存储空间总大小
@property(strong,nonatomic)NSString * unuseStorage;//未使用的存储空间总大小
@property(strong,nonatomic)NSString * wifi;//是否wifi
@property(strong,nonatomic)NSString * wifiName;//wifi名称
@property(strong,nonatomic)NSString * resolution;//屏幕分辨率
@property(strong,nonatomic)NSString * idfv;//ios系统idfv
@property(strong,nonatomic)NSString * idfa;//ios系统idfa
//@property(strong,nonatomic)NSString * audio;//ios系统字段，音频文件个数
@property(strong,nonatomic)NSString * shortVersionString;//ios系统字段，应用版本号对应的技术编码，CFBundleVersionBundle
@property(strong,nonatomic)NSString * version;//ios系统字段，APP版本，CFBundleShortVersionString
@property(strong,nonatomic)NSString * bundleId;//ios系统字段，包名
@property(strong,nonatomic)NSString * appName;//ios系统字段，app名称
@property(strong,nonatomic)NSString * developmentRegion;//ios系统字段，开发语言
//@property(strong,nonatomic)NSString * video;//ios系统字段，视频文件个数
@property(strong,nonatomic)NSString * gpsAddressStreet;//ios系统字段，GPS地址街道
@property(strong,nonatomic)NSString * gpsAddressProvince;//ios系统字段，GPS地址省份
@property(strong,nonatomic)NSString * gpsAddressCity;//ios系统字段，GPS地址城市
@property(strong,nonatomic)NSString * processName;//进程名称
@property(strong,nonatomic)NSString * activeProcessorCount;//活跃进程数量
@property(strong,nonatomic)NSString * processorCount;//进程数量
@property(strong,nonatomic)NSString * physicalMemory;//物理内存
//@property(strong,nonatomic)NSString * processIdentifier;//进程ID
@property(strong,nonatomic)NSString * hostName;//主机名称
//@property(strong,nonatomic)NSString * environment;//运行环境
//@property(strong,nonatomic)NSString * arguments;//运行参数
@property(strong,nonatomic)NSString * globallyUniqueString;//全局唯一ID
@property(strong,nonatomic)NSString * operatingSystemVersionString;//操作系统字符串
@property(strong,nonatomic)NSString * systemUptime;//系统开机时间
@property(strong,nonatomic)NSString * thermalState;//热状态
@property(strong,nonatomic)NSString * lowPowerModeEnabled;//是否开启低电量模式

+ (PMDeviceModel *)sharedInstance;

-(void)GetDate;

@end

NS_ASSUME_NONNULL_END
