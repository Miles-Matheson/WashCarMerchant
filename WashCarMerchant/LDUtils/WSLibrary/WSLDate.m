//
//  WSLDate.m
//  WiseSeller
//
//  Created by steven on 14-4-30.
//  Copyright (c) 2014年 steven. All rights reserved.
//

#import "WSLDate.h"

@implementation WSLDate
+ (NSString *)date2String:(NSDate *)date format:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

+ (NSDate *)string2Date:(NSString *)dateStr format:(NSString *)format{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:format];//设定时间格式,要注意跟下面的dateString匹配，否则日起将无效
    NSDate *date =[dateFormat dateFromString:dateStr];
    return date;
}

+ (NSString *)date2StringNow{
    NSDate *dateNow = [NSDate date];
    return [WSLDate date2String:dateNow format:WSLDateFormatDate];
}

+ (NSString *)date2String:(NSDate *)date{
    return [WSLDate date2String:date format:WSLDateFormatDate];
}

+ (NSString *)date2StringDay:(NSDate *)date{
    return [WSLDate date2String:date format:WSLDateFormatDay];
}

+ (NSString *)date2StringTime:(NSDate *)date{
    return [WSLDate date2String:date format:WSLDateFormatTime];
}
@end
