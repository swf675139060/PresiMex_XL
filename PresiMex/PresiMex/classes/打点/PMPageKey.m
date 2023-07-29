//
//  PMPageKey.m
//  PresiMex
//
//  Created by shenwenfeng on 2023/7/23.
//

#import "PMPageKey.h"

@implementation PMPageKey
//登陆界面
NSString *const acq01_app_start = @"acq01_app_start";//
NSString *const acq01_login = @"acq01_login";//
NSString *const acq02_login_reg_phone = @"acq02_login_reg_phone";//
NSString *const acq02_login_otp_code = @"acq02_login_otp_code";//
NSString *const acq03_login_login = @"acq03_login_login";//



//资料认证
NSString *const acq01_login_succ = @"acq01_login_succ";//
//NSString *const = @"";//
NSString *const acq01_info_auth = @"acq01_info_auth";//
//NSString *const = @"";//
//NSString *const = @"";//
NSString *const acq01_survey = @"acq01_survey";//
NSString *const acq02_survey_half_year_overdue = @"acq02_survey_half_year_overdue";//
NSString *const acq02_survey_max_overdue_day = @"acq02_survey_max_overdue_day";//
NSString *const acq02_survey_loan_amount = @"acq02_survey_loan_amount";//
NSString *const acq02_survey_loan_times = @"acq02_survey_loan_times";//
NSString *const acq02_survey_now_loan_counts = @"acq02_survey_now_loan_counts";//

//身份信息认证页
NSString *const acq01_identity_auth = @"acq01_identity_auth";//
NSString *const acq02_identity_auth_name = @"acq02_identity_auth_name";//
NSString *const acq02_identity_auth_id_number = @"acq02_identity_auth_id_number";//
NSString *const acq03_identity_auth_front_card_photo = @"acq03_identity_auth_front_card_photo";//
NSString *const acq03_identity_auth_back_card_photo = @"acq03_identity_auth_back_card_photo";//
NSString *const acq03_identity_auth_living = @"acq03_identity_auth_living";//

//基本信息认证页
NSString *const acq01_base_auth = @"acq01_base_auth";//
NSString *const acq02_base_auth_gender = @"acq02_base_auth_gender";//
NSString *const acq02_base_auth_curp = @"acq02_base_auth_curp";//
NSString *const acq02_base_auth_email = @"acq02_base_auth_email";//
NSString *const acq02_base_auth_marry_state = @"acq02_base_auth_marry_state";//
NSString *const acq02_base_auth_children_num = @"acq02_base_auth_children_num";//
NSString *const acq02_base_auth_education = @"acq02_base_auth_education";//
NSString *const acq02_base_auth_birth = @"acq02_base_auth_birth";//
NSString *const acq02_base_auth_job_state = @"acq02_base_auth_job_state";//
NSString *const acq02_base_auth_industry = @"acq02_base_auth_industry";//
NSString *const acq02_base_auth_month_income = @"acq02_base_auth_month_income";//
NSString *const acq02_base_auth_salary_type = @"acq02_base_auth_salary_type";//
NSString *const acq02_base_auth_salary_day1 = @"acq02_base_auth_salary_day1";//
NSString *const acq02_base_auth_salary_day2 = @"acq02_base_auth_salary_day2";//
NSString *const acq02_base_auth_company_name = @"acq02_base_auth_company_name";//
NSString *const acq02_base_auth_company_number = @"acq02_base_auth_company_number";//
NSString *const acq02_base_auth_work_city = @"acq02_base_auth_work_city";//
NSString *const acq02_base_auth_work_district = @"acq02_base_auth_work_district";//
NSString *const acq02_base_auth_work_detail_address = @"acq02_base_auth_work_detail_address";//


//紧急联系人认证页
NSString *const acq01_emer_contract = @"acq01_emer_contract";//
NSString *const acq02_emer_contract_relation1 = @"acq02_emer_contract_relation1";//
NSString *const acq02_emer_contract_number1 = @"acq02_emer_contract_number1";//
NSString *const acq02_emer_contract_relation2 = @"acq02_emer_contract_relation2";//
NSString *const acq02_emer_contract_number2 = @"acq02_emer_contract_number2";//
//收款账号页
NSString *const acq01_bank = @"acq01_bank";//
NSString *const acq02_bank_bank_name = @"acq02_bank_bank_name";//
NSString *const acq02_bank_account = @"acq02_bank_account";//
NSString *const acq03_bank_bank_account = @"acq03_bank_bank_account";//
NSString *const acq03_bank_clabe = @"acq03_bank_clabe";//
//授信等待页
NSString *const acq01_auth_wait = @"acq01_auth_wait";//
NSString *const acq01_exit_retention = @"acq01_exit_retention";//
//授信通过展示
NSString *const acq01_auth_pass = @"acq01_auth_pass";//
//我的界面;
NSString *const acq01_mine_no_login = @"acq01_mine_no_login";//
NSString *const acq01_mine_login_no_auth = @"acq01_mine_login_no_auth";//
NSString *const acq01_mine_credit_succ = @"acq01_mine_credit_succ";//
NSString *const acq03_mine_wait_to_login = @"acq03_mine_wait_to_login";//
NSString *const acq03_mine_wait_to_auth = @"acq03_mine_wait_to_auth";//
//NSString *const = @"";//
NSString *const acq01_coupon = @"acq01_coupon";//
NSString *const acq03_coupon_coupon_use = @"acq03_coupon_coupon_use";//
//NSString *const = @"";//
NSString *const acq01_feedback = @"acq01_feedback";//
NSString *const acq01_assistance = @"acq01_assistance";//
NSString *const acq01_about_us = @"acq01_about_us";//
NSString *const acq01_setting = @"acq01_setting";//
//产品页面
NSString *const acq01_product = @"acq01_product";//
NSString *const acq02_product_amount_slide = @"acq02_product_amount_slide";//
NSString *const acq03_product_detail = @"acq03_product_detail";//
NSString *const acq03_product_apply_submit = @"acq03_product_apply_submit";//

NSString *const acq01_loan_detail = @"acq01_loan_detail";//
NSString *const acq03_loan_detail_change_bank_account = @"acq03_loan_detail_change_bank_account";//
NSString *const acq03_loan_detail_product_detail = @"acq03_loan_detail_product_detail";//
NSString *const acq03_loan_detail_confirm = @"acq03_loan_detail_confirm";//
//NSString *const = @"";//
NSString *const acq01_pay_type = @"acq01_pay_type";//
NSString *const acq03_pay_type_confirm = @"acq03_pay_type_confirm";//
//NSString *const = @"";//
NSString *const acq01_account_confirm = @"acq01_account_confirm";//
NSString *const acq03_account_confirm_confirm = @"acq03_account_confirm_confirm";//
NSString *const acq03_account_confirm_modify = @"acq03_account_confirm_modify";//
//NSString *const = @"";//
//NSString *const = @"";//
NSString *const acq01_loan_processing = @"acq01_loan_processing";//
NSString *const acq03_loan_processing_to_score_5star = @"acq03_loan_processing_to_score_5star";//
NSString *const acq03_loan_processing_to_score_no5star = @"acq03_loan_processing_to_score_no5star";//



//账单页面
NSString *const acq01_bill = @"acq01_bill";//
NSString *const acq03_bill_no_repay_order = @"acq03_bill_no_repay_order";//
NSString *const acq03_bill_repay_order = @"acq03_bill_repay_order";//
NSString *const acq03_bill_to_repay = @"acq03_bill_to_repay";//
NSString *const acq03_bill_draw_money_again = @"acq03_bill_draw_money_again";//
//NSString *const = @"";//
NSString *const acq01_account_info = @"acq01_account_info";//
NSString *const acq03_account_info_confirm = @"acq03_account_info_confirm";//
NSString *const acq03_account_info_modify = @"acq03_account_info_modify";//
//NSString *const = @"";//
NSString *const acq01_repayment_detail_normal_all_pay = @"acq01_repayment_detail_normal_all_pay";//
NSString *const acq01_repayment_detail_overdue_all_pay = @"acq01_repayment_detail_overdue_all_pay";//
NSString *const acq01_repayment_detail_normal_ext_pay = @"acq01_repayment_detail_normal_ext_pay";//
NSString *const acq01_repayment_detail_overdue_ext_pay = @"acq01_repayment_detail_overdue_ext_pay";//
//NSString *const = @"";//
NSString *const acq01_all_repay_succ = @"acq01_all_repay_succ";//
NSString *const acq01_extension_repay_succ = @"acq01_extension_repay_succ";//








@end
