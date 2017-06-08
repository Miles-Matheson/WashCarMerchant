//
//  NSArray+MyLog.m
//  OMengClient
//
//  Created by Steven on 15/11/24.
//  Copyright © 2015年 shanjin. All rights reserved.
//  打印带中文log

#import "NSArray+MyLog.h"

@implementation NSArray (MyLog)

//- (NSString *)descriptionWithLocale:(id)locale
//{
//    return [NSString stringWithCString:[[self description] cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
//}

@end


@implementation NSDictionary (MyLog)

- (NSString *)descriptionWithLocale:(id)locale
{
    return [NSString stringWithCString:[[self description] cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
}

@end