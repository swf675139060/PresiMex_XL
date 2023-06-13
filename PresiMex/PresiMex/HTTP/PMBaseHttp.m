//
//  PMBaseHttp.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/27.
//

#import "PMBaseHttp.h"
#import "MD5Utils.h"

@implementation PMBaseHttp

static inline BOOL IsEmpty(id thing){
   return thing == nil || [thing isEqual:[NSNull null]]
        || ([thing respondsToSelector:@selector(length)]
            && [(NSData *)thing length] == 0)
        || ([thing respondsToSelector:@selector(count)]
            && [(NSArray *)thing count] == 0);
}


+ (void)startNetWorkingMonitoring
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus  status) {
        NSLog(@"netWorking  Status : %ld", (long)status);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NetWorkingStatus" object:@(status)];
    }];
}


+ (AFNetworkReachabilityStatus)getNetWorkingStatus {
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}


/**
 *  向服务端发起Get请求
 *
 *  @param urlString url地址
 *  @param parameter 参数
 *  @param success   成功回调
 *  @param failure   失败回调
 */
+ (NSURLSessionDataTask*)get:(NSString *)urlString parameters:(id)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        NSError *error = [NSError errorWithDomain:@"CustomeErrorDomain" code:0001 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"网络连接失败，请检查网络设置", NSLocalizedDescriptionKey, nil]];
        if (failure) {
            failure(error);
        }
        return nil;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    //manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60;//30.0;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //[manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"81f39018d78533c158665aa7945c6a95" forHTTPHeaderField:@"LOAN_HEAD_APP_ID"];
    if ([PMAccountTool isLogin]) {
        NSLog(@"token= %@",[PMAccountTool account].token);
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", [PMAccountTool account].token] forHTTPHeaderField:@"Authentication"];
    }
    NSString *vers=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:vers forHTTPHeaderField:@"LOAN_HEAD_VERSION"];
    NSString*deviceID=[[NSString alloc] initWithString:[UIDevice currentDevice].identifierForVendor.UUIDString];
    deviceID=[deviceID stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [manager.requestSerializer setValue:[MD5Utils md5ContentWithOrigin:deviceID] forHTTPHeaderField:@"LOAN_HEAD_DEVICE_ID"];
    //[manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    AFSecurityPolicy * securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    
    NSString *urlEpt=[NSString stringWithFormat:@"%@%@",API_URL,urlString];
    NSString *url = [urlEpt stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
    
    //参数加密
    
    
   // NSMutableDictionary*par=[NSMutableDictionary new];
    //        if ([parameter isKindOfClass:[NSDictionary class]] ) {
    //            NSDictionary*dict=parameter;
    //            NSArray*keyArr=dict.allKeys;
    //            for (NSString *key in keyArr) {
    //                if ([key isEqual:@"arch_id"]) {
    //                    par[key]=dict[key];
    //                }else{
    //                    NSString *values=dict[key];
    //                    NSString *enCodeValues=[self encodeString:values];
    //                    par[key]=enCodeValues;
    //                }
    //
    //            }
    //        }
   // NSMutableDictionary *parms = [NSMutableDictionary dictionaryWithDictionary:par];
    //        NSString *ras=HTTPKEY_RAS_RELEES;
    //        parms[@"akeys"]=[PSBase64 encodeBase64:[RSA encryptString:HTTP_KEY publicKey:ras]];
    //        if ([PSAccountTool account]) {
    //            parms[@"token"]=[PSAccountTool account].token;
    //        }
    NSLog(@"url===%@\n parms==%@",url,parameter);
    
    //   NSLog(@"----url---\n%@\n----header---\n%@\n----parms---\n%@",url,manager.requestSerializer.HTTPRequestHeaders,parameter);
    
    //NSString*josn=[parms toJSONString];
    return [manager GET:url parameters:parameter headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       NSDictionary*dict=[self dictionaryForJsonData:responseObject];
        NSLog(@"url===%@\nget_responseObject=%@",url,dict);
        //       if (!IsEmpty(responseObject) &&[responseObject[@"code"] intValue]==2003&& [responseObject[@"msg"] isEqual:@"Token Non-existent"]) {
        //           [PSAccountTool logOut];
        //       }else if([responseObject[@"error"] isEqual:@"Please login"]&&!([responseObject[@"code"] intValue]==202)){
        //           [PSAccountTool logOut];
        //       }
        
        if (success) {
            success(dict);
        }
        // 测试代码
        //       if ([responseObject[@"code"] intValue] == 0) {
        //           if (success) {
        //               success(responseObject[@"data"]);
        //           }
        //       }else {
        //           // 这里统一把code 改成了-1 用作判断 来区分真正的failure
        //           NSError *error;
        //           if([responseObject[@"code"] intValue] == 510) {
        //               error = [NSError errorWithDomain:@"CustomeErrorDomain" code:-1 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"服务器异常", NSLocalizedDescriptionKey, nil]];
        //           }else {
        //               error = [NSError errorWithDomain:@"CustomeErrorDomain" code:-1 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseObject[@"msg"], NSLocalizedDescriptionKey, nil]];
        //           }
        //           if (failure) {
        //               failure(error);
        //           }
        //       }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            NSString *msg = @"";
            if ([error.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {
                id response = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
                NSLog(@"%@",response);
                msg = [NSString stringWithFormat:@"%@",response[@"msg"]] ?: @"";
                if ([msg containsString:@"Invalid access"]) {
                    NSLog(@"token失效");
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"tokenError" object:nil userInfo:nil];
                    failure(nil);
                    return;
                }else {
                    failure(error);
                    return;
                }
            }
            
            NSString *errDes = @"网络或服务器异常";
            switch (error.code) {
                case -1001:
                    errDes = @"请求超时";
                    break;
                case 404:
                    errDes = @"没有数据";
                    break;
                case 500:
                    errDes = @"服务器错误";
                    break;
                case -1017:
                    errDes = @"数据解析错误";
                    break;
                case 401:
                    errDes = msg;
                    break;
                default:
                    break;
            }
            error = [NSError errorWithDomain:@"CustomeErrorDomain" code:error.code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@ (%@)", errDes, @(error.code)], NSLocalizedDescriptionKey, nil]];
            failure(error);
        }
    }];
    
}


+ (NSURLSessionDataTask*)post:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 获取请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", @"multipart/form-data",@"application/octet-stream", nil];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60;//30.0;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"81f39018d78533c158665aa7945c6a95" forHTTPHeaderField:@"LOAN_HEAD_APP_ID"];
    NSString *vers=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:vers forHTTPHeaderField:@"LOAN_HEAD_VERSION"];
    NSString*deviceID=[[NSString alloc] initWithString:[UIDevice currentDevice].identifierForVendor.UUIDString];
    deviceID=[deviceID stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [manager.requestSerializer setValue:[MD5Utils md5ContentWithOrigin:deviceID] forHTTPHeaderField:@"LOAN_HEAD_DEVICE_ID"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    if ([PMAccountTool isLogin]) {
        NSLog(@"token= %@",[PMAccountTool account].token);
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", [PMAccountTool account].token] forHTTPHeaderField:@"Authentication"];
    }
    AFSecurityPolicy * securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    NSString *urlEpt=[NSString stringWithFormat:@"%@%@",API_URL,URLString];
    NSString *url = [urlEpt stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
    NSLog(@"----url---\n%@\n----header---\n%@\n----parms---\n%@",url,manager.requestSerializer.HTTPRequestHeaders,parameters);
    return  [manager POST:url parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if(!IsEmpty(responseObject)){
            if (responseObject) {
                success(responseObject);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            if ([error.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {
                id response = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
                NSLog(@"%@",response);
                NSString *msg = [NSString stringWithFormat:@"%@",response[@"msg"]] ?: @"";
                if ([msg containsString:@"Invalid access"]) {
                    NSLog(@"token失效");
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"tokenError" object:nil userInfo:nil];
                    failure(nil);
                    return;
                }
            }
#ifdef Debug
            failure(error);
#else
            NSString *errDes = @"网络或服务器异常";
            switch (error.code) {
                case -1001:
                    errDes =@"请检查您的网络";
                    break;
                case 404:
                    errDes = @"没有数据";
                    break;
                case 500:
                    errDes = @"服务器错误";
                    break;
                case -1017:
                    errDes = @"数据解析错误";
                    break;
                default:
                    break;
            }
            error = [NSError errorWithDomain:@"CustomeErrorDomain" code:error.code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@ (%@)", errDes, @(error.code)], NSLocalizedDescriptionKey, nil]];
            failure(error);
#endif
        }
    }];
    
}



+ (NSURLSessionDataTask*)postJson:(NSString *)URLString
            parameters:(id)parameters
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
   // manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", @"multipart/form-data",@"application/octet-stream", nil];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60;//30.0;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"81f39018d78533c158665aa7945c6a95" forHTTPHeaderField:@"LOAN_HEAD_APP_ID"];
    NSString *vers=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:vers forHTTPHeaderField:@"LOAN_HEAD_VERSION"];
    NSString*deviceID=[[NSString alloc] initWithString:[UIDevice currentDevice].identifierForVendor.UUIDString];
    deviceID=[deviceID stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [manager.requestSerializer setValue:[MD5Utils md5ContentWithOrigin:deviceID] forHTTPHeaderField:@"LOAN_HEAD_DEVICE_ID"];
   [manager.requestSerializer setValue:@"application/json;charset=UTF-8"  forHTTPHeaderField:@"Content-Type"];
    if ([PMAccountTool isLogin]) {
        NSLog(@"token= %@",[PMAccountTool account].token);
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", [PMAccountTool account].token] forHTTPHeaderField:@"Authentication"];
    }
    AFSecurityPolicy * securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    NSString *urlEpt=[NSString stringWithFormat:@"%@%@",API_URL,URLString];
    NSString *url = [urlEpt stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
    NSLog(@"----url---\n%@\n----header---\n%@\n----parms---\n%@",url,manager.requestSerializer.HTTPRequestHeaders,parameters);
    return  [manager POST:url parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
         if(!IsEmpty(responseObject)){
//            if (responseObject) {
//                success(responseObject);
//            }
             NSDictionary*dict=[self dictionaryForJsonData:responseObject];
             success(dict);
             NSLog(@"%@",dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error==%@",error);
        if (failure) {
            failure(error);
        }
    }];
    
    
}


#pragma mark - 上传照片
+ (void)uploadImg:(UIImage *)image parameter:(NSDictionary *)parameter success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", @"multipart/form-data",@"application/octet-stream", nil];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60;//15.0;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"81f39018d78533c158665aa7945c6a95" forHTTPHeaderField:@"LOAN_HEAD_APP_ID"];
    NSString *vers=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:vers forHTTPHeaderField:@"LOAN_HEAD_VERSION"];
    NSString*deviceID=[[NSString alloc] initWithString:[UIDevice currentDevice].identifierForVendor.UUIDString];
    deviceID=[deviceID stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [manager.requestSerializer setValue:[MD5Utils md5ContentWithOrigin:deviceID] forHTTPHeaderField:@"LOAN_HEAD_DEVICE_ID"];
    //[manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    if ([PMAccountTool isLogin]) {
        NSLog(@"token= %@",[PMAccountTool account].token);
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", [PMAccountTool account].token] forHTTPHeaderField:@"Authentication"];
    }
   
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];
    NSString *urlEpt=[NSString stringWithFormat:@"%@%@?supposed=feedback",API_URL,POST_Image_File];
    NSString *url = [urlEpt stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
   NSLog(@"----url---\n%@\n----header---\n%@\n----parms---\n%@",url,manager.requestSerializer.HTTPRequestHeaders,parameter);
    [manager POST:url parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
//         UIImage *image = [UIImage imageNamed:@"test"];
        
        //UIImage* uploadImg = [image scaleToMaxSideLength:1920 andMaxSize:1024*1024*3];
        
        NSData *imageData = UIImageJPEGRepresentation(image, 0.3);//进行图片压缩
        
         // 使用日期生成图片名称
         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
         formatter.dateFormat = @"yyyyMMddHHmmss";
         NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
         // 任意的二进制数据MIMEType application/octet-stream
         [formData appendPartWithFileData:imageData name:@"img" fileName:fileName mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {

        NSLog(@"上传进度  %lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary*dict=[self dictionaryForJsonData:responseObject];
//        NSLog(@"resultInfo is %@",responseObject);
//        NSString *imgUrl =  responseObject[@"data"][@"url"];
//        NSLog(@"%@",imgUrl);
        success(dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"resultInfo is %@",error);
        if ([error.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {
            id response = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
            NSLog(@"%@",response);
            NSString *msg = [NSString stringWithFormat:@"%@",response[@"msg"]] ?: @"";
            if ([msg containsString:@"Invalid access"]) {
                NSLog(@"token失效");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"tokenError" object:nil userInfo:nil];
                failure(nil);
                return;
            }
        }
        failure(error);
    }];


}



#pragma mark - 上传照片
//+ (void)uploadImgs:(NSArray *)images parameter:(NSDictionary *)parameter success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    //manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", @"multipart/form-data",@"application/octet-stream", nil];
//    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    //manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    //manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    manager.requestSerializer.timeoutInterval = 60;//15.0;
//    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//    [manager.requestSerializer setValue:@"81f39018d78533c158665aa7945c6a95" forHTTPHeaderField:@"LOAN_HEAD_APP_ID"];
//    NSString *vers=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    [manager.requestSerializer setValue:vers forHTTPHeaderField:@"LOAN_HEAD_VERSION"];
//    NSString*deviceID=[[NSString alloc] initWithString:[UIDevice currentDevice].identifierForVendor.UUIDString];
//    deviceID=[deviceID stringByReplacingOccurrencesOfString:@"-" withString:@""];
//    [manager.requestSerializer setValue:[MD5Utils md5ContentWithOrigin:deviceID] forHTTPHeaderField:@"LOAN_HEAD_DEVICE_ID"];
//    //[manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
//    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
//    if ([PMAccountTool isLogin]) {
//        NSLog(@"token= %@",[PMAccountTool account].token);
//        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", [PMAccountTool account].token] forHTTPHeaderField:@"Authentication"];
//    }
//   
//    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    manager.securityPolicy.allowInvalidCertificates = YES;
//    [manager.securityPolicy setValidatesDomainName:NO];
//    NSString *urlEpt=[NSString stringWithFormat:@"%@%@?supposed=feedback",API_URL,POST_Image_File];
//    NSString *url = [urlEpt stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
//   NSLog(@"----url---\n%@\n----header---\n%@\n----parms---\n%@",url,manager.requestSerializer.HTTPRequestHeaders,parameter);
//    [manager POST:url parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//        
//        int i = 0;
//        for (UIImage *image in images) {
//            NSData *imageData = UIImageJPEGRepresentation(image, 0.3);//进行图片压缩
//            
//             // 使用日期生成图片名称
//             NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//             formatter.dateFormat = @"yyyyMMddHHmmss";
//            NSString *fileName = [NSString stringWithFormat:@"%@%d.png",[formatter stringFromDate:[NSDate date]],i++];
//            
//            // 任意的二进制数据MIMEType application/octet-stream
//            [formData appendPartWithFileData:imageData name:@"img" fileName:fileName mimeType:@"image/png"];
//        }
//        
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//        NSLog(@"上传进度  %lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary*dict=[self dictionaryForJsonData:responseObject];
////        NSLog(@"resultInfo is %@",responseObject);
////        NSString *imgUrl =  responseObject[@"data"][@"url"];
////        NSLog(@"%@",imgUrl);
//        success(dict);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"resultInfo is %@",error);
//        if ([error.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {
//            id response = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
//            NSLog(@"%@",response);
//            NSString *msg = [NSString stringWithFormat:@"%@",response[@"msg"]] ?: @"";
//            if ([msg containsString:@"Invalid access"]) {
//                NSLog(@"token失效");
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"tokenError" object:nil userInfo:nil];
//                failure(nil);
//                return;
//            }
//        }
//        failure(error);
//    }];
//
//
//}


//data 转 json 字符串
+ (NSDictionary *)dictionaryForJsonData:(NSData *)jsonData

{


    if (![jsonData isKindOfClass:[NSData class]] || jsonData.length < 1) {

        return nil;

    }
    NSString* gbkStr = [[NSString alloc] initWithData:jsonData encoding:NSASCIIStringEncoding];
    NSData *jsonDa=[gbkStr dataUsingEncoding:NSUTF8StringEncoding];
   //转码之后再转utf8解析
   NSDictionary *requestDic = [NSJSONSerialization JSONObjectWithData:jsonDa options:NSJSONReadingMutableContainers error:nil];

    if (![requestDic isKindOfClass:[NSDictionary class]]) {

        return nil;

    }

    return [NSDictionary dictionaryWithDictionary:(NSDictionary *)requestDic];

}

/// 上传多图
/// @param images 图片
/// @param parameters 参数
/// @param progress 进度
/// @param success 成功回调
/// @param failure 失败回调
+ (void)uploadImages:(NSArray *)images
            parameters:(id _Nullable)parameters
            progress:(void (^ _Nullable)(CGFloat progress))progress
            success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60;//15.0;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"81f39018d78533c158665aa7945c6a95" forHTTPHeaderField:@"LOAN_HEAD_APP_ID"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", @"multipart/form-data",@"application/octet-stream", nil];
    NSString *vers=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:vers forHTTPHeaderField:@"LOAN_HEAD_VERSION"];
    NSString*deviceID=[[NSString alloc] initWithString:[UIDevice currentDevice].identifierForVendor.UUIDString];
    deviceID=[deviceID stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [manager.requestSerializer setValue:[MD5Utils md5ContentWithOrigin:deviceID] forHTTPHeaderField:@"LOAN_HEAD_DEVICE_ID"];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    if ([PMAccountTool isLogin]) {
        NSLog(@"token= %@",[PMAccountTool account].token);
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", [PMAccountTool account].token] forHTTPHeaderField:@"Authentication"];
    }
   
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];
    NSString *urlEpt=[NSString stringWithFormat:@"%@%@?supposed=feedback",API_URL,POST_Image_File];
    NSString *url = [urlEpt stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
   NSLog(@"----url---\n%@\n----header---\n%@\n----parms---\n%@",url,manager.requestSerializer.HTTPRequestHeaders,parameters);
    
    [manager POST:url parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        int i = 0;
        //根据当前系统时间生成图片名称
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *dateString = [formatter stringFromDate:date];
        for (UIImage *image in images) {
            i++;
            NSString *fileName = [NSString stringWithFormat:@"%@%d.png",dateString,i];
            NSData *imageData;
            imageData = UIImageJPEGRepresentation(image, 0.5f);
            [formData appendPartWithFileData:imageData name:@"img" fileName:fileName mimeType:@"image/png"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                progress(uploadProgress.fractionCompleted);
            });
        }
        NSLog(@"上传进度  %lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary*dict=[self dictionaryForJsonData:responseObject];
        if (!IsEmpty(dict)) {
            success(dict);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([error.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {
            id response = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
            NSString *msg = [NSString stringWithFormat:@"%@",response[@"msg"]] ?: @"";
            if ([msg containsString:@"Invalid access"]) {
               
                [[NSNotificationCenter defaultCenter] postNotificationName:@"tokenError" object:nil userInfo:nil];
                failure(nil);
                return;
            }
        }
        failure(error);
    }];
}


@end
