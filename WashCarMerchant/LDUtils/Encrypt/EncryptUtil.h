//
//  EncryptUtil.h
//  TestDes
//
//  Created by steven on 16/2/2.
//  Copyright © 2016年 limi360. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryptUtil : NSObject

+ (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;
+ (NSString *) decryptUseDES:(NSString *)cipherText key:(NSString *)key;

+ (NSString *) parseByte2HexString:(Byte *) bytes;
+ (NSString *) parseByteArray2HexString:(Byte[]) bytes;

@end
