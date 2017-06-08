//
//  LimiTime.m
//  LimiBuyer
//
//  Created by steven on 16/2/2.
//  Copyright © 2016年 limi360. All rights reserved.
//

#import "MFManager.h"

@implementation MFManager

+ (MFManager *)sharedManager
{
    static MFManager *mf = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        mf = [[self alloc] init];
        
        mf.didLogin = NO;
        
        NSDictionary *requestHeaderDic = @{
//            @"os"   :@"IOS",    //客户的系统 值为IOS|Android
//            @"app"  :@"b",      //客户端类型,b 买家,s 卖家
//            @"v"    :@"1.0.0",  //客户端版本
        };
        mf.requestHeaderDic = [[NSMutableDictionary alloc]init];
        [mf.requestHeaderDic addEntriesFromDictionary:requestHeaderDic];
        
        mf.loginParam = [[NSMutableDictionary alloc]init];
    });
    return mf;    
}

+ (NSString *)getTime
{
    NSDate *date = [NSDate date];
    NSTimeInterval timeInterval = date.timeIntervalSince1970;//10位.6位
    timeInterval = timeInterval * 1000000;
    NSString *str = [NSString stringWithFormat:@"%.0f",timeInterval];//13位
    return str;
}

@end
