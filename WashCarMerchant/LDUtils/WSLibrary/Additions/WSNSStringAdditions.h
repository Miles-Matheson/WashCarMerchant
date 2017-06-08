//
//  WSNSStringAdditions.h
//  WiseSeller
//
//  Created by steven on 14-5-4.
//  Copyright (c) 2014年 steven. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *	@brief	NSString 拓展.
 */
@interface NSString (WSLibrary){
    
}
/**
 *	@brief	移除字符串首位空字符串.
 *
 *	@return	字符串实例.
 */
- (NSString *)trim;
- (NSString *) md5;
+(NSString *) jsonStringWithString:(NSString *) string;
+(NSString *) jsonStringWithArray:(NSArray *)array;
+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;
+(NSString *) jsonStringWithObject:(id) object;

@end

