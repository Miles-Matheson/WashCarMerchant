
//  LimiRequest.m
//  LimiBuyer
//
//  Created by steven on 16/1/29.
//  Copyright © 2016年 limi360. All rights reserved.
//

#import "YKRequest.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "AppEncrypt.h"
#import "YKManager.h"


//#import "NetworkManager.h"
//#import <AlicloudHttpDNS/AlicloudHttpDNS.h>

@interface YKRequest ()///<, NSURLConnectionDataDelegate>

@end



@implementation YKRequest

+ (NSString *)generate_uuid
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    
    NSString *uuid = [NSString stringWithString:(NSString*)CFBridgingRelease(uuid_string_ref)];
    return uuid;
}

+ (BOOL)strNilOrEmpty:(NSString *)str{
    return str == nil
    || str == NULL
    || [str isKindOfClass:[NSNull class]]
    ||([str respondsToSelector:@selector(length)]
       && [(NSData *)str length] == 0)
    || ([str respondsToSelector:@selector(count)]
        && [(NSArray *)str count] == 0);
}


+ (NSString *)getCachePath:(NSString *)url{
    NSString *cachePath = [WSLFile fileCacheDir:@"data"];
    if (![WSLFile fileExistAtPath:cachePath]) {
        [WSLFile fileCreateDir:cachePath];
    }
    url = [url md5];
    NSString *dataPath = [NSString stringWithFormat:@"%@/%@",cachePath,url];
    return dataPath;
}

+ (id) processDictionaryIsNSNull:(id)obj{
    const NSString *blank = @"";
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dt = [(NSMutableDictionary*)obj mutableCopy];
        for(NSString *key in [dt allKeys]) {
            id object = [dt objectForKey:key];
            if([object isKindOfClass:[NSNull class]]) {
                [dt setObject:blank
                       forKey:key];
            }
            else if ([object isKindOfClass:[NSString class]]){
                NSString *strobj = (NSString*)object;
                if ([strobj isEqualToString:@"<null>"]) {
                    [dt setObject:blank
                           forKey:key];
                }
            }
            else if ([object isKindOfClass:[NSNumber class]]){
                NSString *strobj = (NSString*)object;
                [dt setObject:[NSString stringWithFormat:@"%@",strobj]
                       forKey:key];
            }
            else if ([object isKindOfClass:[NSArray class]]){
                NSArray *da = (NSArray*)object;
                da = [self processDictionaryIsNSNull:da];
                [dt setObject:da
                       forKey:key];
            }
            else if ([object isKindOfClass:[NSDictionary class]]){
                NSDictionary *ddc = (NSDictionary*)object;
                ddc = [self processDictionaryIsNSNull:object];
                [dt setObject:ddc forKey:key];
            }
        }
        return [dt copy];
    }
    else if ([obj isKindOfClass:[NSArray class]]){
        NSMutableArray *da = [(NSMutableArray*)obj mutableCopy];
        for (int i=0; i<[da count]; i++) {
            NSDictionary *dc = [obj objectAtIndex:i];
            dc = [self processDictionaryIsNSNull:dc];
            [da replaceObjectAtIndex:i withObject:dc];
        }
        return [da copy];
    }
    else{
        return obj;
    }
}


#pragma mark - GET
+ (void)getDataWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)urlParam isCache:(BOOL)isCache isShowLoadingview:(BOOL)isShow success:(void (^)(id json))success fail:(void (^)())fail
{
    WS(bself);
    //显示HUD
    if (isShow) {[SVProgressHUD show];}
    
    NSString *url = [bself getUrl:host path:path param:urlParam];
    NSString *cachePath = [self getCachePath:url];
    
    if (isCache && [WSLFile fileExistAtPath:cachePath])
    {
        NSData *content = [NSData dataWithContentsOfFile:cachePath];
        id jsonx = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableContainers error:nil];
        if (jsonx!=nil) {
            //隐藏HUD
            [SVProgressHUD dismiss];
            
            success(jsonx);
        }
    }
    [bself getJSONWithUrl:url success:^(id json) {
        //隐藏HUD
        [SVProgressHUD dismiss];
        
        json = [self processDictionaryIsNSNull:json];
        if (isCache) {
            [WSLFile fileWriteAtPath:cachePath data:[NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil]];
        }
        success(json);
    } fail:^(NSError *error) {
        //隐藏HUD
         [SVProgressHUD dismiss];
        
        if (fail) {

            fail();
        }
    }];
}

#pragma mark - GET JSON
+ (void)getJSONWithUrl:(NSString *)urlStr success:(void (^)(id json))success fail:(void (^)(NSError *))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 60.f;
    [self setAfnHTTPHeader:manager.requestSerializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSData *data = (NSData *)responseObject;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        if (success) {
            success(dic);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (fail) {
            NSLog(@"%@",error);
            fail(error);
        }
    }];
}

#pragma mark - POST
+ (void)postDataWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)postParam isCache:(BOOL)isCache isShowLoading:(BOOL)isShow success:(void (^)(id json))success fail:(void (^)())fail
    {
        WS(bself);
        //显示HUD
        if (isShow) {[self show];}
        
        
        postParam = @{@"data":postParam};
        
        NSDictionary *mutPara = [YKRequest setupBaseInfoWithManager:[AFHTTPSessionManager new] paraDic:postParam];

        
        NSString * url = [bself postUrl:host path:path];
        
        NSString *cachePath = [self getCachePath:url];
        
        if (isCache && [WSLFile fileExistAtPath:cachePath])
        {
            NSData *content = [NSData dataWithContentsOfFile:cachePath];
            id jsonx = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableContainers error:nil];
            if (jsonx!=nil) {
                //隐藏HUD
                [self dismis];
                
                success(jsonx);
            }
        }
        
           [bself postJSONWithUrl:url parameters:mutPara success:^(id json) {
               
            //隐藏HUD
            [bself dismis];
            json = [self processDictionaryIsNSNull:json];
       
            if (isCache) {
                [WSLFile fileWriteAtPath:cachePath data:[NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil]];
            }
            success(json);
              
        } fail:^(NSError *error) {
            //隐藏HUD
            [bself dismis];
            
            if (fail) {
                [[UIApplication sharedApplication].keyWindow showCenterToast:@"网络连接失败"];
            
                fail();
            }
        }];
    }

#pragma mark - POST JSON
+ (void)postJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 60.f;
//    [self setAfnHTTPHeader:manager.requestSerializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString * url = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [manager POST:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        
        NSString *jsonString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        if (success) {
            success(dic);
        }
        NSLog(@"\n\n【请求地址】%@\n【请求参数】\n%@\n【请求Json】\n%@\n【返回json】\n%@\n【解析json】\n%@\n\n",urlStr,parameters,[self DataToJsonString:parameters],jsonString,dic);
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"\n\n【请求地址】%@\n【请求参数】\n%@\n【请求Json】\n%@",urlStr,parameters,[self DataToJsonString:parameters]);
        
        if (fail) {
            fail(error);
        }
        
    }];
}

+ (NSString*)DataToJsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    
    @try {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                           options:NSJSONWritingPrettyPrinted
                            // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        if (! jsonData) {
            NSLog(@"Got an error: %@", error);
        } else {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        return jsonString;
    } @catch (NSException *exception) {
        return @"";
    }
}

#pragma mark - get urlString

+ (NSString *)getUrl:(NSString *)host path:(NSString *)path param:(NSDictionary *)param{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",host,path];
//    urlString = [NSString stringWithFormat:@"%@%@",[self getIpFromDomain:host],path];//使用httpdns服务
    
    NSMutableDictionary *dicParam = [[NSMutableDictionary alloc] initWithDictionary:param];
    [dicParam addEntriesFromDictionary:[self getDefaultParams]];
    
    if (dicParam!=nil) {
        for (int i = 0; i < [[dicParam allKeys] count]; i++) {
            NSString *key = [[dicParam allKeys] objectAtIndex:i];
            NSString *value = [dicParam objectForKey:key];
            if (i==0) {
                urlString = [NSString stringWithFormat:@"%@%@=%@",urlString,key,value];
            } else{
                urlString = [NSString stringWithFormat:@"%@&%@=%@",urlString,key,value];
            }
        }
    }
    NSString *encodingString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return encodingString;
}

#pragma mark - post urlString
+ (NSString *)postUrl:(NSString *)host path:(NSString *)path
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",host,path];
//    urlString = [NSString stringWithFormat:@"%@%@",[self getIpFromDomain:host],path];//使用httpdns服务
    
    return urlString;
}

#pragma mark - HUD
+ (void)show
{
    [SVProgressHUD show];
}

+ (void)dismis{
    [SVProgressHUD dismiss];
}

#pragma mark - 上传图片
+ (void)uploadPicWithHost:(NSString *)host path:(NSString *)path param:(NSDictionary *)param files:(id)filePath progress:(void(^)(double uploadProgress))progress success:(void (^)(id json))success fail:(void (^)(NSString *message))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 180.f;
    
    NSString *host2 = [self postUrl:host path:path];
    [self setAfnHTTPHeader:manager.requestSerializer];
    
    BOOL isMultiUpload = NO;
    if ([filePath isKindOfClass:[NSString class]]) {
        isMultiUpload = NO;
    }else if ([filePath isKindOfClass:[NSArray class]]) {
        isMultiUpload = YES;
    }
    
    [manager POST:host2 parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  formData)
     {
         if (!isMultiUpload) {
             UIImage *img = [UIImage imageWithContentsOfFile:filePath];
             NSData *data = UIImageJPEGRepresentation(img, 0.5);
             NSString *fileName = [NSString stringWithFormat:@"%@.jpg",[self generate_uuid]];
             [formData appendPartWithFileData:data name:@"upfile" fileName:fileName mimeType:@"image/jpeg"];
         }else{
//             WSMakeToastInKeyWindow(@"暂不支持多文件上传");
             return;
         }
     } progress:^(NSProgress *uploadProgress) {
         if (progress) {
             progress(uploadProgress.fractionCompleted);
         }
     } success:^(NSURLSessionDataTask *task, id responseObject) {
         id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         if (json) {
             if (success) {
                 success(json);
             }
         }else{
             if (fail) {
                 fail([NSString stringWithFormat:@"解析json出错,responseObject=%@",responseObject]);
             }
         }
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         if (fail) {
             fail([NSString stringWithFormat:@"上传出错,%@",error.localizedDescription]);
         }
         NSLog(@"上传错误%@",error);
     }];
}

#pragma mark - 设置AFN请求头
+ (void)setAfnHTTPHeader:(AFHTTPRequestSerializer *)requestSerializer
{
    __block AFHTTPRequestSerializer *rs = requestSerializer;
    NSMutableDictionary *header = [YKManager sharedManager].requestHeaderDic;
    
//    header[@"host"] = [originUrl stringByReplacingOccurrencesOfString:@"http://" withString:@""];//使用httpdns服务
    
    if (![self strNilOrEmpty:[YKManager sharedManager].originToken])//token不为空
    {
        NSLog(@"%@",[YKManager sharedManager].originToken);
        header[@"t"] = [YKManager sharedManager].time = [YKManager getTime];
        header[@"uid"] = [YKManager sharedManager].uid;
        header[@"token"] = encodeToken([YKManager sharedManager].originToken,
                                       [YKManager sharedManager].time);
    }
    else//token为空
    {
        if ([YKManager sharedManager].didLogin == NO)//   未登录
        {
            if ([YKManager sharedManager].time==nil) {
                header[@"t"] = [YKManager getTime];
            }else{
                header[@"t"] = [YKManager sharedManager].time;
            }
        }
        else//  已登录
        {
            [YKManager sharedManager].time = [YKManager getTime];
            header[@"t"] = [YKManager sharedManager].time;
        }
    }

    //NSLog(@"header=%@",header);
    
    [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [rs setValue:obj forHTTPHeaderField:key];
    }];
}

#pragma mark - 默认请求参数
+ (NSMutableDictionary *)getDefaultParams{
    NSMutableDictionary *defaultParams = [[NSMutableDictionary alloc]init];
    //defaultParams[@"abc"] = @"efg";
    
    return defaultParams;
}

+ (NSDictionary *)setupBaseInfoWithManager:(AFHTTPSessionManager *)manager paraDic:(NSDictionary *)paraDic
{
    //设置公共参数
    NSString *timeStemp = kTimeStamp;
    
    NSMutableString *paraStr = [NSMutableString stringWithFormat:@"data=%@&",[LLUtils jsonStrWithJSONObject:paraDic[@"data"]]];
    
//    NSString *pa = [NSString stringWithFormat:@"%@",paraDic];
    
    [paraStr appendFormat:@"ipAddress=%@&",KiPAddress];
    
    [paraStr appendFormat:@"platform=%@&",kPlatform];
    
    [paraStr appendFormat:@"timestamp=%@&",timeStemp];
    
    [paraStr appendFormat:@"version=%@",kAppVersion];
    
//    NSString * encodeString =  [LLUtils encodeURIComponent:paraStr];
    
    NSString *sign = [[LLUtils encodeURIComponent:paraStr] md5];
    
    NSMutableDictionary *mutPara = [paraDic mutableCopy];
    
    [mutPara setValue:sign forKey:@"sign"];
    [mutPara setValue:kAppVersion forKey:@"version"];
    [mutPara setValue:kPlatform forKey:@"platform"];
    [mutPara setValue:KiPAddress forKey:@"ipAddress"];
    [mutPara setValue:timeStemp forKey:@"timestamp"];
    return mutPara;
    
    
}

@end
