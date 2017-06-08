
//  LimiBuyerUrl.h
//  LimiBuyer
//
//  Created by steven on 16/1/28.
//  Copyright © 2016年 limi360. All rights reserved.
//  买家版请求接口配置档

#import <Foundation/Foundation.h>

#pragma mark - 服务器域名

//  本机tomcat安装war包

//  测试环境

//#define YKServer  @"http://10.0.0.16:8080"//陈功强
#define YKServer  @"http://10.0.0.36:8080"//彭立文
//#define YKServer  @"http://10.0.0.9:8998"//服务器


#define KiPAddress @"192.168.3.133"

#define kPlatform @"IOS"

#define kTimeStamp [NSString stringWithFormat:@"%lld",(long long)[[NSDate date] timeIntervalSince1970]]

#define kAppVersion @"1.0.0"

/*  Demo账号密码
 **********  测试环境 **********
18019961713 psw: 123456
 **********  生产环境 **********
 
*/

//  银联支付
#define kVCTitle          @"商户测试"
#define kBtnFirstTitle    @"获取订单，开始测试"
#define kWaiting          @"正在获取TN,请稍后..."
#define kNote             @"提示"
#define kConfirm          @"确定"
#define kErrorNet         @"网络错误"
#define kResult           @"支付结果：%@"
#define kMode             @"00"         //00线上 01测试
//#define kURL_TN_Normal                @"http://101.231.204.84:8091/sim/getacptn"
//#define kURL_TN_Configure             @"http://101.231.204.84:8091/sim/app.jsp?user=123456789"


@interface YKUrl : NSObject

#pragma mark 

//洗车通用接口//根据不同参数判断不同请求
+ (NSString *)commonUrl;

+ (NSString *)getArea;

//login
+ (NSString *)login;

//register
+ (NSString *)regist;

//发送验证码接口
+ (NSString *)sendVerificationCode;

//校验验证码接口
+ (NSString *)checkVerificationCode;

//重写密码接口
+ (NSString *)reSetPassword;

//获取banner接口
+ (NSString *)getBanners;

//首页数据总排名信息接口
+ (NSString *)getAllPoints;
//系统设置查询接口
+ (NSString *)getSystemSetting;

//时间设置查询接口

+ (NSString *)getTimeSetting;

//获得个人信息接口
+ (NSString *)getMemberInfo;

//编辑个人信息接口
+ (NSString *)setMemberInfo;

//获得文章接口
+ (NSString *)getArticles;

//获得版本接口
+ (NSString *)getVersion;


//获得反馈或留言列表接口
+ (NSString *)getFeedbackByType;

//编辑留言接口
+ (NSString *)setFeedback;

//获取题目信息接口
+ (NSString *)getQuestions;

//获取历次排名信息
+ (NSString *)pointsRank;

//获取消息接口
+ (NSString *)getPushLog;

//用户读取消息或删除消息接口
+ (NSString *)readLog;

//每月明细接口
+ (NSString *)monthPoint;

//获取历史签到积分接口
+ (NSString *)historySignPoint;

//保存答题详情信息接口
+ (NSString *)AddAnswerDetail;

//图片上传接口
+ (NSString *)avatar;

//静态界面接入接口
+ (NSString *)systeSetting;

//获取奖品信息
+ (NSString *)getAward;

//中奖列表信息接口
+ (NSString *)getPrizerecord;

//前台积分接口
+ (NSString *)jifen;

//获取历次排名月份接口
+ (NSString *)pointsRankMonth;

//获取中奖人员信息接口
+ (NSString *)getPrizeMember;

//获取广告接口
+ (NSString *)getAdvertise;

//绑定第三方接口
+ (NSString *)addSysTerracelogin;

//第三方登录接口
+ (NSString *)getSysTerracelogin;

//分享接口
+ (NSString *)getPoints;

//邀请朋友接口
+ (NSString *)invitationMember;

//获取历史题目信息接口
+ (NSString *)getQuestionHistory;

//获取当前系统时间接口
+ (NSString *)getSysTime;

//查看当天答题详情接口
+ (NSString *)getQuestionsDetail;
@end
