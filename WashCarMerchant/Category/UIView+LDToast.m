//
//  UIView+LLToast.m
//  MerchantCenter
//
//  Created by kevin on 2017/2/27.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import "UIView+LDToast.h"


@implementation UIView (LLToast)
#define aiScreenWidth [UIScreen mainScreen].bounds.size.width
#define aiScreenHeight [UIScreen mainScreen].bounds.size.height
#define STATUS_BAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
#define NAVIGATION_BAR_HEIGHT self.navigationController.navigationBar.frame.size.height
#define TAB_BAR_HEIGHT self.tabBarController.tabBar.frame.size.height
/**
 在页面底部显示Toast
 */

- (void) addTopToastWithString:(NSString *)string {
    
    CGRect initRect = CGRectMake(0, STATUS_BAR_HEIGHT + 44, aiScreenWidth, 0);
    CGRect rect = CGRectMake(0, STATUS_BAR_HEIGHT + 44, aiScreenWidth, 22);
    UILabel* label = [[UILabel alloc] initWithFrame:initRect];
    label.text = string;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    label.backgroundColor = [UIColor colorWithRed:0 green:0.6 blue:0.9 alpha:0.6];
    
    [self addSubview:label];
    
    //弹出label
    [UIView animateWithDuration:0.5 animations:^{
        
        label.frame = rect;
        
    } completion:^ (BOOL finished){
        //弹出后持续1s
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(removeToastWithView:) userInfo:label repeats:NO];
    }];
}


- (void) removeCenterToastWithView:(NSTimer *)timer {
    
    UILabel* label = [timer userInfo];
    
    CGRect initRect = CGRectMake(0, STATUS_BAR_HEIGHT + 44, aiScreenWidth, 0);
    //    label消失
    [UIView animateWithDuration:0.2 animations:^{
        
        label.alpha = 0;
    } completion:^(BOOL finished){
        
        [label removeFromSuperview];
    }];
}

- (void) removeToastWithView:(NSTimer *)timer {
    
    UILabel* label = [timer userInfo];
    
    CGRect initRect = CGRectMake(0, STATUS_BAR_HEIGHT + 44, aiScreenWidth, 0);
    //    label消失
    [UIView animateWithDuration:0.5 animations:^{
        
        label.frame = initRect;
    } completion:^(BOOL finished){
        
        [label removeFromSuperview];
    }];
}

@end
