//
//  RankingTopCell.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/24.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "RankingTopCell.h"

@implementation RankingTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)dengjiClick:(id)sender {
    
    if (self.dengJiClick) {
        self.dengJiClick();
    }
}


@end
