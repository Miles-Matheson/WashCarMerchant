//
//  NSData+AES256.m
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

#import "NSData+AES256.h"
const NSUInteger kAlgorithmKeySize = kCCKeySizeAES128;
const NSUInteger kPBKDFRounds = 10000;  // ~80ms on an iPhone 4

static Byte saltBuff[] = {0,1,2,3,4,5,6,7,8,9,0xA,0xB,0xC,0xD,0xE,0xF};

static Byte ivBuff[]   = {0xA,1,0xB,5,4,0xF,7,9,0x17,3,1,6,8,0xC,0xD,91};

@implementation NSData (AES256)

+ (NSData *)AESKeyForPassword:(NSString *)password{
    NSMutableData *derivedKey = [NSMutableData dataWithLength:kAlgorithmKeySize];
    NSData *salt = [NSData dataWithBytes:saltBuff length:kCCKeySizeAES128];
    int result = CCKeyDerivationPBKDF(kCCPBKDF2,        // algorithm算法
                                  password.UTF8String,  // password密码
                                  password.length,      // passwordLength密码的长度
                                  salt.bytes,           // salt内容
                                  salt.length,          // saltLen长度
                                  kCCPRFHmacAlgSHA1,    // PRF
                                  kPBKDFRounds,         // rounds循环次数
                                  derivedKey.mutableBytes, // derivedKey
                                  derivedKey.length);   // derivedKeyLen derive:出自
    
    NSAssert(result == kCCSuccess,
             @"Unable to create AES key for spassword: %d", result);
    return derivedKey;
}

/*加密方法*/
+ (NSString *)AES256EncryptWithPlainText:(NSString *)plain keyWord:(NSString *)keyWord
{
    NSData *plainText = [plain dataUsingEncoding:NSUTF8StringEncoding];
	// 'key' should be 32 bytes for AES256, will be null-padded otherwise
	char keyPtr[kCCKeySizeAES128+1]; // room for terminator (unused)
	bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
        
	NSUInteger dataLength = [plainText length];

	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
    bzero(buffer, sizeof(buffer));
	
	size_t numBytesEncrypted = 0;
    
	CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,kCCOptionPKCS7Padding,
                                          [[NSData AESKeyForPassword:keyWord] bytes], kCCKeySizeAES128,
										  ivBuff /* initialization vector (optional) */,
										  [plainText bytes], dataLength, /* input */
										  buffer, bufferSize, /* output */
										  &numBytesEncrypted);
	if (cryptStatus == kCCSuccess) {
        NSData *encryptData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        
        NSString *aString = [self hexStringFromData:encryptData];
        return [aString uppercaseString];
	}
	
	free(buffer); //free the buffer;
	return nil;
}

/*解密方法*/
+ (NSString *)AES256DecryptWithCiphertext:(NSString *)ciphertexts  keyWord:(NSString *)keyWord
{
    NSData *cipherData = [self hexToBytes:ciphertexts];
	char keyPtr[kCCKeySizeAES128+1]; // room for terminator (unused)
	bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
	    
	NSUInteger dataLength = [cipherData length];
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
	    
	size_t numBytesDecrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
										  [[NSData AESKeyForPassword:keyWord] bytes], kCCKeySizeAES128,
										  ivBuff ,/* initialization vector (optional) */
										  [cipherData bytes], dataLength, /* input */
										  buffer, bufferSize, /* output */
										  &numBytesDecrypted);
	
	if (cryptStatus == kCCSuccess) {
        NSData *encryptData = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
		return [[[NSString alloc] initWithData:encryptData encoding:NSUTF8StringEncoding] init];
	}
	free(buffer);
	return nil;
}

//data转换为十六进制的。
+ (NSString *)hexStringFromData:(NSData *)myD{
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    NSLog(@"%@",hexStr);
    return hexStr;
}

//十六进制转换为data
+(NSData*) hexToBytes:(NSString *)str
{
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= str.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [str substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
        
    } 
    return data; 
}
@end
