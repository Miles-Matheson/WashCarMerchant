//
//  CJMD5.m
//  LimiBuyer
//
//  Created by steven on 16/2/1.
//  Copyright © 2016年 limi360. All rights reserved.
//

#import "CJMD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation CJMD5

+(NSString *)md5HexDigest:(NSString *)input{
    
    const char *str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%2s",result];
    }
    
    return ret;
}

@end

//MD5是不可逆的只有加密没有解密，iOS代码加密使用方式如下
//NSString *userName = @"cerastes";
//NSString *password = @"hello Word";
//MD5加密
//NSString *md5 = [CJMD5 md5HexDigest:password];
//NSLog(@"%@",md5);
