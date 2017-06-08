//
//  WSUtil.m
//  WiseSeller
//
//  Created by steven on 14-4-28.
//  Copyright (c) 2014年 steven. All rights reserved.
//

#import "WSLUtil.h"
#import "AVFoundation/AVCaptureDevice.h"
#import "AVFoundation/AVMediaFormat.h"
#import "AVFoundation/AVCaptureDevice.h"
#import "AFNetworkTool.h"
#import "AFNetworking.h"
#import <ifaddrs.h>
#import <arpa/inet.h>

@implementation WSLUtil

+ (BOOL)strNilOrEmpty:(NSString *)str{
    return str == nil
    || str == NULL
    || [str isKindOfClass:[NSNull class]]
    ||([str respondsToSelector:@selector(length)]
       && [(NSData *)str length] == 0)
    || ([str respondsToSelector:@selector(count)]
        && [(NSArray *)str count] == 0);
}

+ (NSString *)strRelay:(id)str
{
    if([WSLUtil strNilOrEmpty:str]){
        return @"";
    }
    else if([str isKindOfClass:[NSString class]]){
        return str;
    }
    else if([str isKindOfClass:[NSNumber class]]){
        return [str stringValue];
    }
    return str;
}

#pragma mark - Convert

+ (NSString *)strFromInt:(int)ntValue{
    return [NSString stringWithFormat:@"%d", ntValue];
}

+ (NSString *)strFromBool:(BOOL)boolValue{
    NSString *str = @"0";
    if (boolValue) {
        str = @"1";
    }
    return str;
}

+ (NSString *)strFromId:(id)objectValue{
    if ([objectValue isKindOfClass:[NSNumber class]]) {
        return [objectValue stringValue];
    }
    else if([objectValue isKindOfClass:[NSString class]]){
        return (NSString *)objectValue;
    }
    else{
        return @"";
    }
}

+ (BOOL)strToBool:(NSString *)boolStr{
    if ([boolStr isKindOfClass:[NSString class]] && [boolStr isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}

+ (UIImage *)imgRes:(NSString *)imageName{
    NSString *resPath = [WSLFile fileResourceDir:imageName];
    UIImage *img = [UIImage imageWithContentsOfFile:resPath];
    return img;
}

+ (BOOL)matcher:(NSString *)str
{
    NSString *matcStr = @"^[-+]?[0-9]+(\\.[0-9]+)?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", matcStr];
    
    if ([predicate evaluateWithObject:str]) {
        return YES;
    }
    
    if (str.length == 0) {
        return  YES;
    }
    
    return NO;
}

+ (NSString *)strGUID
{
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);//create a new GUID
    NSString    *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    NSString *guidStr = [uuidString lowercaseString];
    return guidStr;
}


+(AppDelegate *)appDelegate
{
    return ((AppDelegate *)[UIApplication sharedApplication].delegate);
}



+ (BOOL)checkPhone:(NSString *)str{
    NSString *matcStr = @"^(1[1-9][0-9])\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", matcStr];
    
    if ([predicate evaluateWithObject:str] || str.length == 0) {
        return YES;
    }
    return NO;
}

+ (NSString *)getAppVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (void)callPhoneNum:(NSString *)phone{
    NSString *ph = [NSString stringWithFormat:@"tel://%@",phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ph]];
}

+ (void)openUrl:(NSString *)url{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

+ (BOOL)getUserCapturePermissions
{
    if (TARGET_IPHONE_SIMULATOR) {
        return NO;
    }
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(status == AVAuthorizationStatusAuthorized) {
        // authorized
        return YES;
    } else if(status == AVAuthorizationStatusDenied){
        // close
        return NO;
    } else if(status == AVAuthorizationStatusRestricted){
        // restricted
        return NO;
    } else if(status == AVAuthorizationStatusNotDetermined){
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        }];
        return YES;
    }
    return NO;
}


@end
