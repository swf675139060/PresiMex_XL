//
//  PMAccountTool.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/29.
//

#import "PMAccountTool.h"


#define PMAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"account.data"]

@implementation PMAccountTool


+ (void)saveAccount:(PMUser *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:PMAccountFile];
}

+ (PMUser *)account
{
    PMUser *user = [NSKeyedUnarchiver unarchiveObjectWithFile:PMAccountFile];
    if (user.token.length==0) {
        
        return nil;
    }
    // 判断是否过期，过期就返回nil

    return user;
}

+(BOOL)isLogin{
    if ([self account].token.length!=0) {
        return YES;
    }
    return NO;
}
+(void)logOut{
    PMUser *user=[[PMUser alloc]init];
    user.token=@"";
    user.tel=@"";
    user.customer_user_id=@"";
    user.isForceData=@"";
    user.isVer=@"";
    [PMAccountTool saveAccount:user];
   // [PMAccountTool cleanCacheData];
   
    
}
//+(void)cleanCacheData{
//
//    VCDataCache*cacheManager=[VCDataCache defaultCache];
//    [cacheManager clearImageCache];
//    [PSAccountTool cleanUserDefaultWithKey:PS_PURPOS];
//    [PSAccountTool cleanUserDefaultWithKey:PS_EMAIL];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Facebook];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Messenger];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Phone];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Marital];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Child];
//    [PSAccountTool cleanUserDefaultWithKey:PS_EDU];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Basic_Address];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Emergency_contact];
//    [PSAccountTool cleanUserDefaultWithKey:PS_JOB_Infomation];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Industry_Category];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Company_Name];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Employment_date];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Working_Experience];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Occupation];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Income_Mon];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Company_Address];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Detailed_Company_Address];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Pay_day1];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Pay_day2];
//    [PSAccountTool cleanUserDefaultWithKey:PS_LIVE_Province];
//    [PSAccountTool cleanUserDefaultWithKey:PS_LIVE_City];
//    [PSAccountTool cleanUserDefaultWithKey:PS_LIVE_Street];
//    [PSAccountTool cleanUserDefaultWithKey:PS_LIVE_Address];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Residential_Owenrship];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Residence];
//    ////审核认证相关(公司地址)
//    [PSAccountTool cleanUserDefaultWithKey:PS_COMPANY_Province];
//    [PSAccountTool cleanUserDefaultWithKey:PS_COMPANY_City];
//    [PSAccountTool cleanUserDefaultWithKey:PS_COMPANY_Street];
//    [PSAccountTool cleanUserDefaultWithKey:PS_COMPANY_Address];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Detailed_Company_Address];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Detailed_Company_Address_job];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Residential_Owenrship];
//    ////审核认证相关(紧急联系人)
//    [PSAccountTool cleanUserDefaultWithKey:PS_EmContact_Relation1];
//    [PSAccountTool cleanUserDefaultWithKey:PS_EmContact_Relation_Name1];
//    [PSAccountTool cleanUserDefaultWithKey:PS_EmContact_Relation_Number1];
//    [PSAccountTool cleanUserDefaultWithKey:PS_EmContact_Relation2];
//    [PSAccountTool cleanUserDefaultWithKey:PS_EmContact_Relation_Name2];
//    [PSAccountTool cleanUserDefaultWithKey:PS_EmContact_Relation_Number2];
//    [PSAccountTool cleanUserDefaultWithKey:PS_EmContact_Relation3];
//    [PSAccountTool cleanUserDefaultWithKey:PS_EmContact_Relation_Name3];
//    [PSAccountTool cleanUserDefaultWithKey:PS_EmContact_Relation_Number3];
//    [PSAccountTool cleanUserDefaultWithKey:PS_EmContact_Relation4];
//    [PSAccountTool cleanUserDefaultWithKey:PS_EmContact_Relation_Name4];
//    [PSAccountTool cleanUserDefaultWithKey:PS_EmContact_Relation_Number4];
//    [PSAccountTool cleanUserDefaultWithKey:PS_EmContact_Relation5];
//    [PSAccountTool cleanUserDefaultWithKey:PS_EmContact_Relation_Name5];
//    [PSAccountTool cleanUserDefaultWithKey:PS_EmContact_Relation_Number5];
//    ////审核认证相关(人脸和证件页面)
//    [PSAccountTool cleanUserDefaultWithKey:PS_ID_Card_Type];
//    [PSAccountTool cleanUserDefaultWithKey:PS_ID_Card_Type_ID];
//    [PSAccountTool cleanUserDefaultWithKey:PS_ID_Card_Number];
//    [PSAccountTool cleanUserDefaultWithKey:PS_ID_Card_First_Name];
//    [PSAccountTool cleanUserDefaultWithKey:PS_ID_Card_Middle_Name];
//    [PSAccountTool cleanUserDefaultWithKey:PS_ID_Card_Last_Name];
//    [PSAccountTool cleanUserDefaultWithKey:PS_ID_Card_Sex];
//    [PSAccountTool cleanUserDefaultWithKey:PS_ID_Card_Birthday];
//
//    [PSAccountTool cleanUserDefaultWithKey:PS_Industry_Type];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Industry];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Religion];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Latitude];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Longitude];
//
//    ///添加银行卡相关
//    [PSAccountTool cleanUserDefaultWithKey:PS_Bank_Card_FullName];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Bank_Card_Name];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Bank_Card_Account];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Bank_Card_Account1];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Bank_Card_Phone];
//    [PSAccountTool cleanUserDefaultWithKey:PS_Bank_Card_ID];
//    //缓存账号
//    [PSAccountTool cleanUserDefaultWithKey:@"LoginPhone"];
//    //清除图片url地址
//    [PSAccountTool cleanUserDefaultWithKey:PS_ID_CER_RE_FACE_IMAG_URL];
//    [PSAccountTool cleanUserDefaultWithKey:PS_ID_CER_RE_IMAG_URL];
//    [PSAccountTool cleanUserDefaultWithKey:PS_ID_CER_FACE_IMAG_URL];
//    [PSAccountTool cleanUserDefaultWithKey:PS_ID_CER_IMAG_URL];
//
//    [PSAccountTool cleanUserDefaultWithKey:PS_EM_CONTACR];
//    [PSAccountTool cleanUserDefaultWithKey:PS_JOB_CONTACR];
//    [PSAccountTool cleanUserDefaultWithKey:PS_ADDRESS_CONTACR];
//
//}
+(void)cleanUserDefaultWithKey:(NSString*)key{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}



@end
