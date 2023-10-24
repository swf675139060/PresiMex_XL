//
//  PMUrl.h
//  PresiMex
//
//  Created by 白翔龙 on 2023/5/27.
//

#ifndef PMUrl_h
#define PMUrl_h


//#define API_URL  @"https://test-api.presimex.mx"
//#define API_URL  @"https://test-api.cashimex.mx"
#define API_URL  @"https://test-gateway.presimex.mx"
//#define API_URL  @"https://gateway.presimex.mx"




/*
 用户信息
 */

//AF信息上传
#define  Post_AF_Info @"/gateway/biz/mount/licence"

//获取用户当前状态
#define  Get_User_Status  @"/gateway/biz/mount/observer"

//设备信息汇报
#define  Post_Device_Info @"/gateway/biz/mount/random"


/*
 用户登录注册
 */

//用户退出
#define  Get_User_LogOut  @"/gateway/biz/repeated/cultures"//w

//登录注册短信(发送)
#define  Post_Sms_Code @"/gateway/biz/repeated/malaysia" //w

//登录注册短信(验证)
#define  Post_Sms_Code_Ver  @"/gateway/biz/repeated/fears" //w


/*
账单主订单
 */

//失败订单处理为待重新放款
#define  Post_Oder_Fail_Reset  @"/gateway/biz/fp/football"

//用户当前订单概况
#define  Get_User_Oder_Status  @"/gateway/biz/fp/lexus"

//获取该批次订单
#define  Get_User_Oder  @"/gateway/biz/fp/coordinates"




/*
 公开的接口(回调)
 */

//APP配置选择
#define  GET_APP_Cofig @"/gateway/biz/actor/breach"

//获取APP开屏图片
#define GET_APP_Lauch_Image @"/gateway/biz/actor/nn"
//轮播信息
#define  GET_App_Banner  @"/gateway/biz/actor/trackback"

//配置信息合并(获取人工客服信息)
#define  GET_CS_Info  @"/gateway/biz/actor/pain"



/*
 用户-OCR
 */


//Ocr回显接口(类型合并+活体照+字段)
#define  GET_OCR_USER_INFO  @"/gateway/biz/often/controlling"


//开始进行活体(调用生成记录即可不需要参数)
#define  POST_ORC_AUTH  @"/gateway/biz/often/hammer"


//15006 - 活体配置选择
#define  GET_often_charged  @"/gateway/biz/often/charged"

//活体照上传,提交KYC
#define  POST_Ocr_KYC  @"/gateway/biz/often/slot"

//活体结果查询
#define   POST_LIFE_Query  @"/gateway/biz/often/different"

//证件照调用ocr
#define  POST_Orc_Image_File  @"/gateway/biz/often/aggressive/britannica"



/*
 版本更新
 */


//版本升级检查
#define  GET_APP_Version_Update  @"/gateway/biz/activation"



/*
 用户-反馈
 */

//反馈信息提交
#define  POST_Feedback_Info  @"/gateway/biz/won/robots"

//获取所有反馈类型
#define  GET_Feedback_Type @"/gateway/biz/won/emacs"


/*
 系统配置
 */

//基本信息getByCode
#define  GET_Sys_Cofig  @"/gateway/biz/petite/psychological"


/*
 账单-账单页信息
 */

//获取用户订单接口
#define  GET_User_Oder @"/gateway/biz/fp/cuisine"


/*
 文件上传
 */

//图片上传
#define  POST_Image_File @"/gateway/biz/counsel/attendance"


/*
 用户-优惠券相关接口
 */

//用户获取优惠券
#define  GET_Coupon_Url  @"/gateway/biz/incidents/ieee"

//用户认证完成领取优惠券
#define   POST_Coupon_Get_Url @"/gateway/biz/incidents/introduced/laundry/describing"



/*
 用户-授信额度接口
 */

//获取用户授信信息
#define  GET_User_Auth_Info  @"/gateway/biz/hampton/hanging" //W

//重新发送授信队列
#define  POST_AUTH_RESEND  @"/gateway/biz/hampton/brisbane"


/*
 用户-调查问卷
 */

//调查问卷提交
#define  POST_Ask_Info  @"/gateway/biz/fighter"
//调查问卷查询
#define   GET_Ask_Query  @"/gateway/biz/fighter"


/*
 账单-还款/展期/拉起支付
 */

//查询还款/展期结果
#define  GET_Repay_Bill  @"/gateway/biz/defines/velocity/%@"

//获取借款详情
#define  GET_Loan_Detail  @"/gateway/biz/defines/labor/grenada/"

//获取商户对应支持通道
#define  GET_Merchant_Pass  @"/gateway/biz/defines/subcommittee"

//获取展期详情
#define  GET_Repay_Bill_Detail @"/gateway/biz/defines/package/grenada/%@"

//获取还款页面信息
#define  GET_Repay_Vc_Info  @"/gateway/biz/defines/lecture/%@/%@"


/*
 产品-列表/申请
 */

//产品列表
#define  GET_Product_List  @"/gateway/biz/earl/suggesting/%ld"

//借款申请
#define  POST_Loan_Apply @"/gateway/biz/earl/tions"


/*
 用户-账户管理
 */

//获取支持银行列表
#define   GET_Bank_List  @"/gateway/biz/comp/insects"

//获取用户当前绑定账户信息
#define  GET_Bind_User_Account  @"/gateway/biz/comp/actively"

//银行卡修改(文档是put)
#define  POST_Reset_Bank_Info @"/gateway/biz/comp/protect"


//银行卡修改短信发送
#define  POST_Bank_Reset_Code  @"/gateway/biz/comp/malaysia"

//银行或者clabe信息提交
#define  POST_Bank_Info_Submmit @"/gateway/biz/comp/dg"



/*
 用户-基本信息
 */

//保存用户基本信息
#define   POST_User_Base_Means @"/gateway/biz/wealth/beyond"
//用户基本信息回显
#define  GET_User_Means  @"/gateway/biz/wealth/had"

/*
 用户联系人上传 
 */

//用户联系人上传
#define  POST_Contacts_Info  @"/gateway/biz/coverage/prisoners"

//用户联系人回显
#define  GET_Contacts_Info   @"/gateway/biz/coverage"



/*
 调查问卷提交
 */

//调查问卷提交
#define  POST_Investigate_Info   @"/gateway/biz/fighter" //w


//调查问卷提交
#define  GET_Investigate_Info   @"/gateway/biz/fighter" //w

/*
  打点
 */

//获取埋点配置
#define  GET_DOT_j1vka   @"/gateway/mt/ncj2njad/j1vka" //w

//埋点数据存库接口
#define  POST_DOT_nxjs3kl   @"/gateway/mt/j1vka/nxjs3kl" //w

//崩溃信息日志上报
#define  POST_bengKui   @"/gateway/mt/ad4nakdn/j1vka" //w

/*
 28001 - 借款协议
 */
#define  GET_User_LoanAgreement  @"/gateway/biz/h5/loanAgreement"


//测试环境域名: test-h5-ios.presimex.mx
//正式环境域名: h5-ios.presimex.mx


//#define  H5_weAre @"https://test-h5-ios.presimex.mx/"//关于我们
//#define  H5_permission @"https://test-h5-ios.presimex.mx/permission.html"//权限披露
//#define  H5_privacy @"https://test-h5-ios.presimex.mx/privacy.html"//隐私协议
//#define  H5_loan @"https://test-h5-ios.presimex.mx/loan.html"//借款协议
//#define  H5_help @"https://test-h5-ios.presimex.mx/help.html"//QA
//#define  H5_STP @"https://test-h5-ios.presimex.mx/STP.html"//VA还款引导
//#define  H5_store @"https://test-h5-ios.presimex.mx/store.html"//STORE还款引导
//#define  H5_OXXO @"https://test-h5-ios.presimex.mx/OXXO.html"//OXXO还款引导
//#define  H5_bank @"https://test-h5-ios.presimex.mx/bank.html"//BANK还款引导


#define  H5_weAre @"https://h5-ios.presimex.mx/"
#define  H5_permission @"https://h5-ios.presimex.mx/permission.html"
#define  H5_privacy @"https://h5-ios.presimex.mx/privacy.html"
#define  H5_loan @"https://h5-ios.presimex.mx/loan.html"
#define  H5_help @"https://h5-ios.presimex.mx/help.html"
#define  H5_STP @"https://h5-ios.presimex.mx/STP.html"
#define  H5_store @"https://h5-ios.presimex.mx/store.html"
#define  H5_OXXO @"https://h5-ios.presimex.mx/OXXO.html"
#define  H5_bank @"https://h5-ios.presimex.mx/bank.html"



#endif /* PMUrl_h */
