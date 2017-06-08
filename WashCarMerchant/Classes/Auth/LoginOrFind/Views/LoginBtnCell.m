//
//  LoginBtnCell.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/10.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LoginBtnCell.h"

@implementation LoginBtnCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)loginClick:(id)sender {
    
    if (_loginCallBack) {
        _loginCallBack ();
    }
}

@end
