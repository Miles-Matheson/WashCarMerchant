//
//  OrderDetailTopCell.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/13.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "OrderDetailTopCell.h"

@implementation OrderDetailTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)callPhoneClick:(id)sender {
    
    [LLUtils callPhoneWithPhone:self.userMobile];
}

@end
