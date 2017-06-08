//
//  YKPhoneLoninIndexCell.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/18.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "YKPhoneLoninIndexCell.h"

@implementation YKPhoneLoninIndexCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)btnClick:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    if (_logOrFindCallBack) {
        _logOrFindCallBack(btn.tag);
    }
}


@end
