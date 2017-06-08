//
//  DES.h
//  LimiBuyer
//
//  Created by steven on 16/2/1.
//  Copyright © 2016年 limi360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"

@interface DES : NSObject

+ (NSString *)encryptWithText:(NSString *)sText forKey:(NSString *)key;//加密
+ (NSString *)decryptWithText:(NSString *)sText forKey:(NSString *)key;//解密

@end
