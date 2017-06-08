//
//  BindingPhoneTFCell.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/13.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "BindingPhoneTFCell.h"

@interface BindingPhoneTFCell ()<UITextFieldDelegate>



@end


@implementation BindingPhoneTFCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _TF.delegate = self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (_inputCallBack) {
        _inputCallBack(textField);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

//设置textView的placeholder
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string rangeOfString:@"\n"].location !=NSNotFound)//_roaldSearchText
    {
        [textField resignFirstResponder];
    }

     NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (_maxLength) {

        if([textField.text rangeOfString:@"."].location !=NSNotFound && [string rangeOfString:@"."].location !=NSNotFound){//_roaldSearchText
            
            return NO;
            
        }else if ([toBeString floatValue] > _maxLength && range.length!=1){

            return NO;
        }else{

        }
    }
    
    return YES;
}

- (void)dealloc
{
    NSLog(@"DEALLOC");
}
@end
