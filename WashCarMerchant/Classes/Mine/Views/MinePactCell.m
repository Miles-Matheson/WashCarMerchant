//
//  MinePactCell.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/5.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "MinePactCell.h"

@implementation MinePactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)pactClick:(id)sender {
    
    if (_pactCallBack) {
        _pactCallBack(sender);
    }
}


@end
