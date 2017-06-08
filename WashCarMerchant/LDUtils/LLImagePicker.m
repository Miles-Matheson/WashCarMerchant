//
//  LLImagePicker.m
//  StoreIntegral
//
//  Created by kevin on 2017/1/14.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import "LLImagePicker.h"

@interface LLImagePicker () <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property (nonatomic, copy) LLImagePickerCompletionBlock completion;

@end

@implementation LLImagePicker

singletonImplementation(LLImagePicker)

- (void)showInView:(UIView *)view completion:(LLImagePickerCompletionBlock)completion{
    if (completion) {
        _completion = completion;
    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"上传头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    actionSheet.tag = 1000;
    [actionSheet showInView:view];
}

#pragma mark - UIActionSheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1000) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    //来源:相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    //来源:相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
            }
        }
        else
        {
            if (buttonIndex == 2) {
                return;
            }
            else
            {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [[LLUtils getCurrentVC] presentViewController:imagePickerController animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *originImg = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *editedImg = [info objectForKey:UIImagePickerControllerEditedImage];
    if (_completion) {
        _completion(YES,originImg,editedImg);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (_completion) {
        _completion(NO,nil,nil);
    }
}

@end
