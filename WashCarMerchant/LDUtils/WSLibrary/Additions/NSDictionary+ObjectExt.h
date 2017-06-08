//
//  NSDictionary+ObjectExt.h
//  LimiSeller
//
//  Created by steven on 16/3/3.
//  Copyright © 2016年 limi360. All rights reserved.
//

//http://www.knowsky.com/882510.html
//在后台的返回数据中，我们时常会遇到返回Null数据，那么我们在解析的时候需要对这种数据进行特殊的处理，但为了让我们每次都更快速的来处理这样的问题，所以我自己扩展面对了NSDictionary一个类别.对象如下


#import <Foundation/Foundation.h>



@interface NSDictionary (ObjectExt)

/**
 *获取字典指定的array的对象
 *
 *  @param aKey key
 *
 *  @return  value值如果为nil或者null会返回空列表
 */

-(NSArray*)arrayObjectForKey:(id)aKey;



/**
 *  获取字典指定的对象为空是返回默认对象
 *
 *  @param aKey          key
 *  @param defaultObject  value值如果为nil或者null会返回默认对象
 *
 *  @return 对象
 */

-(id)objectExtForKey:(id)aKey defaultObject:(id)defaultObject;



/**
 *获取字典指定的array的对象
 *
 *  @param aKey key
 *
 *  @return  value值如果为nil或者null会返回空列表
 */

-(NSMutableArray*)mutableArrayObjectForKey:(id)aKey;



/**
 * @brief 如果akey找不到，返回@"" (防止出现nil，使程序崩溃)
 *
 * @param aKey 字典key值
 *
 * @return 字典value
 */

- (NSString *)stringForKey:(id)aKey;





/**
 
 * @brief @brief 如果akey找不到，返回默认值 (防止出现nil，使程序崩溃)
 *
 * @param aKey 字典key值
 * @param defValue 为空时的默认值
 *
 * @return 字典value
 */

- (NSString *)stringForKey:(id)aKey withDefaultValue:(NSString *)defValue;



/**
 * @brief 替换&nbsp;为空
 *
 * @param aKey 字典key值
 *
 * @return 字典value
 */

- (NSString *)replaceNBSPforKey:(id)aKey ;



/**
 *获取字典指定的key的数值字符
 *
 *  @param aKey key
 *
 *  @return  value值如果为nil或者null会返回0字符串
 */

- (NSString*)numberStringForKey:(id)aKey;

@end