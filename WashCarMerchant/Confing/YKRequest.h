//
//  LimiRequest.h
//  LimiBuyer
//
//  Created by steven on 16/1/29.
//  Copyright © 2016年 limi360. All rights reserved.
//  封装网络请求

#import <Foundation/Foundation.h>

@interface YKRequest : NSObject

+ (void)getDataWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)urlParam isCache:(BOOL)isCache isShowLoadingview:(BOOL)isShow success:(void (^)(id json))success fail:(void (^)())fail;
+ (void)postDataWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)postParam isCache:(BOOL)isCache isShowLoading:(BOOL)isShow success:(void (^)(id json))success fail:(void (^)())fail;

+ (void)uploadPicWithHost:(NSString *)host path:(NSString *)path param:(NSDictionary *)param files:(id)filePath progress:(void(^)(double uploadProgress))progress success:(void (^)(id json))success fail:(void (^)(NSString *message))fail;

@end
