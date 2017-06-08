//
//  WSLDevice.h
//  WiseSeller
//
//  Created by steven on 14-4-28.
//  Copyright (c) 2014年 steven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *	@brief	屏幕尺寸类型.
 */
typedef NS_ENUM(NSInteger, WSLScreenSize) {
    WSLScreenSizePhone = 1, /**< 320 * 480(iPhone、iPhone3G、iPhone3GS、iPod1、iPod2、iPod3) */
    WSLScreenSizePhoneRetina, /**< 640 * 960(iPhone4、iPhone4S、iPod4) */
    WSLScreenSizePhone5, /**< 1136 * 640(iPhone5s、iPhone5s、iPod5) */
    WSLScreenSizePad, /**< 1024 * 768(iPad、iPad2) */
    WSLScreenSizePadRetina, /**< 2048 * 1536(The new iPad、iPad4) */
    WSLScreenSizePhone6, /**< 750 * 1334(iPhone6) */
    WSLScreenSizePhone6p, /**< 1242 * 2208(iPhone6p) */
};

/**
 *	@brief	屏幕显示类型.
 */
typedef NS_ENUM(NSInteger, WSLScreenDisplay) {
    WSLScreenDisplayNormal = 1, /**< 普通屏幕 */
    WSLScreenDisplayRetina, /**< Retina屏幕 */
};

/**
 *	@brief	内容视图高度.
 */
typedef NS_ENUM(NSInteger, WSConHeight) {
    WSConHeightDefault = 0, /**< 屏幕完整高度 */
    WSConHeightNav, /**< 仅含导航栏高度 */
    WSConHeightNavTabBottom,    /**< 含导航栏和底部Tab控件的高度 */
};

/**
 *	@brief	设备信息.
 */
@interface WSLDevice : NSObject{
    
}

/**
 *	@brief	屏幕尺寸.
 *
 *	@return	屏幕尺寸类型.
 */
+ (WSLScreenSize)screenSize;

/**
 *	@brief	屏幕显示.
 *
 *	@return	屏幕显示类型.
 */
+ (WSLScreenDisplay)screenDisplay;

/**
 *	@brief  Retina屏幕检测.
 *
 *	@return 是否为Retina屏幕.
 */
+ (BOOL)screenIsRetina;

/**
 *	@brief  5-inch屏幕检测.
 *
 *	@return	是否为4-inch屏幕.
 */
+ (BOOL)screenIs4Inch;
/**
 *	@brief  iphone 4/4s屏幕检测.
 *
 *	@return	是否为4-inch屏幕.
 */
+ (BOOL)screenIs4sInch;

/**
 *	@brief	屏幕高度, applicationFrame高度, iOS7以下不包含状态栏高度, iOS7以上包含状态栏高度.
 *
 *	@return	当前屏幕高度。
 */
+ (CGFloat)screenHeight;

/**
 *	@brief	屏幕宽度.
 *
 *	@return	当前屏幕宽度。
 */
+ (CGFloat)screenWidth;

/**
 *	@brief  iOS 7 版本检测.
 *
 *	@return	是否为iOS 7.0或以上版本.
 */
+ (BOOL)deviceIsIOS7;

/**
 *	@brief	获取系统版本号.
 *
 *	@return 当前系统版本号.
 */
+ (NSString *)deviceOSVersion;

/**
 *	@brief	系统版本比对, 版本float值比较.
 *
 *	@param  version 待比较版本.
 *
 *	@return	比较结果:
 *
 @verbatim
    OS Version > version    NSOrderedAscending, 系统版本大于Version值;
    OS Version < version    NSOrderedDescending, 系统版本小于Version值;
    OS Version = version    NSOrderedSame, 系统版本与Version值相同;
 @endverbatim
 */
+ (NSComparisonResult)deviceOSVersion:(CGFloat)version;

/**
 *	@brief	动态获取导航栏高度.
 *
 *	@return	导航栏高度值.
 */
+ (CGFloat)appNavHeight;
/**
 *	@brief	动态获取Tab栏高度.
 *
 *	@return	Tab栏高度值.
 */
+ (CGFloat)appTabHeight;

/**
 *	@brief	获取内容页面高度.
 *
 *	@param 	ht
 *
 *	@return	内容页面高度.
 */
+ (CGFloat)conHeight:(WSConHeight)ht;

+ (float)deviceAppHeight;

@end
