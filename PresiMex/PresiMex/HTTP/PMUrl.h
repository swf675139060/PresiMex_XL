//
//  PMUrl.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/27.
//

#ifndef PMUrl_h
#define PMUrl_h


#define API_URL  @"https://test-api.presimex.mx"




/*
 用户信息
 */

//AF信息上传
#define  Post_AF_Info @"/api/user/mount/licence"

//获取用户当前状态
#define  Get_User_Status  @"/api/user/mount/observer"

//设备信息汇报
#define  Post_Device_Info @"/api/user/mount/random"


/*
 用户登录注册
 */

//用户退出
#define  Get_User_LogOut  @"/api/user/repeated/cultures"//w

//登录注册短信(发送)
#define  Post_Sms_Code @"/api/user/repeated/malaysia" //w

//登录注册短信(验证)
#define  Post_Sms_Code_Ver  @"/api/user/repeated/fears" //w


/*
账单主订单
 */

//失败订单处理为待重新放款
#define  Post_Oder_Fail_Reset  @"/api/user/fp/football"

//用户当前订单概况
#define  Get_User_Oder_Status  @"/api/user/fp/lexus"

//获取该批次订单
#define  Get_User_Oder  @"/api/user/fp/coordinates"




/*
 公开的接口(回调)
 */

//APP配置选择
#define  GET_APP_Cofig @"/api/user/actor/breach"

//获取APP开屏图片
#define GET_APP_Lauch_Image @"/api/user/actor/nn"
//轮播信息
#define  GET_App_Banner  @"/api/user/actor/trackback"

//配置信息合并(获取人工客服信息)
#define  GET_CS_Info  @" /api/user/actor/pain"



/*
 用户-OCR
 */


//Ocr回显接口(类型合并+活体照+字段)
#define  GET_OCR_USER_INFO  @"/api/user/often/controlling"


//开始进行活体(调用生成记录即可不需要参数)
#define  POST_ORC_AUTH  @"/api/user/often/hammer"

//活体照上传,提交KYC
#define  POST_Ocr_KYC  @"/api/user/often/slot"

//活体结果查询
#define   POST_LIFE_Query  @"/api/user/often/different"

//证件照调用ocr
#define  POST_Orc_Image_File  @"/api/user/often/aggressive/britannica"



/*
 版本更新
 */


//版本升级检查
#define  GET_APP_Version_Update  @"/api/user/activation"



/*
 用户-反馈
 */

//反馈信息提交
#define  POST_Feedback_Info  @"/api/user/won/robots"

//获取所有反馈类型
#define  GET_Feedback_Type @"/api/user/won/emacs"


/*
 系统配置
 */

//基本信息getByCode
#define  GET_Sys_Cofig  @"/api/user/petite/psychological"


/*
 账单-账单页信息
 */

//获取用户订单接口
#define  GET_User_Oder @"/api/user/fp/cuisine"


/*
 文件上传
 */

//图片上传
#define  POST_Image_File @"/api/user/counsel/attendance"


/*
 用户-优惠券相关接口
 */

//用户获取优惠券
#define  GET_Coupon_Url  @"/api/user/incidents/ieee"

//用户认证完成领取优惠券
#define   POST_Coupon_Get_Url @"/api/user/incidents/introduced/laundry/describing"



/*
 用户-授信额度接口
 */

//获取用户授信信息
#define  GET_User_Auth_Info  @"/api/user/hampton/hanging" //W

//重新发送授信队列
#define  POST_AUTH_RESEND  @"/api/user/hampton/brisbane"


/*
 用户-调查问卷
 */

//调查问卷提交
#define  POST_Ask_Info  @"/api/user/fighter"
//调查问卷查询
#define   GET_Ask_Query  @"/api/user/fighter"


/*
 账单-还款/展期/拉起支付
 */

//查询还款/展期结果
#define  GET_Repay_Bill  @"/api/user/defines/velocity/%@"

//获取借款详情
#define  GET_Loan_Detail  @"/api/user/defines/labor/grenada/"

//获取商户对应支持通道
#define  GET_Merchant_Pass  @"/api/user/defines/subcommittee"

//获取展期详情
#define  GET_Repay_Bill_Detail @"/api/user/defines/package/grenada/%@"

//获取还款页面信息
#define  GET_Repay_Vc_Info  @"/api/user/defines/lecture/%@/%@"


/*
 产品-列表/申请
 */

//产品列表
#define  GET_Product_List  @"/api/user/earl/suggesting/%ld"

//借款申请
#define  POST_Loan_Apply @"/api/user/earl/tions"


/*
 用户-账户管理
 */

//获取支持银行列表
#define   GET_Bank_List  @"/api/user/comp/insects"

//获取用户当前绑定账户信息
#define  GET_Bind_User_Account  @"/api/user/comp/actively"

//银行卡修改(文档是put)
#define  POST_Reset_Bank_Info @"/api/user/comp/protect"


//银行卡修改短信发送
#define  POST_Bank_Reset_Code  @"/api/user/comp/malaysia"

//银行或者clabe信息提交
#define  POST_Bank_Info_Submmit @"/api/user/comp/dg"



/*
 用户-基本信息
 */

//保存用户基本信息
#define   POST_User_Base_Means @"/api/user/wealth/beyond"
//用户基本信息回显
#define  GET_User_Means  @"/api/user/wealth/had"


/*
 用户联系人上传 
 */

//用户联系人上传
#define  POST_Contacts_Info  @"/api/user/coverage/prisoners"

//用户联系人回显
#define  GET_Contacts_Info   @"/api/user/coverage"



/*
 调查问卷提交
 */

//调查问卷提交
#define  POST_Investigate_Info   @"/api/user/fighter"


//调查问卷提交
#define  GET_Investigate_Info   @"/api/user/fighter"




#endif /* PMUrl_h */
