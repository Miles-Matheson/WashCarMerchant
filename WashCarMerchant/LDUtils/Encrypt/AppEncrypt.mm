//
//  AppEncrypt.m
//  LimiBuyer
//
//  Created by steven on 16/2/1.
//  Copyright © 2016年 limi360. All rights reserved.
//

#import "AppEncrypt.h"
#import <CommonCrypto/CommonCryptor.h>
#import "NSData+Encryption.h"
#import "Convert.h"
#import "EncryptUtil.h"

NSString *getRandomKey() //   随机一个字母
{
    char c;
    int i = arc4random_uniform(3);//0~2
    if (i==0) {
        c = 'A' + (arc4random_uniform(26));//arc4random_uniform(x) : 0～(x-1)
    } else if(i==1) {
        c = 'a' + (arc4random_uniform(26));
    } else { //i==2
        c = '0' + (arc4random_uniform(10));
    }
    
    return [NSString stringWithFormat:@"%c",c];
}

NSString *fillString(NSString *str, int len, char c, BOOL fillLeft)
{
    char buff[len];
    if (str == NULL)
        return fillString(@"", len, c, fillLeft);
    if (str.length >= len)
        return fillLeft ? [str substringFromIndex:str.length - len] : [str substringWithRange:NSMakeRange(0, len)];
    for (int i = 0; i < len; i++) {
        if (fillLeft) {
            if (i < len - str.length)
                buff[i] = c;
            else
                buff[i] = [str characterAtIndex:(i - len + str.length)];
        } else {
            if (i >= str.length)
                buff[i] = c;
            else
                buff[i] = [str characterAtIndex:i];
        }
    }
    return [NSString stringWithCString:buff encoding:NSUTF8StringEncoding];
}

NSString *XOR(NSString *str, NSString *keystr, BOOL isEncode)
{
    NSString *strResult = @"";
    int nCount = (int)str.length;
    size_t nLen = (sizeof(unichar) * (nCount + 1));
    unichar *szArray = (unichar *)malloc(nLen);
    
    int strLen = (int)str.length;
    for (int i = 0; i < keystr.length; i++) {
        unichar key = [keystr characterAtIndex:i];
        for (int j = 0; j < strLen; j++) {
            if (isEncode) {
                unichar c = ([str characterAtIndex:j]) ^ (key << j % 8);
                szArray[strLen-j-1] = c;
            } else {
                unichar cc = ([str characterAtIndex:strLen-j-1]) ^ (key << j % 8);
                szArray[j] = cc;
            }
        }
    }
    szArray[nCount] = '\0';
    strResult = [[NSString alloc] initWithCharacters:szArray length:nCount];
    free(szArray);
    return strResult;
}

//  加密token
NSString *encodeToken(NSString *token, NSString *key)
{
    key = fillString(key,KEYLENGTH,'0',YES);
    
    token = XOR(token, key, YES);
    
    NSData *data = [token dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    token = [data dataToHexString];
    token = token.uppercaseString;
    
    return token;
}

//  解密token
NSString *decodeToken(NSString *token, NSString *key)
{
    key = fillString(key,KEYLENGTH,'0',YES);
    
    token = token.lowercaseString;
    NSData *data = [token stringToHexData];
    token = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    token = XOR(token, key, NO);
    
    return token;
}

//  加密密码
NSString *encodePwd(NSString *pwdstr, NSString *key)
{
    key = fillString(key,KEYLENGTH,'0',YES);
    
    pwdstr = XOR(pwdstr, key, true);
    
    pwdstr = [EncryptUtil encryptUseDES:pwdstr key:key];
    
    NSData *data = [pwdstr dataUsingEncoding:NSUTF8StringEncoding];
    pwdstr = [data dataToHexString];
    pwdstr = pwdstr.uppercaseString;
    
    return pwdstr;
}

//  解密密码
NSString *decodePwd(NSString *pwd, NSString *key){
    key = fillString(key,KEYLENGTH,'0',true);
    
    pwd = pwd.lowercaseString;
    NSData *data = [pwd stringToHexData];
    pwd = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    pwd = [EncryptUtil decryptUseDES:pwd key:key];
    
    pwd = XOR(pwd, key, false);
    
    return pwd;
}

@implementation AppEncrypt

+ (NSString *)getRandomKey
{
    return getRandomKey();
}

+ (NSString *)fillString:(NSString *)str len:(int)len c:(char)c fillLeft:(BOOL)fillLeft;
{
    return fillString(str, len, c, fillLeft);
}

+ (NSString *)XOR:(NSString *)str keystr:(NSString *)keystr isencode:(BOOL)isencode
{
    return XOR(str, keystr, isencode);
}

+ (NSString *)encodeToken:(NSString *)token key:(NSString *)key
{
    return encodeToken(token,key);
}

+ (NSString *)decodeToken:(NSString *)token key:(NSString *)key
{
    return decodeToken(token,key);
}

+ (NSString *)encodePwd:(NSString *)pwdstr key:(NSString *)key
{
    return encodePwd(pwdstr,key);
}

+ (NSString *)decodePwd:(NSString *)pwdstr key:(NSString *)key
{
    return decodePwd(pwdstr,key);
}

@end




