//
//  YKPayDetailHeader.m
//  MerchantCenter
//
//  Created by kevin on 2017/3/4.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import "YKPayDetailHeader.h"

@implementation YKPayDetailHeader

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (IBAction)clickRightBtn:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(YKPayDetailHeader:clickRightBtn:)]) {
        [_delegate YKPayDetailHeader:self clickRightBtn:sender];
    }
}

@end
