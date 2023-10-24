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
#import <AppTrackingTransparency/AppTrackingTransparency.h>

#import <SystemConfiguration/SCNetworkReachability.h>

#import <dlfcn.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
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
//    self.mac = [self getUUID];//设备物理地址
    self.uuid = [self getUUID];
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
    self.lastBootTime = [self getLastBootTime];//最后一次启动时间
    self.rootJailbreak = [NSString stringWithFormat:@"%d",[self isJailbroken]];//是否root
    self.simulator = [NSString stringWithFormat:@"%d",[self isSimulator]];//是否为模拟器
    self.dbmClass = [NSString stringWithFormat:@"%d",[self getSignalStrength]];//ios系统字段，手机信号强度
    self.createTime = [self getCaptureTime];//抓取时间
    self.downloadFiles = [self getDownloadedFilesCountAsString];
    self.osType = @"ios";//设备系统类型 android/ios
    self.osVersion = [self getOSVersion];//设备系统版本
    self.longitude = [PMLocationManager sharedInstance].longitude;//经度
    self.latitude = [PMLocationManager sharedInstance].latitude;//纬度
    self.battery = [self getBatteryLevel];//电量（剩余电量百分比）
//    self. self.登陆，用户登录长期有效的就可以取最后一次退出app的时间）
    self.lastLoginTime = [self getFirstLoginTimeString];
    self.picCount = [self getPhotoCountAsString];
    self.memory = [self getTotalMemory];//内存大小2.75 G/200 MB/20123 KB（值与ramTotalSize一样）
    self.storage = [self getTotalStorage];//存储空间总大小
    self.unuseStorage = [self getFreeStorage];//未使用的存储空间总大小
    self.wifi =  [self isWifi];//是否wifi
//    self.wifiName = [self getWifiName];//wifi名称
    self.resolution = [self getScreenResolution];//屏幕分辨率
    self.idfv = [self getIDFV];//ios系统idfv
    [self getIDFA];//ios系统idfaget
    self.audio = [self getAudioFileCountAsString];//ios系统字段，音频文件个数
    self.shortVersionString = [self CFBundleIdentifier]; //self.用版本号对应的技术编码，CFBundleVersionBundle
    self.version = [self getOSVersion];//ios系统字段，APP版本，CFBundleShortVersionString
    self.bundleId = [self getBundleID];//ios系统字段，包名
    self.appName = [self getAppName];//ios系统字段，app名称
    self.developmentRegion = [self getDevelopmentLanguage];//ios系统字段，开发语言
    self.video = [self getVideoFileCountAsString];//ios系统字段，视频文件个数
    self.gpsAddressStreet = [PMLocationManager sharedInstance].gpsAddressStreet;//ios系统字段，GPS地址街道
    self.gpsAddressProvince = [PMLocationManager sharedInstance].gpsAddressProvince;//ios系统字段，GPS地址省份
    self.gpsAddressCity = [PMLocationManager sharedInstance].gpsAddressCity;//ios系统字段，GPS地址城市
    self.processName = [self getProcessName];//进程名称
    self.activeProcessorCount = @"1";//活跃进程数量
    self.processorCount = [NSString stringWithFormat:@"%@",[self getProcessCount]];//进程数量
    self.physicalMemory = [self getPhysicalMemory];//物理内存
    self.processIdentifier = [self getProcessIdentifierAsString];//进程ID
    self.hostName = [self getHostName];//主机名称
    self.environment = [self getRuntimeEnvironment];//运行环境
    self.arguments = [self getRuntimeArgumentsAsString];//运行参数
    self.globallyUniqueString = [self getUUID];//全局唯一ID
    self.operatingSystemVersionString = [self getOperatingSystemVersionString];//操作系统字符串
    self.systemUptime = [self getSystemUptime];//系统开机时间
    self.thermalState = [self getThermalState];//热状态
    self.lowPowerModeEnabled = [self getLowPowerMode];//是否开启低电量模式

}

//-(void)GG{
//    if(@available(iOS13.0, *)) {
//
//            NSArray *arr = [UIApplication sharedApplication].connectedScenes.allObjects;
//
//            UIWindowScene*scene = arr.firstObject;
//
//            UIStatusBarManager*statusBarManager = scene.statusBarManager;
//
//            id statusBar =nil;
//
//            if([statusBarManagerrespondsToSelector:@selector(createLocalStatusBar)]) {
//
//                UIView*localStatusBar = [statusBarManagerperformSelector:@selector(createLocalStatusBar)];
//
//                if([localStatusBarrespondsToSelector:@selector(statusBar)]) {
//
//                    statusBar = [localStatusBarperformSelector:@selector(statusBar)];
//
//                }
//
//            }
//
//            if(statusBar) {
//
//                idcurrentData = [[statusBarvalueForKeyPath:@"_statusBar"]valueForKeyPath:@"currentData"];
//
//                idcellularEntry = [currentDatavalueForKeyPath:@"cellularEntry"];           if([cellularEntryisKindOfClass:NSClassFromString(@"_UIStatusBarDataIntegerEntry")]) {
//
//                    signalStrength = [[cellularEntryvalueForKey:@"displayValue"]intValue];
//
//                }
//
//            }
//
//        }
//
//
//
//    iOS13以下系统获取信号强度
//        UIApplication *app = [UIApplication sharedApplication];
//
//        NSArray*subviews = [[[appvalueForKey:@"statusBar"]valueForKey:@"foregroundView"]subviews];
//
//        NSString*dataNetworkItemView =nil;
//
//        for(idsubviewinsubviews) {
//
//            if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarSignalStrengthItemView") class]])
//
//            {
//
//                dataNetworkItemView = subview;
//
//                break;
//
//            }
//
//        }
//
//        NSIntegersignalStrength = [[dataNetworkItemViewvalueForKey:@"signalStrengthRaw"]intValue];
//
//        NSString*signalStrengthStr = [NSStringstringWithFormat:@"%lddBm",(long)signalStrength];
//
//    作者：花式写法
//    链接：https://www.jianshu.com/p/cfecd2cb2e05
//    来源：简书
//    著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
//}
- (NSString *)getRuntimeArgumentsAsString {
    NSProcessInfo *processInfo = [NSProcessInfo processInfo];
    NSArray<NSString *> *arguments = processInfo.arguments;
    NSString *argumentsString = [arguments componentsJoinedByString:@" "];
    return argumentsString;
}
- (NSString *)getRuntimeEnvironment {
    UIDevice *currentDevice = [UIDevice currentDevice];
    NSString *deviceModel = currentDevice.model;
    NSString *systemName = currentDevice.systemName;
    NSString *systemVersion = currentDevice.systemVersion;
    
    NSString *environment = [NSString stringWithFormat:@"Device: %@, OS: %@ %@", deviceModel, systemName, systemVersion];
    return environment;
}
- (NSString *)getProcessIdentifierAsString {
    NSProcessInfo *processInfo = [NSProcessInfo processInfo];
    NSInteger processIdentifier = processInfo.processIdentifier;
    NSString *processIdentifierString = [NSString stringWithFormat:@"%ld", (long)processIdentifier];
    return processIdentifierString;
}

- (NSString *)getVideoFileCountAsString {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsURL = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
    
    NSArray *videoFileExtensions = @[@"mp4", @"mov", @"avi", @"mkv"];
    NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtURL:documentsURL
                                          includingPropertiesForKeys:@[NSURLIsDirectoryKey]
                                                             options:NSDirectoryEnumerationSkipsHiddenFiles
                                                        errorHandler:nil];
    
    NSInteger videoFileCount = 0;
    for (NSURL *fileURL in enumerator) {
        NSString *fileExtension = fileURL.pathExtension.lowercaseString;
        if ([videoFileExtensions containsObject:fileExtension]) {
            videoFileCount++;
        }
    }
    
    NSString *countString = [NSString stringWithFormat:@"%ld", (long)videoFileCount];
    return countString;
}
-(NSString *)CFBundleIdentifier{
   NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appId = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    return appId;
}
- (NSString *)getAudioFileCountAsString {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsURL = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;

    NSArray *audioFileExtensions = @[@"mp3", @"m4a", @"wav", @"aac"];
    NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtURL:documentsURL
                                          includingPropertiesForKeys:@[NSURLIsDirectoryKey]
                                                             options:NSDirectoryEnumerationSkipsHiddenFiles
                                                        errorHandler:nil];

    NSInteger audioFileCount = 0;
    for (NSURL *fileURL in enumerator) {
        NSString *fileExtension = fileURL.pathExtension.lowercaseString;
        if ([audioFileExtensions containsObject:fileExtension]) {
            audioFileCount++;
        }
    }

    NSString *countString = [NSString stringWithFormat:@"%ld", (long)audioFileCount];
    return countString;
}

- (NSString *)getPhotoCountAsString {
    
    if (![self canUserLibrary]) {
        return @"0";
    } else {
        PHFetchResult *fetchResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:nil];
        NSInteger photoCount = fetchResult.count;
        NSString *countString = [NSString stringWithFormat:@"%ld", (long)photoCount];
        return countString;
    }
    

}
#pragma mark - 检查相册权限
-(BOOL)canUserLibrary{
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if (@available(iOS 14, *)) {
        if (authStatus == PHAuthorizationStatusAuthorized) {
            return YES;
        }else{
            return NO;
        }
    } else {
        if (authStatus == PHAuthorizationStatusAuthorized) {
            return YES;
        }else{
            return NO;
        }
    }
    if (@available(iOS 14, *)) {
        if ((authStatus == PHAuthorizationStatusAuthorized)|(authStatus == PHAuthorizationStatusLimited)) {
            return YES;
        }else{
            return NO;
        }
    } else {
        if (authStatus == PHAuthorizationStatusAuthorized) {
            return YES;
        }else{
            return NO;
        }
    }
}

- (NSString *)getFirstLoginTimeString {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDate *firstLoginTime = [userDefaults objectForKey:@"FirstLoginTime"];
    if(!firstLoginTime){
        firstLoginTime = [NSDate new];
    }
    
    return [NSString stringWithFormat:@"%f",firstLoginTime.timeIntervalSince1970];
    
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        NSString *firstLoginTimeString = [dateFormatter stringFromDate:firstLoginTime];
//        return firstLoginTimeString;
 
}
- (NSString *)getDownloadedFilesCountAsString {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *downloadDirectory = [NSSearchPathForDirectoriesInDomains(NSDownloadsDirectory, NSUserDomainMask, YES) firstObject];
    
    NSError *error;
    NSArray *files = [fileManager contentsOfDirectoryAtPath:downloadDirectory error:&error];
    
    if (error) {
        NSLog(@"Error accessing download directory: %@", error.localizedDescription);
        return @"0";
    }
    
    NSString *countString = [NSString stringWithFormat:@"%lu", (unsigned long)files.count];
    return countString;
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


/*
 * 获取设备物理地址
 */
//- (nullable NSString *)getMacAddress {
//    res_9_init();
//    int len;
//    //get currnet ip address
//    NSString *ip = [self currentIPAddressOf:IOS_WIFI];
//    if(ip == nil) {
//        fprintf(stderr, "could not get current IP address of en0\n");
//        return DUMMY_MAC_ADDR;
//    }//end if
//
//    //set port and destination
//    _res.nsaddr_list[0].sin_family = AF_INET;
//    _res.nsaddr_list[0].sin_port = htons(MDNS_PORT);
//    _res.nsaddr_list[0].sin_addr.s_addr = [self IPv4Pton:ip];
//    _res.nscount = 1;
//
//    unsigned char response[NS_PACKETSZ];
//
//
//    //send mdns query
//    if((len = res_9_query(QUERY_NAME, ns_c_in, ns_t_ptr, response, sizeof(response))) < 0) {
//
//        fprintf(stderr, "res_search(): %s\n", hstrerror(h_errno));
//        return DUMMY_MAC_ADDR;
//    }//end if
//
//    //parse mdns message
//    ns_msg handle;
//    if(ns_initparse(response, len, &handle) < 0) {
//        fprintf(stderr, "ns_initparse(): %s\n", hstrerror(h_errno));
//        return DUMMY_MAC_ADDR;
//    }//end if
//
//    //get answer length
//    len = ns_msg_count(handle, ns_s_an);
//    if(len < 0) {
//        fprintf(stderr, "ns_msg_count return zero\n");
//        return DUMMY_MAC_ADDR;
//    }//end if
//
//    //try to get mac address from data
//    NSString *macAddress = nil;
//    for(int i = 0 ; i < len ; i++) {
//        ns_rr rr;
//        ns_parserr(&handle, ns_s_an, 0, &rr);
//
//        if(ns_rr_class(rr) == ns_c_in &&
//           ns_rr_type(rr) == ns_t_ptr &&
//           !strcmp(ns_rr_name(rr), QUERY_NAME)) {
//            char *ptr = (char *)(ns_rr_rdata(rr) + 1);
//            int l = (int)strcspn(ptr, "@");
//
//            char *tmp = calloc(l + 1, sizeof(char));
//            if(!tmp) {
//                perror("calloc()");
//                continue;
//            }//end if
//            memcpy(tmp, ptr, l);
//            macAddress = [NSString stringWithUTF8String:tmp];
//            free(tmp);
//        }//end if
//    }//end for each
//    macAddress = macAddress ? macAddress : DUMMY_MAC_ADDR;
//    return macAddress;
//}//end getMacAddressFromMDNS



//- (nonnull NSString *)currentIPAddressOf: (nonnull NSString *)device {
//    struct ifaddrs *addrs;
//    NSString *ipAddress = nil;
//
//    if(getifaddrs(&addrs) != 0) {
//        return nil;
//    }//end if
//
//    //get ipv4 address
//    for(struct ifaddrs *addr = addrs ; addr ; addr = addr->ifa_next) {
//        if(!strcmp(addr->ifa_name, [device UTF8String])) {
//            if(addr->ifa_addr) {
//                struct sockaddr_in *in_addr = (struct sockaddr_in *)addr->ifa_addr;
//                if(in_addr->sin_family == AF_INET) {
//                    ipAddress = [self IPv4Ntop:in_addr->sin_addr.s_addr];
//                    break;
//                }//end if
//            }//end if
//        }//end if
//    }//end for
//
//    freeifaddrs(addrs);
//    return ipAddress;
//}//end currentIPAddressOf:
//
//- (nullable NSString *)IPv4Ntop: (in_addr_t)addr {
//    char buffer[INET_ADDRSTRLEN] = {0};
//    return inet_ntop(AF_INET, &addr, buffer, sizeof(buffer)) ?
//    [NSString stringWithUTF8String:buffer] : nil;
//}//end IPv4Ntop:
//
//- (in_addr_t)IPv4Pton: (nonnull NSString *)IPAddr {
//    in_addr_t network = INADDR_NONE;
//    return inet_pton(AF_INET, [IPAddr UTF8String], &network) == 1 ?
//    network : INADDR_NONE;
//}//end IPv4Pton:

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


// 获取设备电话类型的常量
- (NSString *)getPhoneType {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone12,1"]) return @"iPhone 11";
    if ([platform isEqualToString:@"iPhone12,3"]) return @"iPhone 11 Pro";
    if ([platform isEqualToString:@"iPhone12,5"]) return @"iPhone 11 Pro Max";
    if ([platform isEqualToString:@"iPhone12,8"]) return @"iPhone SE(2nd generation)";
    if ([platform isEqualToString:@"iPhone13,1"]) return @"iPhone 12 mini";
    if ([platform isEqualToString:@"iPhone13,2"]) return @"iPhone 12";
    if ([platform isEqualToString:@"iPhone13,3"]) return @"iPhone 12 Pro";
    if ([platform isEqualToString:@"iPhone13,4"]) return @"iPhone 12 Pro Max";
    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad 1G";
    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad Mini 2G";
    if ([platform isEqualToString:@"i386"]) return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    return platform;
}


// 获取运营商无线接入技术
- (NSString *)getWirelessTechnology {
    
    if (@available(iOS 12.0, *)) {
        NSDictionary *dict = [[[CTTelephonyNetworkInfo alloc] init] serviceCurrentRadioAccessTechnology];
        NSString * scratString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        return scratString;
    } else {
        CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
        NSString *currentRadioAccessTechnology = networkInfo.currentRadioAccessTechnology;
        return currentRadioAccessTechnology;
    }
    


    
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

- (NSString *)getWifiMacAddress {
    NSArray *ifs = CFBridgingRelease(CNCopySupportedInterfaces());
    id info = nil;
    for (NSString *ifname in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((CFStringRef) ifname);
        if (info && [info count]) {break;
            
        }
        
    }
    NSDictionary *dic = (NSDictionary *)info;NSString *bssid = [dic objectForKey:@"BSSID"];
    return bssid;
}



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

- (NSString *)getLastBootTime {
    NSProcessInfo *info = [NSProcessInfo processInfo];
        
        NSTimeInterval timer_ = info.systemUptime;//开机多久
        NSDate *currentDate = [NSDate new];
        NSDate *startTime = [currentDate dateByAddingTimeInterval:(timer_)];
        NSTimeInterval convertStartTimeToSecond = [startTime timeIntervalSince1970];//上次开机时间
    return  [NSString stringWithFormat:@"%f",convertStartTimeToSecond];
}

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


//获取网络信号强度（dBm）
- (int)getSignalStrength{
    int signalStrength = 0;
      
      void *libHandle = dlopen("/System/Library/Frameworks/CoreTelephony.framework/CoreTelephony", RTLD_LAZY);
      if (libHandle) {
          int (*CTGetSignalStrength)(void);
          CTGetSignalStrength = (int (*)(void))dlsym(libHandle, "CTGetSignalStrength");
          if (CTGetSignalStrength) {
              signalStrength = CTGetSignalStrength();
          }
          dlclose(libHandle);
      }
      
      return signalStrength;
}


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
    NSString *memoryString = [NSString stringWithFormat:@"%llu", physicalMemory * 8];
    return memoryString;
//    return [NSByteCountFormatter stringFromByteCount:physicalMemory countStyle:NSByteCountFormatterCountStyleMemory];
}

- (NSString *)getTotalStorage {
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *totalSize = [fileAttributes objectForKey:NSFileSystemSize];
    NSString *totalSizeString = [NSString stringWithFormat:@"%llu", [totalSize longLongValue]* 8];
       return totalSizeString;
//    return [NSByteCountFormatter stringFromByteCount:totalSize.longLongValue countStyle:NSByteCountFormatterCountStyleBinary];
}

- (NSString *)getFreeStorage {
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *freeSize = [fileAttributes objectForKey:NSFileSystemFreeSize];
    
    NSString *freeSizeString = [NSString stringWithFormat:@"%llu", [freeSize longLongValue]* 8];
       return freeSizeString;
//    return [NSByteCountFormatter stringFromByteCount:freeSize.longLongValue countStyle:NSByteCountFormatterCountStyleBinary];
}

//- (NSString *)getWifiName{
//    NSString *ssid = nil;
//      NSArray *interfaceNames = CFBridgingRelease(CNCopySupportedInterfaces());
//      for (NSString *interfaceName in interfaceNames) {
//          NSDictionary *networkInfo = CFBridgingRelease(CNCopyCurrentNetworkInfo((__bridge CFStringRef)interfaceName));
//          if (networkInfo[@"SSID"]) {
//              ssid = networkInfo[@"SSID"];
//              break;
//          }
//      }
//      return ssid;
//}



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
    
    NSArray * supports =  (__bridge_transfer id)CNCopySupportedInterfaces();
    
    id SSID = nil;//WiFi标示

    id info = nil;
    
    BOOL isWiFiEnabled = NO;
    for(NSString * idf in supports){
        info =  (__bridge_transfer id)CNCopyCurrentNetworkInfo((CFStringRef)idf);
        if (info&&[info count]) {
            isWiFiEnabled = YES;
            break;
        }
        
    }
    
    SSID = [info objectForKey:@"SSID"];
    if(SSID){
        self.wifiName = SSID;
    }
    
    return [NSString stringWithFormat:@"%d",isWiFiEnabled];
    
}


//
//- (NSString * )getScreenResolution {
//    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
//    CGFloat scale = [[UIScreen mainScreen] scale];
//
//    return [NSString stringWithFormat:@"%.0f", scale];
//}
- (NSString *)getScreenResolution {
    UIScreen *mainScreen = [UIScreen mainScreen];
    CGFloat scale = mainScreen.scale;
    CGRect bounds = mainScreen.bounds;
    CGSize size = CGSizeMake(bounds.size.width * scale, bounds.size.height * scale);
    NSString *resolution = [NSString stringWithFormat:@"%.0f x %.0f", size.width, size.height];
    return resolution;
}

- (NSString *)getIDFV {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

- (void )getIDFA {
    
    NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    self.idfa = idfa;
//    NSString *idfa = @"";
//    if (@available(iOS 14, *)) {
//        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
//            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
//                // 用户已授权访问IDFA
//                NSString * idfa1111 = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
//
//                NSLog(@"IDFA: %@", idfa1111);
//                self.idfa = idfa1111;
//
//            }else {
//                // 此时用户点击拒绝则无法读取
//                NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
//                self.idfa = idfa;
//            }
//        }];
//    } else {
//        // 在iOS 14之前的版本可以直接访问IDFA
//        idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
//
//        self.idfa = idfa;
//        NSLog(@"IDFA: %@", idfa);
//    }
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
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDictionary objectForKey:@"CFBundleName"];
    return appName;
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
