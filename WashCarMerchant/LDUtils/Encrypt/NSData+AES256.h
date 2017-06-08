//
//  NSData+AES256.h
//  AES
//
//  Created by Henry Yu on 2009/06/03.
//  Copyright 2010 Sevensoft Technology Co., Ltd.(http://www.sevenuc.com)
//  All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>
@interface NSData (AES256)
/*加密方法*/
+ (NSString *)AES256EncryptWithPlainText:(NSString *)plain keyWord:(NSString *)keyWord;

/*解密方法*/
+ (NSString *)AES256DecryptWithCiphertext:(NSString *)ciphertexts  keyWord:(NSString *)keyWord;



//data转换为十六进制。
+ (NSString *)hexStringFromData:(NSData *)myD;
//十六进制转换为data。
+ (NSData*) hexToBytes:(NSString *)str;

@end
