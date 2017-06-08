//
//  LDValidateUtil.h
//  CheBaiTong
//
//  Created by limi360 on 15/7/6.
//  Copyright (c) 2015年 limi360. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDValidateUtil : NSObject
//邮箱
+ (BOOL) validateEmail:(NSString *)email;
//QQ
+ (BOOL) validateQQ:(NSString *)qq;
//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;
//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;
//车型
+ (BOOL) validateCarType:(NSString *)CarType;
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
//昵称
+ (BOOL) validateNickname:(NSString *)nickname;
//密码
+ (BOOL) validatePassword:(NSString *)passWord;
//用户名
+ (BOOL) validateUserName:(NSString *)name;

@end
