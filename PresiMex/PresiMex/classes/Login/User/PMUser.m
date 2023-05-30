//
//  PMUser.m
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/29.
//

#import "PMUser.h"

#define PMAccessTokenKey @"arrived"//token
#define PMUser_idKey @"gui" //用户ID
#define PMUser_status @"va"//前端用来判断用户是否存在, 区分登录还是注册, 1: 登录 2:注册
#define PMUser_Force_Data @"repeated"//是否强制获取数据
#define PMTelKey @"phone"

@implementation PMUser

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    PMUser *user = [[self alloc] init];
    user.token = dict[PMAccessTokenKey];
    user.customer_user_id = dict[PMUser_idKey];
    user.isForceData = dict[PMUser_Force_Data];
    user.isVer = dict[PMUser_status];
    user.tel = dict[PMTelKey];
    return user;
    
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_token forKey:PMAccessTokenKey];
    [aCoder encodeObject:_customer_user_id forKey:PMUser_idKey];
    [aCoder encodeObject:_isForceData forKey:PMUser_Force_Data];
    [aCoder encodeObject:_isVer forKey:PMUser_status];
    [aCoder encodeObject:_tel forKey:PMTelKey];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        _token = [aDecoder decodeObjectForKey:PMAccessTokenKey];
        _customer_user_id = [aDecoder decodeObjectForKey:PMUser_idKey];
        _isForceData = [aDecoder decodeObjectForKey:PMUser_Force_Data];
        _isVer = [aDecoder decodeObjectForKey:PMUser_status];
        _tel = [aDecoder decodeObjectForKey:PMTelKey];
    }
    
    return self;
}


@end
