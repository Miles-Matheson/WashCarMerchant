//
//  HomeTopBarCell.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/4.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "HomeTopBarCell.h"

@implementation HomeTopBarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)topClick:(UIButton *)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if (_topCallBack) {
        _topCallBack(btn);
    }
}

- (void)setModel:(HomeMainModel *)model
{
    _model = model;
}
@end
