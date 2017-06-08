//
//  ReplyCell.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/8.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "ReplyCell.h"

@interface ReplyCell ()<UITextViewDelegate>



@end

@implementation ReplyCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
//    _pleaceHolderLab = [[UILabel alloc] initWithFrame:CGRectMake(8, 6, 200, 20)];
//    textViewPlaceholderLabel.text = @"留言内容需输入8--80字符";
//    textViewPlaceholderLabel.textColor = [UIColor grayColor];
//    textViewPlaceholderLabel.font = kFont14;
//    _textView.layer.borderWidth = 0.5;
//    _textView.layer.borderColor = [UIColor grayColor].CGColor;
//    [_textView addSubview: textViewPlaceholderLabel];
    _textView.delegate   =self;
}

- (IBAction)sentBtn:(id)sender {
    ws(bself);
    
    if (_sendCallBack) {
        _sendCallBack (bself.textView.text);
    }
}

//设置textView的placeholder
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //[text isEqualToString:@""] 表示输入的是退格键
    if ([text length] > 0)
    {
        _pleaceHolderLab.hidden = YES;
    }else if ([textView.text length] == 1 && [text isEqualToString:@""]){
        _pleaceHolderLab.hidden = NO;
    }
    if([text rangeOfString:@"\n"].location !=NSNotFound)//_roaldSearchText
    {
        [self.contentView endEditing:YES];
    }
    else
    {
        NSLog(@"no");
    }
    
    
    NSString * toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
//    if (toBeString.length > 80 && range.length!=1){
//        
//        _textView.text = [toBeString substringToIndex:80];
//        
//        return NO;
//    }
    
    return YES;
    
    
}


@end
