//
//  WSLDevice.m
//  WiseSeller
//
//  Created by steven on 14-4-28.
//  Copyright (c) 2014年 steven. All rights reserved.
//

#import "WSLDevice.h"

@implementation WSLDevice
+ (WSLScreenSize)screenSize{
    UIScreen *ms = [UIScreen mainScreen];
    CGSize tempSize = CGSizeMake(320, 480);
    if ([ms respondsToSelector:@selector(currentMode)]) {
        tempSize = ms.currentMode.size;
    }
    CGFloat width = MIN(tempSize.width, tempSize.height);
    CGFloat height = MAX(tempSize.width, tempSize.height);
    CGSize cmSize = CGSizeMake(width, height);
    if(cmSize.width == 640){
        if(cmSize.height == 1136){
            return WSLScreenSizePhone5;
        }
        else{
            return WSLScreenSizePhoneRetina;
        }
    }
    else if(cmSize.width == 1024){
        return WSLScreenSizePad;
    }
    else if(cmSize.width == 2048){
        return WSLScreenSizePadRetina;
    }
    else if(cmSize.width == 750){
        return WSLScreenSizePhone6;
    }
    else if(cmSize.width == 1242){
        return WSLScreenSizePhone6p;
    }
    else{
        return WSLScreenSizePhone;
    }
}

+ (WSLScreenDisplay)screenDisplay{
    UIScreen *mainScreen = [UIScreen mainScreen];
    if ([mainScreen respondsToSelector:@selector(scale)] && [mainScreen scale] == 2) {
        return WSLScreenDisplayRetina;
    }
    else{
        return WSLScreenDisplayNormal;
    }
}

+ (BOOL)screenIsRetina{
    WSLScreenDisplay dis = [WSLDevice screenDisplay];
    if (dis == WSLScreenDisplayRetina) {
        return YES;
    }
    return NO;
}

+ (BOOL)screenIs4Inch{
    WSLScreenSize size = [WSLDevice screenSize];
    if (size == WSLScreenSizePhone5) {
        return YES;
    }
    return NO;
}

+ (BOOL)screenIs4sInch
{
    WSLScreenSize size = [WSLDevice screenSize];
    if (size == WSLScreenSizePhoneRetina) {
        return YES;
    }
    return NO;
}

+ (CGFloat)screenHeight{
    UIScreen *screen = [UIScreen mainScreen];
    CGFloat h = [screen applicationFrame].size.height;
    CGFloat sh = [UIApplication sharedApplication].statusBarFrame.size.height;
    if ([WSLDevice deviceIsIOS7]) {
        h += sh;
    }
    return h;
}

+ (CGFloat)screenWidth{
    UIScreen *screen = [UIScreen mainScreen];
    return [screen applicationFrame].size.width;
}

+ (BOOL)deviceIsIOS7{
    NSComparisonResult vRes = [WSLDevice deviceOSVersion:7.0];
    if (vRes == NSOrderedAscending || vRes == NSOrderedSame) {
        return YES;
    }
    return NO;
}

+ (NSString *)deviceOSVersion{
    UIDevice *currentDevice = [UIDevice currentDevice];
    return [currentDevice systemVersion];
}

+ (NSComparisonResult)deviceOSVersion:(CGFloat)version{
    UIDevice *currentDevice = [UIDevice currentDevice];
    NSString *strVer = [currentDevice systemVersion];
    CGFloat osVersion = [strVer floatValue];
    if (osVersion > version) {
        return NSOrderedAscending;
    }
    else if(osVersion < version){
        return NSOrderedDescending;
    }
    else{
        return NSOrderedSame;
    }
}

+ (CGFloat)appNavHeight
{
    float h = 44;
    if ([WSLDevice deviceIsIOS7]) {
        return h + WS_Height_StatusBar;
    }
    return h;
}

+ (CGFloat)appTabHeight
{
    float h = 49;
    return h;
}

+ (CGFloat)conHeight:(WSConHeight)ht{
    CGFloat h = [WSLDevice screenHeight];
    CGFloat navH = [WSLDevice appNavHeight];
    switch (ht) {
        case WSConHeightDefault:
            h = [WSLDevice screenHeight];
            break;
        case WSConHeightNav:
            h = [WSLDevice screenHeight] - navH;
            break;
        case WSConHeightNavTabBottom:
            h = [WSLDevice screenHeight] - navH - [WSLDevice appTabHeight];
            break;
        default:
            break;
    }
    return h;
}

+ (float)deviceAppHeight{
    float h = 588;
    if ([WSLDevice screenSize]==WSLScreenSizePhone||
        [WSLDevice screenSize]==WSLScreenSizePhoneRetina) {
        h = 480;
    }
    return h;
}
@end
