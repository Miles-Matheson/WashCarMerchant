//
//  MineDealViewCell.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/5.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "MineDealViewCell.h"

@implementation MineDealViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)dealClick:(UIButton *)sender {
    if (_dealCallBack) {
        _dealCallBack(sender);
    }
}


@end
