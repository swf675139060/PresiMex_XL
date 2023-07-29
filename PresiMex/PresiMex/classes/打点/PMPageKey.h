//
//  PMPageKey.h
//  PresiMex
//
//  Created by shenwenfeng on 2023/7/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PMPageKey : NSObject
//登陆界面
extern NSString *const acq01_app_start;//
extern NSString *const acq01_login;//
extern NSString *const acq02_login_reg_phone;//
extern NSString *const acq02_login_otp_code;//
extern NSString *const acq03_login_login;//

//资料认证
extern NSString *const acq01_login_succ;//登录成功首页
extern NSString *const acq01_info_auth;//信息认证主页
extern NSString *const acq01_survey;//问卷调查页
extern NSString *const acq02_survey_half_year_overdue;//半年内逾期输入
extern NSString *const acq02_survey_max_overdue_day;//最长逾期天数输入
extern NSString *const acq02_survey_loan_amount;//借款总额输入
extern NSString *const acq02_survey_loan_times;//借款几次输入
extern NSString *const acq02_survey_now_loan_counts;//在贷借款笔数输入
//身份信息认证页
extern NSString *const acq01_identity_auth;//身份信息认证页
extern NSString *const acq02_identity_auth_name;//姓名输入
extern NSString *const acq02_identity_auth_id_number;//证件号输入
extern NSString *const acq03_identity_auth_front_card_photo;//证件正面拍照点击
extern NSString *const acq03_identity_auth_back_card_photo;//证件反面面拍照点击
extern NSString *const acq03_identity_auth_living;//活体认证点击

//基本信息认证页
extern NSString *const acq01_base_auth;//基本信息认证页
extern NSString *const acq02_base_auth_gender;//性别输入
extern NSString *const acq02_base_auth_curp;//curp输入
extern NSString *const acq02_base_auth_email;//email输入
extern NSString *const acq02_base_auth_marry_state;//婚姻状态输入
extern NSString *const acq02_base_auth_children_num;//孩子数输入
extern NSString *const acq02_base_auth_education;//教育背景输入
extern NSString *const acq02_base_auth_birth;//
extern NSString *const acq02_base_auth_job_state;//
extern NSString *const acq02_base_auth_industry;//行业输入
extern NSString *const acq02_base_auth_month_income;//月收入输入
extern NSString *const acq02_base_auth_salary_type;//工资类型输入
extern NSString *const acq02_base_auth_salary_day1;//发薪日1输入
extern NSString *const acq02_base_auth_salary_day2;//发薪日2输入
extern NSString *const acq02_base_auth_company_name;//公司名称输入
extern NSString *const acq02_base_auth_company_number;//公司号码输入
extern NSString *const acq02_base_auth_work_city;//工作地点所在城市输入
extern NSString *const acq02_base_auth_work_district;//工作地点所在区输入
extern NSString *const acq02_base_auth_work_detail_address;;//工作地点详细地址输入

extern NSString *const acq01_emer_contract;//紧急联系人认证页
extern NSString *const acq02_emer_contract_relation1;//联系人1关系输入
extern NSString *const acq02_emer_contract_number1;//联系人1号码输入
extern NSString *const acq02_emer_contract_relation2;//联系人2关系输入
extern NSString *const acq02_emer_contract_number2;//联系人2号码输入
//收款账号页
extern NSString *const acq01_bank;//收款账号页
extern NSString *const acq02_bank_bank_name;//银行选择输入
extern NSString *const acq02_bank_account;//银行账号输入
extern NSString *const acq03_bank_bank_account;//收款方式银行账号点击
extern NSString *const acq03_bank_clabe;//收款方式clabe点击
//授信等待页
extern NSString *const acq01_auth_wait;//授信等待页
extern NSString *const acq01_exit_retention;//用户半路退出挽留页
//授信通过展示
extern NSString *const acq01_auth_pass;//授信通过展示


//我的界面;
extern NSString *const acq01_mine_no_login;//我的未登录 页面
extern NSString *const acq01_mine_login_no_auth;//我的登录未验证完成 页面
extern NSString *const acq01_mine_credit_succ;//我的授信成功 页面
extern NSString *const acq03_mine_wait_to_login;//待登录按钮点击
extern NSString *const acq03_mine_wait_to_auth;//待认证按钮点击
//
extern NSString *const acq01_coupon;//优惠券页面
extern NSString *const acq03_coupon_coupon_use;//优惠券使用按钮点击
//
extern NSString *const acq01_feedback;//反馈页面
extern NSString *const acq01_assistance;//客服主页
extern NSString *const acq01_about_us;//关于我们页
extern NSString *const acq01_setting;//设置页

//产品页面
extern NSString *const acq01_product;//产品首页
extern NSString *const acq02_product_amount_slide;//首页额度滑动条
extern NSString *const acq03_product_detail;//产品详情点击
extern NSString *const acq03_product_apply_submit;//产品借款申请提交
//extern NSString *const;//
extern NSString *const acq01_loan_detail;//借款详情页
extern NSString *const acq03_loan_detail_change_bank_account;//更换提款账户点击
extern NSString *const acq03_loan_detail_product_detail;//借款详情页产品详情点击
extern NSString *const acq03_loan_detail_confirm;//借款确认
//extern NSString *const;//
extern NSString *const acq01_pay_type;//收款方式及借款协议
extern NSString *const acq03_pay_type_confirm;//确认按钮
//extern NSString *const;//
extern NSString *const acq01_account_confirm;//账号确认页
extern NSString *const acq03_account_confirm_confirm;//确认按钮
extern NSString *const acq03_account_confirm_modify;//修改按钮
//extern NSString *const;//
//extern NSString *const;//
extern NSString *const acq01_loan_processing;//借款处理中页面
extern NSString *const acq03_loan_processing_to_score_5star;//前往评论点击(5星转gp评价)
extern NSString *const acq03_loan_processing_to_score_no5star;//前往评论点击(非5星转内部页面)

//账单页面
extern NSString *const acq01_bill;//账单页面
extern NSString *const acq03_bill_no_repay_order;//未完成订单点击
extern NSString *const acq03_bill_repay_order;//完成订单点击
extern NSString *const acq03_bill_to_repay;//去还款点击
extern NSString *const acq03_bill_draw_money_again;//重新提款点击
//extern NSString *const;//
extern NSString *const acq01_account_info;//账号信息弹窗
extern NSString *const acq03_account_info_confirm;//确认无误点击
extern NSString *const acq03_account_info_modify;//修改点击
//extern NSString *const;//
extern NSString *const acq01_repayment_detail_normal_all_pay;//正常订单全额还款还款详情页
extern NSString *const acq01_repayment_detail_overdue_all_pay;//逾期订单全额还款详情页
extern NSString *const acq01_repayment_detail_normal_ext_pay;//正常订单展期还款详情页
extern NSString *const acq01_repayment_detail_overdue_ext_pay;//逾期订单展期还款详情页
//extern NSString *const;//
extern NSString *const acq01_all_repay_succ;//全还成功弹窗
extern NSString *const acq01_extension_repay_succ;//展期成功弹窗


@end

NS_ASSUME_NONNULL_END
