//
//  AppEncrypt.h
//  LimiBuyer
//
//  Created by steven on 16/2/1.
//  Copyright © 2016年 limi360. All rights reserved.
//

#import <Foundation/Foundation.h>

static int KEYLENGTH = 8;// 必须为8的倍数

NSString *getRandomKey();
NSString *fillString(NSString *str, int len, char c, BOOL fillLeft);
NSString *XOR(NSString *str, NSString *keystr, BOOL isencode);
NSString *encodeToken(NSString *token, NSString *key);
NSString *decodeToken(NSString *token, NSString *key);
NSString *encodePwd(NSString *pwdstr, NSString *key);
NSString *decodePwd(NSString *pwd, NSString *key);

@interface AppEncrypt : NSObject

//  封装一下c函数
+ (NSString *)getRandomKey;
+ (NSString *)fillString:(NSString *)str len:(int)len c:(char)c fillLeft:(BOOL)fillLeft;
+ (NSString *)XOR:(NSString *)str keystr:(NSString *)keystr isencode:(BOOL)isencode;
+ (NSString *)encodeToken:(NSString *)token key:(NSString *)key;
+ (NSString *)decodeToken:(NSString *)token key:(NSString *)key;
+ (NSString *)encodePwd:(NSString *)pwdstr key:(NSString *)key;
+ (NSString *)decodePwd:(NSString *)pwdstr key:(NSString *)key;

@end


