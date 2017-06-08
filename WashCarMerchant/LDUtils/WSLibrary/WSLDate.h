//
//  WSLDate.h
//  WiseSeller
//
//  Created by steven on 14-4-30.
//  Copyright (c) 2014年 steven. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WSLDateFormatDate @"yyyy-MM-dd HH:mm:ss"
#define WSLDateFormatDay @"yyyy-MM-dd"
#define WSLDateFormatTime @"HH:mm:ss"

/**
 *	@brief  Lib配置.
 */
@interface WSLDate : NSObject{
    
}
/**
 *	@brief	日期转换为格式字符串.
 *
 *	@param 	date 	待转换日期.
 *	@param 	format 	日期格式字符串.
 *
 *	@return	日期字符串.
 */
+ (NSString *)date2String:(NSDate *)date format:(NSString *)format;

/**
 *	@brief	当前日期转换为格式字符串.
 *
 *	@return	日期字符串, yyyy-MM-dd HH:mm:ss.
 */
+ (NSString *)date2StringNow;

/**
 *	@brief	日期转换为格式字符串.
 *
 *	@param 	date 	待转换日期.
 *
 *	@return	日期字符串, yyyy-MM-dd HH:mm:ss.
 */
+ (NSString *)date2String:(NSDate *)date;

/**
 *	@brief	日期转换为格式字符串.
 *
 *	@param 	date 	待转换日期.
 *
 *	@return	日期字符串, yyyy-MM-dd.
 */
+ (NSString *)date2StringDay:(NSDate *)date;

/**
 *	@brief	日期转换为格式字符串.
 *
 *	@param 	date 	待转换日期.
 *
 *	@return	日期字符串, HH:mm:ss.
 */
+ (NSString *)date2StringTime:(NSDate *)date;

/**
 *	@brief	日期字符串转换为日期.
 *
 *	@param 	date 	待转换日期字符串.
 *	@param 	format 	日期格式字符串.
 *
 *	@return	日期.
 */
+ (NSDate *)string2Date:(NSString *)dateStr format:(NSString *)format;

@end
