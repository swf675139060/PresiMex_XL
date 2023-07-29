//
//  PMDeviceModel.m
//  PresiMex
//
//  Created by shenwenfeng on 2023/7/23.
//

#import "PMDeviceModel.h"

#import <NetworkExtension/NetworkExtension.h>
#import <AdSupport/ASIdentifierManager.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
//#import <CoreWLAN/CoreWLAN.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreLocation/CoreLocation.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <sys/utsname.h>
#import <mach/mach.h>


#import <SystemConfiguration/SCNetworkReachability.h>

typedef NS_ENUM(NSUInteger, NetworkType) {
    NetworkTypeNone,  // 无网络连接
    NetworkTypeWifi,  // Wifi网络
    NetworkType2G,    // 2G网络
    NetworkType3G,    // 3G网络
    NetworkType4G,    // 4G网络
    NetworkType5G,    // 5G网络
    NetworkTypeOther, // 其他网络类型，包括未知网络类型
};
@interface PMDeviceModel ()
@end

@implementation PMDeviceModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {

    return @{@"release1":@"release"};

}


+ (PMDeviceModel *)sharedInstance {
    static PMDeviceModel *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        
    });
    return sharedInstance;
}









-(void)GetDate{
    
    self.batteryPct = [self getBatteryLevel];//电池百分比
    self.batteryState = [self getBatteryState];//ios系统字段，电池充电状态
    self.currentSystemTime = [NSString stringWithFormat:@"%ld",(long)[self getCurrentTime]];//设备当前时间
    self.elapsedRealTime= [NSString stringWithFormat:@"%.0f",[self getUptimeMillis]];//，开机时间到现在的毫秒数（包括睡眠时间）
    self.isUsingProxyPort = [NSString stringWithFormat:@"%d",[self isUsingProxy]];//，是否使用代理
    self.isUsingVpn = [NSString stringWithFormat:@"%d",[self isUsingVPN]];//是否使用vpn
//    self.mac;//设备物理地址
    self.networkOperatorName =[self getCarrierName];//网络运营商名称
    self.networkType =[self getNetworkType];//网络类型 2G、3G、4G、5G、wifi、other、none
    self.phoneType =  [self getPhoneType];//表示用于传输语音呼叫的无线电的类型
    self.serviceCurrentRadioAccessTechnology =  [self getWirelessTechnology];;//ios系统字段，运营商无线接入技术
    self.allowsVOIP = [NSString stringWithFormat:@"%d",[self isVoIPAllowed]];//ios系统字段，是否允许VoIP
    self.mobileCountryCode = [self getMCC];//ios系统字段，移动设备国家代码MCC
    self.mobileNetworkCode = [self getMNC];//ios系统字段，移动设备网络代码MNC
//    self.wifiMac = [self getWifiMacAddress];//ios系统字段，mac 地址
    self.deviceHeight = [NSString stringWithFormat:@"%.0f",[self getscreenHeight]];//分辨率高
    self.deviceWidth= [NSString stringWithFormat:@"%.0f",[self getscreenWidth]];//分辨率宽
    self.deviceName = [self getDeviceName];//，设备名称
    self.model = [self getDeviceModel];//，设备型号
    self.physicalSize = [NSString stringWithFormat:@"%@",[self getPhysicalSize]];//物理尺寸
    self.release1 = [self getSystemVersion];//系统版本
//    self.ip = ;//ip
    self.totalMemory = [self getTotalMemory];//ios系统字段，总内存大小
    self.freeMemory = [self getFreeMemory];//ios系统字段，内存空闲大小
    self.purgableMemory = [self getPurgeableMemory];//ios系统字段，可清理内存
    self.inActiveMemory = [self getInactiveMemory];//ios系统字段，不活动内存
    self.activeMemory = [self getActiveMemory];//ios系统字段，活动内存
    self.wiredMemory = [self getWiredMemory];//ios系统字段，保留内存
    self.usedMemory = [self getUsedMemory];//ios系统字段，已用内存
    self.keyboard = [self getKeyboardType];//连接到设备的键盘种类
    self.lastBootTime = [self getLastActiveTime];//最后一次启动时间
    self.rootJailbreak = [NSString stringWithFormat:@"%d",[self isJailbroken]];//是否root
    self.simulator = [NSString stringWithFormat:@"%d",[self isSimulator]];//是否为模拟器
//    self.dbmClass = [self dbmClass];//ios系统字段，手机信号强度
    self.createTime = [self getCaptureTime];//抓取时间
    self.osType = @"ios";//设备系统类型 android/ios
    self.osVersion = [self getOSVersion];//设备系统版本
    self.longitude = [PMLocationManager sharedInstance].longitude;//经度
    self.latitude = [PMLocationManager sharedInstance].latitude;//纬度
    self.battery = [self getBatteryLevel];//电量（剩余电量百分比）
//    self. self.登陆，用户登录长期有效的就可以取最后一次退出app的时间）
    self.memory = [self getTotalMemory];//内存大小2.75 G/200 MB/20123 KB（值与ramTotalSize一样）
    self.storage = [self getTotalStorage];//存储空间总大小
    self.unuseStorage = [self getFreeStorage];//未使用的存储空间总大小
    self.wifi =  [self isWifi];//是否wifi
    self.wifiName = [self getWifiName];//wifi名称
    self.resolution = [self getScreenResolution];//屏幕分辨率
    self.idfv = [self getIDFV];//ios系统idfv
    self.idfa = [self getIDFA];//ios系统idfaget
//    self.* audio;//ios系统字段，音频文件个数
//    self. self.用版本号对应的技术编码，CFBundleVersionBundle
    self.version = [self getOSVersion];//ios系统字段，APP版本，CFBundleShortVersionString
    self.bundleId = [self getBundleID];//ios系统字段，包名
    self.appName = [self getAppName];//ios系统字段，app名称
    self.developmentRegion = [self getDevelopmentLanguage];//ios系统字段，开发语言
//    self.* video;//ios系统字段，视频文件个数
    self.gpsAddressStreet = [PMLocationManager sharedInstance].gpsAddressStreet;//ios系统字段，GPS地址街道
    self.gpsAddressProvince = [PMLocationManager sharedInstance].gpsAddressProvince;//ios系统字段，GPS地址省份
    self.gpsAddressCity = [PMLocationManager sharedInstance].gpsAddressCity;//ios系统字段，GPS地址城市
    self.processName = [self getProcessName];//进程名称
    self.activeProcessorCount = @"1";//活跃进程数量
    self.processorCount = [NSString stringWithFormat:@"%@",[self getProcessCount]];//进程数量
    self.physicalMemory = [self getPhysicalMemory];//物理内存
//    self.* processIdentifier;//进程ID
    self.hostName = [self getHostName];//主机名称
//    self.* environment;//运行环境
//    self.* arguments;//运行参数
    self.globallyUniqueString = [self getUUID];//全局唯一ID
    self.operatingSystemVersionString = [self getOperatingSystemVersionString];//操作系统字符串
    self.systemUptime = [self getSystemUptime];//系统开机时间
    self.thermalState = [self getThermalState];//热状态
    self.lowPowerModeEnabled = [self getLowPowerMode];//是否开启低电量模式
    
}

// 获取电池充电状态
- (NSString *)getBatteryState {
    UIDevice *device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    UIDeviceBatteryState batteryState = device.batteryState;
    return [NSString stringWithFormat:@"%ld",batteryState];
}

// 获取设备当前时间
- (NSInteger)getCurrentTime {
    
    NSInteger timestamp = [[NSDate date] timeIntervalSince1970];
    return timestamp;
}

// 获取开机时间到现在的毫秒数（包括睡眠时间）
- (double)getUptimeMillis {
    NSTimeInterval uptime = [[NSProcessInfo processInfo] systemUptime];
    double uptimeMillis = uptime * 1000.0;
    return uptimeMillis;
}

// 获取是否使用代理
- (BOOL)isUsingProxy {
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    BOOL usingProxy = [proxySettings[@"HTTPEnable"] boolValue] || [proxySettings[@"HTTPSEnable"] boolValue];
    return usingProxy;
}

// 获取是否使用VPN
- (BOOL)isUsingVPN {
    NEVPNManager *vpnManager = [NEVPNManager sharedManager];
    NEVPNStatus vpnStatus = vpnManager.connection.status;
    BOOL usingVPN = (vpnStatus == NEVPNStatusConnected);
    return usingVPN;
}


// 获取网络运营商名称
- (NSString *)getCarrierName {
    CTCarrier *carrier = [[CTTelephonyNetworkInfo new] subscriberCellularProvider];
    NSString *carrierName = carrier.carrierName;
    return carrierName;
}



//无网络
static NSString * notReachable = @"none";

#pragma mark --- 获取当前网络状态
- (NSString *)getNetworkType {
    
    //创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    struct sockaddr_storage zeroAddress;
    
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.ss_len = sizeof(zeroAddress);
    zeroAddress.ss_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    //如果不能获取连接标志，则不能连接网络，直接返回
    if (!didRetrieveFlags) {
        return notReachable;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    if (isReachable && !needsConnection) { }else{
        return notReachable;
    }
    
    
    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == kSCNetworkReachabilityFlagsConnectionRequired ) {
        
        return notReachable;
        
    } else if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN) {
        
        return [self cellularType];
        
    } else {
        return @"WiFi";
    }
    
}

- (NSString *)cellularType {
    
    CTTelephonyNetworkInfo * info = [[CTTelephonyNetworkInfo alloc] init];
    
    NSString *currentRadioAccessTechnology;
    if (@available(iOS 12.1, *)) {
        if (info && [info respondsToSelector:@selector(serviceCurrentRadioAccessTechnology)]) {
            NSDictionary *radioDic = [info serviceCurrentRadioAccessTechnology];
            if (radioDic.allKeys.count) {
                currentRadioAccessTechnology = [radioDic objectForKey:radioDic.allKeys[0]];
            } else {
                return notReachable;
            }
        } else {
            
            return notReachable;
        }
        
    } else {
        
        currentRadioAccessTechnology = info.currentRadioAccessTechnology;
    }
    
    if (currentRadioAccessTechnology) {
        
        if (@available(iOS 14.1, *)) {
            
            if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyNRNSA] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyNR]) {
                
                return @"5G";
                
            }
        }
        
        if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
            
            return @"4G";
            
        } else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyWCDMA] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyHSDPA] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyHSUPA] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyeHRPD]) {
            
            return @"3G";
            
        } else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMA1x]) {
            
            return @"2G";
            
        } else {
            
            return @"other";
        }
        
        
    } else {
        
        return notReachable;
    }
}



//- (NSString *)currentNetworkType {
//    NetworkType networkType = NetworkTypeNone;  // 默认无网络连接
//
//    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
//    if (@available(iOS 12.0, *)) {
//        NSString *currentRadioAccessTechnology = nil;
//        NSDictionary *radioTechDict = networkInfo.serviceCurrentRadioAccessTechnology;
//        if (radioTechDict) {
//            currentRadioAccessTechnology = radioTechDict.allValues.firstObject;
//        }
//        if (currentRadioAccessTechnology) {
//            if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS] ||
//                [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge] ||
//                [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMA1x]) {
//                networkType = NetworkType2G;
//            } else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyWCDMA] ||
//                       [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyHSDPA] ||
//                       [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyHSUPA] ||
//                       [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0] ||
//                       [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA] ||
//                       [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB] ||
//                       [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyeHRPD]) {
//                networkType = NetworkType3G;
//            } else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
//                if (@available(iOS 14.1, *)) {
//                    if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyNRNSA] ||
//                        [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyNR]) {
//                        networkType = NetworkType5G;
//                    } else {
//                        networkType = NetworkType4G;
//                    }
//                } else {
//                    networkType = NetworkType4G;
//                }
//            }
//        }
//    } else {
//        // Fallback on earlier versions
//    }
//
//    if (networkType == NetworkTypeNone) {
//        AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
//        __block BOOL isWifiConnected = NO;  // 使用__block修饰符
//
//        __weak typeof(reachabilityManager) weakManager = reachabilityManager;  // 避免引起循环引用
//
//        [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//            switch (status) {
//                case AFNetworkReachabilityStatusReachableViaWiFi:
//                    isWifiConnected = YES;
//                    break;
//                default:
//                    break;
//            }
//
//            __strong typeof(weakManager) strongManager = weakManager;  // 避免引起循环引用
//            [strongManager stopMonitoring];  // 停止监视网络状态
//        }];
//
//        [reachabilityManager startMonitoring];  // 开始监视网络状态
//
//        if (isWifiConnected) {
//            networkType = NetworkTypeWifi;
//        } else {
//            networkType = NetworkTypeOther;
//        }
//    }
//
//    NSString *networkTypeString = @"";
//    switch (networkType) {
//        case NetworkTypeNone:
//            networkTypeString = @"none";
//            break;
//        case NetworkTypeWifi:
//            networkTypeString = @"Wifi";
//            break;
//        case NetworkType2G:
//            networkTypeString = @"2G";
//            break;
//        case NetworkType3G:
//            networkTypeString = @"3G";
//            break;
//        case NetworkType4G:
//            networkTypeString = @"4G";
//            break;
//        case NetworkType5G:
//            networkTypeString = @"5G";
//            break;
//        case NetworkTypeOther:
//        default:
//            networkTypeString = @"other";
//            break;
//    }
//
//    return networkTypeString;
//}

// 获取设备电话类型的常量
- (NSString *)getPhoneType {
    NSString *phoneType = [[UIDevice currentDevice] model];
    return phoneType;
}


// 获取运营商无线接入技术
- (NSString *)getWirelessTechnology {
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    NSString *currentRadioAccessTechnology = networkInfo.currentRadioAccessTechnology;

    return currentRadioAccessTechnology;
}

// 获取是否允许VIP
- (BOOL)isVoIPAllowed {
    UIDevice *device = [UIDevice currentDevice];
    BOOL supportsVOIP = [device respondsToSelector:@selector(isMultitaskingSupported)] && device.isMultitaskingSupported;
    return supportsVOIP;
}

// 获取移动设备国家代码MCC
- (NSString *)getMCC {
    CTCarrier *carrier = [[CTTelephonyNetworkInfo new] subscriberCellularProvider];
    NSString *mcc = carrier.mobileCountryCode;
    return mcc;
}

// 获取移动设备网络代码MNC
- (NSString *)getMNC {
    CTCarrier *carrier = [[CTTelephonyNetworkInfo new] subscriberCellularProvider];
    NSString *mnc = carrier.mobileNetworkCode;
    return mnc;
}


//- (NSString *)getWifiMacAddress {
//    CWInterface *wifiInterface = [CWWiFiClient sharedWiFiClient].interface;
//    NSString *macAddress = wifiInterface.hardwareAddress;
//
//    if (macAddress) {
//        // 获取到了MAC地址
//        return macAddress;
//    } else {
//        // 没有获取到MAC地址
//        return nil;
//    }
//}


-(CGFloat )getscreenHeight {
    CGSize screenSize = UIScreen.mainScreen.bounds.size;
    return screenSize.height;
}
- (CGFloat )getscreenWidth{
    CGSize screenSize = UIScreen.mainScreen.bounds.size;
    return screenSize.width;
}
- (NSString *)getDeviceName {
    UIDevice *device = [UIDevice currentDevice];
    return device.name;
}

- (NSString *)getDeviceModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

- (NSNumber *)getPhysicalSize {
    CGFloat physicalSize = 0.0;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        switch ((int)UIScreen.mainScreen.nativeScale) {
            case 2:
                physicalSize = 3.5;
                break;
            case 3:
                physicalSize = 4.0;
                break;
            case 4:
                physicalSize = 4.7;
                break;
            case 5:
                physicalSize = 5.5;
                break;
            default:
                break;
        }
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        physicalSize = 9.7;
    }
    return [NSNumber numberWithFloat:physicalSize];
}

- (NSString *)getSystemVersion {
    UIDevice *device = [UIDevice currentDevice];
    return device.systemVersion;
}

//+ (NSString *)getIPAddress {
//    NSString *address = @"error";
//    struct ifaddrs *interfaces = NULL;
//    struct ifaddrs *temp_addr = NULL;
//    int success = 0;
//    success = getifaddrs(&interfaces);
//    if (success == 0) {
//        temp_addr = interfaces;
//        while (temp_addr != NULL) {
//            if (temp_addr->ifa_addr->sa_family == AF_INET) {
//                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
//                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
//                }
//            }
//            temp_addr = temp_addr->ifa_next;
//        }
//    }
//    freeifaddrs(interfaces);
//    return address;
//}

- (NSString *)getTotalMemory {
    return [NSString stringWithFormat:@"%lld", [[NSProcessInfo processInfo] physicalMemory]];
}

- (NSString *)getFreeMemory {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return @"error";
    }
    return [NSString stringWithFormat:@"%lu", vm_page_size * (vmStats.free_count + vmStats.inactive_count)];
}

- (NSString *)getPurgeableMemory {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return @"error";
    }
    return [NSString stringWithFormat:@"%lu", vm_page_size * vmStats.purgeable_count];
}

- (NSString *)getInactiveMemory {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return @"error";
    }
    return [NSString stringWithFormat:@"%lu", vm_page_size * vmStats.inactive_count];
}

- (NSString *)getActiveMemory {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return @"error";
    }
    return [NSString stringWithFormat:@"%lu", vm_page_size * vmStats.active_count];
}
- (NSString *)getWiredMemory {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return @"error";
    }
    return [NSString stringWithFormat:@"%lu", vm_page_size * vmStats.wire_count];
}

- (NSString *)getUsedMemory {
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&taskInfo, &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return @"error";
    }
    return [NSString stringWithFormat:@"%lu", taskInfo.resident_size];
}

- (NSString *)getKeyboardType {
    return [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"AppleKeyboardsExpanded"]];
}

//+ (NSString *)getLastBootTime {
//    struct timeval boottime;
//    size_t len = sizeof(boottime);
//    int mib[2] = {CTL_KERN, KERN_BOOTTIME};
//    if (sysctl(mib, 2, &boottime, &len, NULL, 0) != -1) {
//        time_t bsec = boottime.tv_sec;
//        return [NSString stringWithFormat:@"%s", ctime(&bsec)];
//    }
//    return @"error";
//}

- (BOOL)isJailbroken {
    NSArray *jailbreakApps = @[@"Cydia", @"SBSettings", @"WinterBoard"];
    for (NSString *app in jailbreakApps) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://", app]]]) {
            return YES;
        }
    }
    return NO;
}

-(BOOL)isSimulator {
#if TARGET_OS_SIMULATOR
    return YES;
#else
    return NO;
#endif
}


//+ (NSString *)getSignalStrength {
//    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
//    CTCarrier *carrier = [networkInfo subscriberCellularProvider];
//    NSString *signalStrength = @"error";
//    if (carrier != nil) {
//        NSArray *bars = @[@"0", @"1", @"2", @"3", @"4"];
//        int signalBars = (int)[bars indexOfObject:networkInfo.serviceCurrentRadioAccessTechnology.signalStrength];
//        signalStrength = [NSString stringWithFormat:@"%d", signalBars];
//    }
//    return signalStrength;
//}

- (NSString *)getCaptureTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [formatter stringFromDate:[NSDate date]];
}

- (NSNumber *)getDownloadedFileCount {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *downloadsUrl = [fileManager URLsForDirectory:NSDownloadsDirectory inDomains:NSUserDomainMask][0];
    NSArray *downloads = [fileManager contentsOfDirectoryAtURL:downloadsUrl includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
    return [NSNumber numberWithUnsignedInteger:downloads.count];
}

- (NSString *)getSystemType {
    return [NSString stringWithFormat:@"%@ %@", [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion];
}

- (NSDictionary *)getLocation {
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    [locationManager stopUpdatingLocation];
    if (location) {
        return @{@"latitude" : @(location.coordinate.latitude),
                 @"longitude" : @(location.coordinate.longitude)};
    } else {
        return @{@"latitude" : @(0),
                 @"longitude" : @(0)};
    }
}


- (NSString *)getLastActiveTime {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *lastActiveTime = [defaults objectForKey:@"LastActiveTime"];
    if (lastActiveTime) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        return [formatter stringFromDate:lastActiveTime];
    } else {
        return @"";
    }
}

- (NSNumber *)getImageCount {
    PHFetchResult *result = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:nil];
    return [NSNumber numberWithInteger:result.count];
}

- (NSString *)getPhysicalMemory {
    NSProcessInfo *processInfo = [NSProcessInfo processInfo];
    unsigned long long physicalMemory = processInfo.physicalMemory;
    return [NSByteCountFormatter stringFromByteCount:physicalMemory countStyle:NSByteCountFormatterCountStyleMemory];
}

- (NSString *)getTotalStorage {
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *totalSize = [fileAttributes objectForKey:NSFileSystemSize];
    return [NSByteCountFormatter stringFromByteCount:totalSize.longLongValue countStyle:NSByteCountFormatterCountStyleBinary];
}

- (NSString *)getFreeStorage {
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *freeSize = [fileAttributes objectForKey:NSFileSystemFreeSize];
    return [NSByteCountFormatter stringFromByteCount:freeSize.longLongValue countStyle:NSByteCountFormatterCountStyleBinary];
}

- (NSString *)getWifiName {
    NSString *wifiName = @"";
    NSArray *ifs = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs) {
        NSDictionary *info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info[@"SSID"]) {
            wifiName = info[@"SSID"];
        }
    }
    return wifiName;
    
//    NSString *ssid = @"";
//    NSArray *ifs = (__bridge   id)CNCopySupportedInterfaces();
//
//    for (NSString *ifname in ifs) {
//
//        NSDictionary *info = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifname);
//
//        if (info[@"SSIDD"])
//
//         {
//
//            ssid = info[@"SSID"];
//
//        }
//
//    }
//
//    return ssid;
}



- (NSNumber *)getLongitude {
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    [locationManager stopUpdatingLocation];
    if (location) {
        return [NSNumber numberWithDouble:location.coordinate.longitude];
    } else {
        return [NSNumber numberWithDouble:0];
    }
}

- (NSNumber *)getLatitude {
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    [locationManager stopUpdatingLocation];
    if (location) {
        return [NSNumber numberWithDouble:location.coordinate.latitude];
    } else {
        return [NSNumber numberWithDouble:0];
    }
}

- (NSString *)getBatteryLevel {
    UIDevice *device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    float batteryLevel = device.batteryLevel;
    device.batteryMonitoringEnabled = NO;
    return [NSString stringWithFormat:@"%.0f%%", batteryLevel * 100];
}




- (NSString * )isWifi {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    BOOL isWiFiEnabled = [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
    return [NSString stringWithFormat:@"%d",isWiFiEnabled];
  
}



- (NSString * )getScreenResolution {
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGFloat scale = [[UIScreen mainScreen] scale];
    
    return [NSString stringWithFormat:@"%.0f", scale];
}

- (NSString *)getIDFV {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

- (NSString *)getIDFA {
    NSString *idfa = @"";
    if ([ASIdentifierManager sharedManager].isAdvertisingTrackingEnabled) {
        idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    }
    return idfa;
}

- (NSNumber *)getAudioFileCount {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryPath = [paths objectAtIndex:0];
    NSString *musicPath = [libraryPath stringByAppendingPathComponent:@"Sounds"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *audioFiles = [fileManager contentsOfDirectoryAtPath:musicPath error:nil];
    return [NSNumber numberWithUnsignedInteger:audioFiles.count];
}

- (NSString *)getAppBuildVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

- (NSString *)getAppVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

- (NSString *)getBundleID {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

- (NSString *)getAppName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

- (NSString *)getDevelopmentLanguage {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDevelopmentRegion"];
}

- (NSNumber *)getVideoFileCount {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryPath = [paths objectAtIndex:0];
    NSString *videoPath = [libraryPath stringByAppendingPathComponent:@"Videos"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *videoFiles = [fileManager contentsOfDirectoryAtPath:videoPath error:nil];
    return [NSNumber numberWithUnsignedInteger:videoFiles.count];
}

// 获取GPS地址街道
- (void)getStreetForLocation:(CLLocation *)location completionHandler:(void (^)(NSString *street, NSError *error))completionHandler {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            completionHandler(nil, error);
            return;
        }
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks.firstObject;
            NSString *street = placemark.thoroughfare;
            completionHandler(street, nil);
        } else {
            completionHandler(nil, nil);
        }
    }];
}

// 获取GPS地址省份
- (void)getProvinceForLocation:(CLLocation *)location completionHandler:(void (^)(NSString *province, NSError *error))completionHandler {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            completionHandler(nil, error);
            return;
        }
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks.firstObject;
            NSString *administrativeArea = placemark.administrativeArea;
            completionHandler(administrativeArea, nil);
        } else {
            completionHandler(nil, nil);
        }
    }];
}

// 获取GPS地址城市
- (void)getCityForLocation:(CLLocation *)location completionHandler:(void (^)(NSString *city, NSError *error))completionHandler {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            completionHandler(nil, error);
            return;
        }
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks.firstObject;
            NSString *city = placemark.locality ? placemark.locality : placemark.administrativeArea;
            completionHandler(city, nil);
        } else {
            completionHandler(nil, nil);
        }
    }];
}
- (NSString *)getProcessName {
    return [[NSProcessInfo processInfo] processName];
}

- (NSNumber *)getActiveProcessCount {
    return [NSNumber numberWithUnsignedInteger:[[[NSProcessInfo processInfo] valueForKey:@"_arguments"] count]];
}

- (NSString *)getProcessCount {
    NSProcessInfo *processInfo = [NSProcessInfo processInfo];
    NSInteger processCount = processInfo.processorCount;
    return [NSString stringWithFormat:@"%ld",processCount];
}

- (NSString *)getPhysicalMemorySize {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                                HOST_VM_INFO,
                                                (host_info_t)&vmStats,
                                                &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return @"";
    }

    natural_t memSize = ((natural_t)vmStats.active_count +
                         (natural_t)vmStats.inactive_count +
                         (natural_t)vmStats.wire_count +
                         (natural_t)vmStats.free_count) * (natural_t)PAGE_SIZE;
    return [NSByteCountFormatter stringFromByteCount:memSize countStyle:NSByteCountFormatterCountStyleMemory];
}

- (NSString *)getProcessID {
    return [NSString stringWithFormat:@"%d", [[NSProcessInfo processInfo] processIdentifier]];
}

- (NSString *)getHostName {
    UIDevice *device = [UIDevice currentDevice];
    NSString *hostname = device.name;
    return hostname;
}

- (NSString *)getEnvironment {
    return [[[NSProcessInfo processInfo] environment] description];
}

- (NSString *)getArguments {
    return [[[NSProcessInfo processInfo] arguments] componentsJoinedByString:@" "];
}
// 获取UUID
- (NSString *)getUUID {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

// 获取操作系统版本号
- (NSString *)getOSVersion {
    return [[UIDevice currentDevice] systemVersion];
}


- (NSString *)getOperatingSystemVersionString {
    UIDevice *device = [UIDevice currentDevice];
    NSString *systemName = device.systemName;
    NSString *systemVersion = device.systemVersion;
    NSString *systemString = [NSString stringWithFormat:@"%@ %@", systemName, systemVersion];
    return systemString;
}


- (NSString *)getSystemUptime {
    
    
    NSProcessInfo *processInfo = [NSProcessInfo processInfo];
    NSTimeInterval uptime = processInfo.systemUptime;
    NSTimeInterval bootTimestamp = [[NSDate date] timeIntervalSince1970] - uptime;
    
    return [NSString stringWithFormat:@"%f",bootTimestamp];
}

- (NSString *)getThermalState {
    
    UIDevice *device = [UIDevice currentDevice];
    UIDeviceBatteryState batteryState = device.batteryState;
    return [NSString stringWithFormat:@"%ld",(long)batteryState];
}

- (NSString *)getLowPowerMode {
    return [NSProcessInfo processInfo].lowPowerModeEnabled ? @"1" : @"0";
}

@end
