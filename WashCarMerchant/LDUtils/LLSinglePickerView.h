//
//  LLSinglePickerView.h
//  StoreIntegral
//
//  Created by kevin on 2017/1/20.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SinglePickerCompletion)(NSString *selIndex,NSString *selectStr);

@interface LLSinglePickerView : UIView

+ (void)show:(NSDictionary *)attributes callback:(SinglePickerCompletion)completion;

@end
