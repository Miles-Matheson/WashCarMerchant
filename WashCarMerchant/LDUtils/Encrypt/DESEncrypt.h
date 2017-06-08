//
//  DESEncrypt.h
//  LimiBuyer
//
//  Created by steven on 16/2/2.
//  Copyright © 2016年 limi360. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DESEncrypt : NSObject
//加密方法
+ (NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key;
//解密方法
+ (NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key;

@end
