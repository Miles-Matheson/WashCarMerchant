//
//  BSAllDefines.h
//  BSDigitalBank
//
//  Created by 付新明 on 15/4/17.
//  Copyright (c) 2015年 Fuxinming. All rights reserved.
//

//字符串定义
#define CarBrand @"CarBrand" 

/**
 *	@brief	 APP keyWindow
 */
#define WSKeyWindow [[[UIApplication sharedApplication] windows] lastObject]
/**
 *	@brief	  keyWindow Make a toast
 */
#define WSMakeToastInKeyWindow(str) [WSKeyWindow makeToast:str]

#define WSImage(name) [UIImage imageNamed:name]

#define MBShow(aView) [MBProgressHUD showHUDAddedTo:aView animated:YES]
#define MBHidden(aView) [MBProgressHUD hideAllHUDsForView:aView animated:YES]

/**
 *	@brief	简化UserDeafaults
 */
#define WSUserDeafaults [NSUserDefaults standardUserDefaults]
/**
 *	@brief	屏幕宽
 */
#define WSScreenWidth [WSLDevice screenWidth]
#define WSScreenHeight [WSLDevice screenHeight]

#define WS_Height_TabBar 49
#define WS_Height_NaviBar 64
/**
 *  6P放大后的分辨率
 */
#define iPhone6_Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6_Plus_amp ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2001), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone3 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPad_or_iPad_Mini ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(768, 1024), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPadRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(2048,1536), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPadRetina_Reverse ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1536,2048), [[UIScreen mainScreen] currentMode].size) : NO)

/**
 *  完美适配
 */
#define iphone6_scale_w 1.172
#define iphone6_scale_h 1.175
#define iPhone6Plus_scale_w 1.294
#define iPhone6Plus_scale_h 1.296

#define iphone3_5Inch (iPhone4||iPad_or_iPad_Mini||iPadRetina||iPadRetina_Reverse)

#define APP_CGRectMake(x,y,w,h)  (iPhone6 || iPhone6_Plus_amp)?CGRectMake(floor((x)*iphone6_scale_w), floor((y)*iphone6_scale_h), floor((w)*iphone6_scale_w), floor((h)*iphone6_scale_h)):iPhone6_Plus?CGRectMake(floor((x)*iPhone6Plus_scale_w), floor((y)*iPhone6Plus_scale_h), floor((w)*iPhone6Plus_scale_w), floor((h)*iPhone6Plus_scale_h)):CGRectMake((x), (y), (w), (h))

#define APP_CONTENT_WIDTH_PRAM(a) iPhone5?(a):(iPhone6 || iPhone6_Plus_amp)?floor((a)*iphone6_scale_w):iPhone6_Plus?floor((a)*iPhone6Plus_scale_w):(a)
#define APP_CONTENT_HEIGHT_PRAM(a) iPhone5?(a):(iPhone6 || iPhone6_Plus_amp)?floor((a)*iphone6_scale_h):iPhone6_Plus?floor((a)*iPhone6Plus_scale_h):(a)

#define APP_CONTENT_X_PRAM(a) iPhone5?(a):(iPhone6 || iPhone6_Plus_amp)?floor((a)*iphone6_scale_w):iPhone6_Plus?floor((a)*iPhone6Plus_scale_w):(a)
#define APP_CONTENT_Y_PRAM(a) iPhone5?(a):(iPhone6 || iPhone6_Plus_amp)?floor((a)*iphone6_scale_h):iPhone6_Plus?floor((a)*iPhone6Plus_scale_h):(a)

#define APP_Device_Height [WSLDevice deviceAppHeight]
