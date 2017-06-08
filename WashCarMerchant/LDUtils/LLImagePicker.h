//
//  LLImagePicker.h
//  StoreIntegral
//
//  Created by kevin on 2017/1/14.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

typedef void(^LLImagePickerCompletionBlock)(BOOL isSuccess,UIImage *originImg,UIImage *editedImg);

#import <Foundation/Foundation.h>

@interface LLImagePicker : NSObject

singletonInterface(LLImagePicker)

- (void)showInView:(UIView *)view completion:(LLImagePickerCompletionBlock)completion;

@end
