//
//  WSColor.h
//  Kibernet
//
//  Created by steven on 14-9-19.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WSLColor : NSObject

/**
 *	@brief	十六进制颜色转换.
 *
 *	@param 	color 	十六进制颜色值,如#000000,FFFFFF.
 *
 *	@return	相应UIColor实例.
 */
+ (UIColor *)colorWithHex:(NSString *)color;

/**
 *	@brief	十六进制颜色转换.
 *
 *	@param 	color 	十六进制颜色值,如#000000,FFFFFF.
 *	@param 	alpha 	透明度.
 *
 *	@return	相应UIColor实例.
 */
+ (UIColor *)colorWithHex:(NSString *)color alpha:(CGFloat)alpha;

/**
 *	@brief	通过颜色来生成一个纯色图
 *
 *	@param 	color 	颜色值
 *
 *	@return	图片
 */
+ (UIImage *)CreateImageFromColor:(UIColor *)color;

@end
