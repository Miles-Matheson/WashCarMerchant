//
//  LimiBuyerUrl.m
//  LimiBuyer
//
//  Created by steven on 16/1/28.
//  Copyright © 2016年 limi360. All rights reserved.
//

#import "YKUrl.h"

@implementation YKUrl

#pragma mark - 请求路径

+ (NSString *)apipublic{
    NSString *context = @"";
    context = [NSString stringWithFormat:@"/ykds-admin/api/washcar/api"];
    return context;
}

#pragma mark - 公共接口


//洗车通用接口//根据不同参数判断不同请求
+ (NSString *)commonUrl{
    return [NSString stringWithFormat:@"%@",[self apipublic]];
}


//注册-区域选择 #url= /getArea
+ (NSString *)getArea{
    return [NSString stringWithFormat:@"%@",[self apipublic]];
}
//login
+ (NSString *)login{
    return [NSString stringWithFormat:@"%@/api/dt/whDtMember/login",[self apipublic]];
}

//register
+ (NSString *)regist{
    return [NSString stringWithFormat:@"%@/api/dt/whDtMember/register",[self apipublic]];
}
//发送验证码接口
+ (NSString *)sendVerificationCode{
    return [NSString stringWithFormat:@"%@/api/dt/WhDtSms/sendVerificationCode",[self apipublic]];
}
//校验验证码接口
+ (NSString *)checkVerificationCode{
    return [NSString stringWithFormat:@"%@/api/dt/WhDtSms/checkVerificationCode",[self apipublic]];
}

//重写密码接口
+ (NSString *)reSetPassword{
    return [NSString stringWithFormat:@"%@/api/dt/whDtMember/reSetPassword",[self apipublic]];
}
//获取广告接口
+ (NSString *)getAdvertise{
    return [NSString stringWithFormat:@"%@/api/dt/whDtAdvertise/getAdvertise",[self apipublic]];

}
//获取banner接口
+ (NSString *)getBanners{
    return [NSString stringWithFormat:@"%@/api/dt/whDtBanners/getBanners",[self apipublic]];
}
//系统设置查询接口
+ (NSString *)getSystemSetting{
    return [NSString stringWithFormat:@"%@/api/dt/whDtSystemSetting/getSystemSetting",[self apipublic]];
}//时间设置查询接口

+ (NSString *)getTimeSetting{
    return [NSString stringWithFormat:@"%@/api/dt/whDtTimeSetting/getTimeSetting",[self apipublic]];
}//获得个人信息接口
+ (NSString *)getMemberInfo{
    return [NSString stringWithFormat:@"%@/api/dt/whDtMember/getMemberInfo",[self apipublic]];
}//编辑个人信息接口
+ (NSString *)setMemberInfo{
    return [NSString stringWithFormat:@"%@/api/dt/whDtMember/setMemberInfo",[self apipublic]];
}
//获得版本接口
+ (NSString *)getVersion{
    return [NSString stringWithFormat:@"%@/api/dt/whDtVersion/getVersion",[self apipublic]];
}
//获得反馈或留言列表接口
+ (NSString *)getFeedbackByType{
    return [NSString stringWithFormat:@"%@/api/dt/whDtFeedback/getFeedbackByType",[self apipublic]];
}
//编辑留言接口
+ (NSString *)setFeedback{
    return [NSString stringWithFormat:@"%@/api/dt/whDtFeedback/setFeedback",[self apipublic]];
}

//首页数据总排名信息接口
+ (NSString *)getAllPoints{
    return [NSString stringWithFormat:@"%@/api/dt/whDtMember/getAllPoints",[self apipublic]];
}

//获取题目信息接口
+ (NSString *)getQuestions{
    return [NSString stringWithFormat:@"%@/api/dt/whDtQuestion/getQuestions",[self apipublic]];
}


//获取历次排名信息
+ (NSString *)pointsRank{
    return [NSString stringWithFormat:@"%@/api/dt/whDtPoints/pointsRank",[self apipublic]];
}

//前台积分接口
+ (NSString *)jifen{
    return [NSString stringWithFormat:@"%@/api/dt/whDtMemberPoint/pointsRank",[self apipublic]];
}

//获取历史签到积分接口
+ (NSString *)historySignPoint{
    return [NSString stringWithFormat:@"%@/api/dt/whDtPoints/historySignPoint",[self apipublic]];
}

//获取消息接口
+ (NSString *)getPushLog{
    return [NSString stringWithFormat:@"%@/api/dt/whDtPushLog/getPushLog",[self apipublic]];
}

//用户读取消息或删除消息接口
+ (NSString *)readLog{
    return [NSString stringWithFormat:@"%@/api/dt/whDtPushLog/readLog",[self apipublic]];
}

//每月明细接口
+ (NSString *)monthPoint{
    return [NSString stringWithFormat:@"%@/api/dt/whDtMonthPoints/monthPoint",[self apipublic]];
}

//保存答题详情信息接口
+ (NSString *)AddAnswerDetail{
    return [NSString stringWithFormat:@"%@/api/dt/whDtAnswerDetail/AddAnswerDetail",[self apipublic]];
}

//图片上传接口
+ (NSString *)avatar{
    return [NSString stringWithFormat:@"%@/app/dt/addDtImageUp/addImsge/avatar",[self apipublic]];
}

//静态界面接入接口
+ (NSString *)systeSetting{
    return [NSString stringWithFormat:@"%@/app/dt/whDtMember//systeSetting/",[self apipublic]];
}
//获取奖品信息
+ (NSString *)getAward{
    return [NSString stringWithFormat:@"%@/api/dt/whDtAward/getAward",[self apipublic]];
}

//中奖列表信息接口
+ (NSString *)getPrizerecord{
    return [NSString stringWithFormat:@"%@/api/dt/whDtPrizerecord/getPrizerecord",[self apipublic]];
}
//获取历次排名月份接口
+ (NSString *)pointsRankMonth{
    return [NSString stringWithFormat:@"%@/api/dt/whDtPoints/pointsRankMonth",[self apipublic]];
}
//获取中奖人员信息接口
+ (NSString *)getPrizeMember{
    return [NSString stringWithFormat:@"%@/api/dt/whDtPrizerecord/getPrizeMember",[self apipublic]];
}

//绑定第三方接口
+ (NSString *)addSysTerracelogin{
    return [NSString stringWithFormat:@"%@/api/dt/whSysTerracelogin/addSysTerracelogin",[self apipublic]];
}

//第三方登录接口
+ (NSString *)getSysTerracelogin{
    return [NSString stringWithFormat:@"%@/api/dt/whSysTerracelogin/getSysTerracelogin",[self apipublic]];
}

//分享接口
+ (NSString *)getPoints{
    return [NSString stringWithFormat:@"%@/api/dt/whDtPoints/getPoints",[self apipublic]];
}

//邀请朋友接口
+ (NSString *)invitationMember{
    return [NSString stringWithFormat:@"%@/api/dt/whDtInvitation/invitationMember",[self apipublic]];
}

//获得文章接口
+ (NSString *)getArticles{
    return [NSString stringWithFormat:@"%@/api/dt/whDtArticle/getArticles",[self apipublic]];
}

//获取历史题目信息接口
+ (NSString *)getQuestionHistory{
    return [NSString stringWithFormat:@"%@/api/dt/whDtQuestionHistory/getQuestionHistory",[self apipublic]];
}
//获取当前系统时间接口
+ (NSString *)getSysTime{
    return [NSString stringWithFormat:@"%@/api/dt/GetSystemTime/getSysTime",[self apipublic]];
}

//查看当天答题详情接口
+ (NSString *)getQuestionsDetail{
    return [NSString stringWithFormat:@"%@/api/dt/whDtQuestion/getQuestionsDetail",[self apipublic]];
}

@end
