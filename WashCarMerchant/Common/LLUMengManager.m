//
//  LLUMengManager.m
//  StoreIntegral
//
//  Created by kevin on 2017/1/6.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import "LLUMengManager.h"
#import "LLUtils.h"

@implementation LLUMengManager

+ (instancetype)sharedInstance
{
    static LLUMengManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)initUMmanger {
    /* 打开调试日志 */
    //    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"58f431bfaed1794a0c001a1b"];
    
    [self configUSharePlatforms];
    
    //    [self confitUShareSettings];
}

- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxd369e8598326d281" appSecret:@"74422d645cb44f29e1c212c3d155b371" redirectURL:@"http://mobile.umeng.com/social"];
    
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"101359245"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"23933795"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}


/**
 显示分享面板
 */
- (void)showShareMenuView:(NSString *)title content:(NSString *)content img:(id)img redirectURL:(NSString *)redirectURL CompletionHandler:(ShareSuccessCallback)successCallback{
    
//    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [self share:title content:content img:img redirectURL:redirectURL platformType:platformType CompletionHandler:^(BOOL isSuccess) {
            successCallback(isSuccess);
        }] ;
    }];
    
    
}

/**
  分享
 */
- (void)share:(NSString *)title content:(NSString *)content img:(id)img redirectURL:(NSString *)redirectURL platformType:(UMSocialPlatformType)platformType CompletionHandler:(ShareSuccessCallback)successCallback{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:content thumImage:img];
    //设置网页地址
    shareObject.webpageUrl = redirectURL;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[LLUtils getCurrentVC] completion:^(id data, NSError *error) {
        if (!error) {
            [LLUtils showSuccessHudWithStatus:@"分享成功"];
            successCallback(YES);
        } else {
            [LLUtils showErrorHudWithStatus:@"分享失败"];
            successCallback(NO);
        }
    }];
}

- (void)shareWithContent:(NSString *)content platformType:(UMSocialPlatformType)platformType{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.text = content;
    
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[LLUtils getCurrentVC] completion:^(id data, NSError *error) {
        if (!error) {
            [LLUtils showSuccessHudWithStatus:@"分享成功"];
        } else {
            [LLUtils showErrorHudWithStatus:@"分享失败"];
        }
    }];
}

/**
 第三方授权登录
 */
- (void)getAuthWithUserInfo:(UMSocialPlatformType)platform callback:(ThirdPartLoginCallback)callback{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platform currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            if (callback) {
                callback(NO,nil);
            }
        } else {
            UMSocialUserInfoResponse *resp = result;
            if (callback) {
                callback(YES,resp);
            }
//            // 授权信息
//            NSLog(@"Sina uid: %@", resp.uid);
//            NSLog(@"Sina accessToken: %@", resp.accessToken);
//            NSLog(@"Sina refreshToken: %@", resp.refreshToken);
//            NSLog(@"Sina expiration: %@", resp.expiration);
//            
//            // 用户信息
//            NSLog(@"Sina name: %@", resp.name);
//            NSLog(@"Sina iconurl: %@", resp.iconurl);
//            NSLog(@"Sina gender: %@", resp.gender);
//            
//            // 第三方平台SDK源数据
//            NSLog(@"Sina originalResponse: %@", resp.originalResponse);
        }
    }];
}

@end
