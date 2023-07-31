//
//  PMDotManager.m
//  PresiMex
//
//  Created by shenwenfeng on 2023/7/22.
//

#import "PMDotManager.h"
#import "PMDotConfigModel.h"
#import <CommonCrypto/CommonCrypto.h>
#import "AESCGMEnrypt.h"

@interface PMDotManager()
@property(strong, nonatomic) PMDotConfigModel * configModel;
@end

@implementation PMDotManager

+ (PMDotManager *)sharedInstance {
    static PMDotManager *sharedInstance;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


//获取埋点配置
-(void)GETDotConfigModelBlock:(void (^)(PMDotConfigModel * ConfigModel)) configModelBlock{
    if (self.configModel) {
        configModelBlock(self.configModel);
        return;
    }
    
    NSMutableDictionary *pars=[NSMutableDictionary dictionary];
    WF_WEAKSELF(weakself);
    
    [PMBaseHttp get:GET_DOT_j1vka parameters:pars success:^(id  _Nonnull responseObject) {

        if ([responseObject[@"isav"] intValue]==200) {

            PMDotConfigModel * ConfigModel = [PMDotConfigModel mj_objectWithKeyValues:responseObject[@"dtsaw"]];
            weakself.configModel = ConfigModel;
            configModelBlock(ConfigModel);
            

        }else{
            
        }
        
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
}


-(void)POSTDotDevType:(NSInteger)type value:(PMDeviceModel *)valueDic{
    
    if(type == 20){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *taskKey = @"MyTask20";
        if ([defaults objectForKey:taskKey] == nil) {
            // 执行你要执行的事情
            [self POSTDotType:type value:[valueDic mj_JSONObject]];
            // 将键名对应的值设置为当前日期
            [defaults setObject:[NSDate date] forKey:taskKey];
        }else{
            NSDate *lastDate = [defaults objectForKey:taskKey];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            if (![calendar isDateInToday:lastDate]) {
                // 执行你要执行的事情
                [self POSTDotType:type value:[valueDic mj_JSONObject]];
                // 将键名对应的值设置为当前日期
                [defaults setObject:[NSDate date] forKey:taskKey];
            }
        }
        
    }else{
        
        [self POSTDotType:type value:[valueDic mj_JSONObject]];
    }
}


-(void)POSTDotACQ40Withvalue:(PMACQInfoModel *)InfoModel{
    PMACQManager * ACQManager= [PMACQManager sharedInstance];
    [ACQManager.ACQModel40.value addObject:InfoModel];
    ACQManager.ACQModel40.create_time = [PMACQManager GetTimestampString];
    [self POSTDotType:40 value:[PMACQInfoModel mj_keyValuesArrayWithObjectArray:ACQManager.ACQModel40.value]];
    [ACQManager.ACQModel40.value removeAllObjects];
}

-(void)POSTDotACQ50Withvalue:(PMACQInfoModel *)InfoModel{
    
    PMACQManager * ACQManager= [PMACQManager sharedInstance];
    [ACQManager.ACQModel50.value addObject:InfoModel];
    
    [self POSTDotType:50 value:[PMACQInfoModel mj_keyValuesArrayWithObjectArray:ACQManager.ACQModel50.value]];
    
}

-(void)POSTDotACQ60Withvalue:(PMACQInfoModel *)InfoModel{
    
    PMACQManager * ACQManager= [PMACQManager sharedInstance];
    [ACQManager.ACQModel60.value addObject:InfoModel];
    ACQManager.ACQModel60.create_time = [PMACQManager GetTimestampString];
    [self POSTDotType:60 value:[PMACQInfoModel mj_keyValuesArrayWithObjectArray:ACQManager.ACQModel60.value]];
    [ACQManager.ACQModel60.value removeAllObjects];
}

//埋点数据存库接口

//type 10用户注册 20打开app客户端 30用户登录 40联系人上传后 50acq客户端缓存满20条 60用户点击申请借款后 70间隔1小时

-(void)POSTDotType:(NSInteger)type value:(id )valueDic{
    //未登陆不打点
    if (![PMAccountTool isLogin]){
        return;
    }
    
    
    [self GETDotConfigModelBlock:^(PMDotConfigModel *ConfigModel) {
        if (type == 50) {
            
            PMACQManager * ACQManager= [PMACQManager sharedInstance];
            if (ACQManager.ACQModel50.value.count >= [ConfigModel.cogsqqv intValue]) {
                ACQManager.ACQModel50.create_time = [PMACQManager GetTimestampString];
                [ACQManager.ACQModel50.value removeAllObjects];
            }else{
                return;
            }
        }
        
        NSMutableDictionary *pars=[NSMutableDictionary dictionary];
        if ([PMAccountTool isLogin]) {
            [pars setObject:[PMAccountTool account].customer_user_id forKey:@"n4asjo"];
        } else {
            [pars setObject:@"" forKey:@"n4asjo"];
        }
        //埋点类型
        if (type == 10 || type == 20  || type == 30 ) {
           [pars setObject:@"dev，loc" forKey:@"lkvjhs"];
        } else {
            [pars setObject:@"acq" forKey:@"lkvjhs"];
        }
        //App产品标识
        [pars setObject:@"com.prsi.PresiMex" forKey:@"dsdqlwa"];
        
        //详细数据
        NSString * value = [self dicToBase64:valueDic];
        [pars setObject:value forKey:@"ksh1sbuw"];
        
        //数据上报类型
        [pars setObject:[NSString stringWithFormat:@"%ld",type] forKey:@"ldj2dua"];
        
        WF_WEAKSELF(weakself);
        [PMBaseHttp postJson:POST_DOT_nxjs3kl parameters:pars success:^(id  _Nonnull responseObject) {

            if ([responseObject[@"isav"] intValue]==200) {

                NSLog(@"PAC成功");

            }else{
                
                NSLog(@"PAC失败");
            }
            
        } failure:^(NSError * _Nonnull error) {
            
            
            NSLog(@"PAC请求失败");
        }];
        
        
    }];
 
}

-(NSString *)dicToBase64:(id)dic{
    //0.dic ->jsonData
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    
    if (error) {
        return nil;
    }
    
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    //1jsonString ->AES/GCM/NoPadding
    NSString * Base64 =[AESCGMEnrypt encryptAESCBC:jsonString withKey:self.configModel.cnmwd];
    return Base64;
//    NSData *iv = [@"0000000000000000" dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *keydata = [self.configModel.cnmwd dataUsingEncoding:NSUTF8StringEncoding];
//    NSData * AESData =[self encryptAES_GCM_NoPadding:jsonData key:keydata iv:iv];
//
//    //2 AES/GCM/NoPadding->Base64
//   NSString * Base64 = [self base64EncodedStringWithoutLineBreaks:AESData];
//    return Base64;
    
    
    
}


/**
 *  字典转 json字符串
 *
 *  @return json字符串
 */
-(NSString *)dictionaryToJsonString:(NSDictionary *)dic
{
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    
    if (error) {
        return nil;
    }
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


- (NSString *)base64EncodedStringWithoutLineBreaks:(NSData *)data {
    NSString *encodedText = [data base64EncodedStringWithOptions:0];
    return encodedText;
}


// AES/GCM/NoPadding加密函数
- (NSData *)encryptAES_GCM_NoPadding:(NSData *)data key:(NSData *)key iv:(NSData *)iv {
    // GCM模式要求IV长度为12字节，如果不足，则需要进行补位
    if (iv.length != kCCBlockSizeAES128) {
        return nil;
    }

    NSMutableData *cipherData = [NSMutableData dataWithLength:data.length + kCCBlockSizeAES128];
    size_t outLength;

    // 设置加密选项
    CCCryptorStatus result = CCCrypt(kCCEncrypt,
                                     kCCAlgorithmAES,
                                     kCCOptionPKCS7Padding, // 使用PKCS7Padding来填充数据
                                     key.bytes, key.length,
                                     iv.bytes,
                                     data.bytes, data.length,
                                     cipherData.mutableBytes, cipherData.length,
                                     &outLength);

    if (result != kCCSuccess) {
        return nil;
    }

    // 更新cipherData的长度
    cipherData.length = outLength;

    // 将IV追加到密文数据的末尾，用于解密时使用
    [cipherData appendData:iv];

    return cipherData;
}


/// 上传异常
/// - Parameter valueDic: 异常数据
-(void)POSTDotCrashDic:(NSDictionary *)valueDic{
    
    [PMAccountTool isLogin];
    
    
    WF_WEAKSELF(weakself);
    [PMBaseHttp postJson:POST_bengKui parameters:valueDic success:^(id  _Nonnull responseObject) {

        if ([responseObject[@"isav"] intValue]==200) {

            NSLog(@"crash成功");

        }else{
            
            NSLog(@"crash失败");
        }
        
    } failure:^(NSError * _Nonnull error) {
        
        
        NSLog(@"crash请求失败");
    }];
}
@end
