//
//  LLUMengManager.h
//  StoreIntegral
//
//  Created by kevin on 2017/1/6.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UShareUI/UShareUI.h>
#import <UMSocialCore/UMSocialCore.h>

typedef void(^ThirdPartLoginCallback)(BOOL isSuccess,UMSocialUserInfoResponse *resp);
typedef void(^ShareSuccessCallback)(BOOL isSuccess);

@interface LLUMengManager : NSObject

+ (instancetype)sharedInstance;

/**
 初始化友盟
 */
- (void)initUMmanger;

/**
 显示友盟分享面板
 */
- (void)showShareMenuView:(NSString *)title content:(NSString *)content img:(id)img redirectURL:(NSString *)redirectURL CompletionHandler:(ShareSuccessCallback)successCallback;

/**
 分享
 */
- (void)share:(NSString *)title content:(NSString *)content img:(id)img redirectURL:(NSString *)redirectURL platformType:(UMSocialPlatformType)platformType CompletionHandler:(ShareSuccessCallback)successCallback;

- (void)shareWithContent:(NSString *)content platformType:(UMSocialPlatformType)platformType;

/**
 第三方授权登录
 */
- (void)getAuthWithUserInfo:(UMSocialPlatformType)platform callback:(ThirdPartLoginCallback)callback;

@end
