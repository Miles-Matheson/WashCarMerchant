//
//  WSUtil.h
//  WiseSeller
//
//  Created by steven on 14-4-28.
//  Copyright (c) 2014年 steven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

/**
 *	@brief	WSLibrary 库全局信息类.
 */
@interface WSLUtil : NSObject{
    
}

/**
 *	@brief	判断字符串是否是空或NULL
 *
 *	@return	Yes为空，NO不为空
 */
+ (BOOL)strNilOrEmpty:(NSString *)str;

/**
 *	@brief	字符串格式化，将空字符串格式为@""
 *
 *	@return	返回字符串
 */
+ (NSString *)strRelay:(id)str;
+ (NSString *)strFromInt:(int)ntValue;
+ (NSString *)strFromBool:(BOOL)boolValue;
+ (NSString *)strFromId:(id)objectValue;
+ (BOOL)strToBool:(NSString *)boolStr;

/**
 *	@brief	获取app目录中的图片, 不缓存.
 *
 *	@param 	imageName 	图片名称.
 *
 *	@return	imageName对应的图片.
 */
+ (UIImage *)imgRes:(NSString *)imageName;

/**
 *	@brief	创建GUID字符串.
 *
 *	@return	GUID字符串.
 */
+ (NSString *)strGUID;

/**
 *	@brief	判断字符串是否是有效的数字
 *
 *	@param 	str 	传入的字符串
 *
 *	@return	YES为是，NO为否
 */
+ (BOOL)matcher:(NSString *)str;

/**
 *	@brief	取得文本在固定的字体情况下，在固定大小控件中的大小
 *
 *	@param 	str 	文本
 *	@param 	font 	字体
 *	@param 	size 	控件大小
 *
 *	@return	文本大小
 */
+ (CGSize)sizeForStr:(NSString *)str Font:(UIFont *)font CtrlSize:(CGSize)size;

/**

/**
 *	@brief	检查手机号
 *
 *	@return
 */
+ (BOOL)checkPhone:(NSString *)str;

/**
 *	@brief	获取应用程序版本号
 *
 *	@return
 */
+ (NSString *)getAppVersion;

+ (float)getBannerHeight;
+(float)getViewSize:(float)t;
/**
 *	@brief	拨打电话
 *
 *	@return
 */
+ (void)callPhoneNum:(NSString *)phone;
+ (BOOL)getUserCapturePermissions;
/**
 *  相机权限判断
 *
 *  @return 处理结果,如果没有权限,则弹出提示
 */
+ (BOOL)showUserCapturePermissionsAlert;
+ (BOOL)checkNetStatus;
+(UIImage *)compressImageWith:(UIImage *)image;

//3D摇晃动画开始
+ (void)startAntimation3DAtView:(UIView *)antimationView;
//获取IP地址
+(NSString *)getIPAddress;
//打开网址
+ (void)openUrl:(NSString *)url;
+(CABasicAnimation*)moveTime:(float)time X:(NSNumber *)x;//横向移动
+ (NSString *)generate_uuid;
@end
