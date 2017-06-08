//
//  UIView+LLToast.h
//  MerchantCenter
//
//  Created by kevin on 2017/2/27.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LLToast)

/**
 在页面底部显示Toast
 */
- (void) addBottomToastWithString:(NSString *)toast;
- (void) addTopToastWithString:(NSString *)string;
- (void)showCenterToast:(NSString *)string;
@end
