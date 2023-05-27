//
//  PMBaseHttp.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/27.
//

#import "PMBaseHttp.h"

@implementation PMBaseHttp

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
   manager.responseSerializer = [AFJSONResponseSerializer serializer];
   manager.requestSerializer = [AFJSONRequestSerializer serializer];
   [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
   manager.requestSerializer.timeoutInterval = 60;//30.0;
   [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
   [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
   [manager.requestSerializer setValue:@"LOAN_HEAD_APP_ID" forHTTPHeaderField:@"81f39018d78533c158665aa7945c6a95"];

    AFSecurityPolicy * securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;

    NSString *urlEpt=[NSString stringWithFormat:@"%@%@",API_URL,urlString];
    NSString *url = [urlEpt stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
    
    //参数加密

   
        NSMutableDictionary*par=[NSMutableDictionary new];
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
        NSMutableDictionary *parms = [NSMutableDictionary dictionaryWithDictionary:par];
//        NSString *ras=HTTPKEY_RAS_RELEES;
//        parms[@"akeys"]=[PSBase64 encodeBase64:[RSA encryptString:HTTP_KEY publicKey:ras]];
//        if ([PSAccountTool account]) {
//            parms[@"token"]=[PSAccountTool account].token;
//        }
        NSLog(@"url===%@\n parms==%@",url,parms);
   
//   NSLog(@"----url---\n%@\n----header---\n%@\n----parms---\n%@",url,manager.requestSerializer.HTTPRequestHeaders,parameter);

    //NSString*josn=[parms toJSONString];
   return [manager GET:url parameters:parms headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       NSLog(@"url===%@\nget_responseObject=%@",url,responseObject);
//       if (!IsEmpty(responseObject) &&[responseObject[@"code"] intValue]==2003&& [responseObject[@"msg"] isEqual:@"Token Non-existent"]) {
//           [PSAccountTool logOut];
//       }else if([responseObject[@"error"] isEqual:@"Please login"]&&!([responseObject[@"code"] intValue]==202)){
//           [PSAccountTool logOut];
//       }
       
       if (success) {
           success(responseObject);
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
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60;//30.0;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"LOAN_HEAD_APP_ID" forHTTPHeaderField:@"81f39018d78533c158665aa7945c6a95"];
//    [manager.requestSerializer setValue:@"app" forHTTPHeaderField:@"client_secret"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
      
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"opeso" ofType:@"cer"];
//    NSData *certData=[NSData dataWithContentsOfFile:cerPath];
//    AFSecurityPolicy *securityPolicy =[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    [securityPolicy setAllowInvalidCertificates:NO];
//    [securityPolicy setPinnedCertificates:@[certData]];
//    securityPolicy.allowInvalidCertificates = NO;
//    [securityPolicy setValidatesDomainName:NO];
//
//    manager.securityPolicy = securityPolicy;
   
    AFSecurityPolicy * securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    //参数加密
    NSMutableDictionary*par=[NSMutableDictionary new];
    if ([parameters isKindOfClass:[NSDictionary class]] ) {
        NSDictionary*dict=parameters;
        NSArray*keyArr=dict.allKeys;
        for (NSString *key in keyArr) {
//            if ([URLString isEqual:Post_Ask_Add_PS]&&[key isEqual:@"img_data"]) {
//                NSString *values=dict[key];
//                par[key]=values;
//            }else{
//                NSString *values=dict[key];
//                NSString *enCodeValues=[self encodeString:values];
//                par[key]=enCodeValues;
//            }
        }
    }
 
    
    NSMutableDictionary *parms = [NSMutableDictionary dictionaryWithDictionary:par];
    NSString *urlEpt=[NSString stringWithFormat:@"%@%@",API_URL,URLString];
    NSString *url = [urlEpt stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
//    NSString *ras=HTTPKEY_RAS_RELEES;
//    parms[@"akeys"]=[PSBase64 encodeBase64:[RSA encryptString:HTTP_KEY publicKey:ras]];
    
//    if ([PSAccountTool account]) {
//        parms[@"token"]=[PSAccountTool account].token;
//    }
   //NSString*josn=[parms toJSONString];
    // 发送请求
    
    NSLog(@"url===%@\n parms==%@",url,parms);
//    [self debugLogWith:parms withPostUrl:url];
    return  [manager POST:url parameters:parms headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"url===%@\nPost_responseObject=%@",url,responseObject);
//        if(!IsEmpty(responseObject)){
////            if ([responseObject isKindOfClass:[NSDictionary class]]) {
//////                if ([responseObject[@"code"] intValue]==2003&& [responseObject[@"msg"] isEqual:@"Token Non-existent"]) {
//////                    [PSAccountTool logOut];
//////                }
////            }
//            if (responseObject) {
//                success(responseObject);
//            }
//        }

       
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

//+(NSString*)encodeString:(NSString*)string{
//
////    NSString * cryptedText=[NSString encryptAESWithPlainText:string];
////    return  [PSBase64 encodeBase64:cryptedText];
//}

//- (NSString *)dicToJsonStr:(NSArray *)dic
//{
//    NSError *parseError = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
//    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//}

//+(void)debugLogWith:(NSDictionary*)dict withPostUrl:(NSString*)url{
//    if (!IsEmpty(dict)) {
//        NSArray *keys = [dict allKeys];
//        NSArray *sortKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
//        NSMutableString *paramsString=[[NSMutableString alloc]init];
//        for (NSString *key in sortKeys) {
//            NSString *value = [dict objectForKey:key];
//            [paramsString appendFormat: @"%@=%@&",key,value];
//        }
//        NSString *str3 = [paramsString substringToIndex:paramsString.length-1];
//        NSString * logUrlParams=[NSString stringWithFormat:@"curl --data  \"%@\"      \"\%@\"",str3,url];
//        /*
//         带时间
//        NSString *rigtTime=[NSString stringWithFormat:@"curl  --verbose --write-out %@ ",@"\"连接时间==%{time_connect}||总耗时==%{time_total}\""];
//        NSString * logUrlParam=[NSString stringWithFormat:@"--data \"%@\"      \"\%@\"",str3,url];
//        NSString *logUrl=[NSString stringWithFormat:@"%@%@",rigtTime,logUrlParam];
//         */
//        //VCLog(@"rigtTime==%@",logUrl)
//       // --verbose --write-out "%{time_connect}::%{time_total}\n"
//        //    NSString * curlString=[NSString stringWithFormat:@" curl --verbose --write-out %@   %@",timeString,logUrlParams];json.dumps-s | python -m json.tool
//        //    NSLog(@"%@",curlString);
//        NSLog(@"curl命令==%@ -s | python -m json.tool",logUrlParams);
//        //NSLog(@"请求路径==%@",url);
//        //NSLog(@"请求参数===%@",dict);
//    }
//
//}



@end
