//
//  LimiTime.h
//  LimiBuyer
//
//  Created by steven on 16/2/2.
//  Copyright © 2016年 limi360. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKManager : NSObject

//  APP全局变量单例，常驻内存
+ (YKManager *)sharedManager;

//  获取当前时间
+ (NSString *)getTime;

//  是否登录
@property (nonatomic, assign) BOOL didLogin;
//  请求头

@property (nonatomic, strong) NSMutableDictionary *requestHeaderDic;
@property (nonatomic, copy) NSString * time;//请求时间,若发送token则必填
@property (nonatomic, copy) NSString * originToken;//token校验码,不填默认未登录，此处是token原文
@property (nonatomic, copy) NSString * api;//请求方法
@property (nonatomic, copy) NSString * uid;
@property (nonatomic, copy) NSString * mobile;
@property (nonatomic, copy) NSString * sex;
@property (nonatomic, copy) NSString * userId;

@property (nonatomic, strong) NSMutableDictionary *loginParam;

@end
