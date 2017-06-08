//
//  MsgNoticCell.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/11.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "MsgNoticCell.h"

@interface MsgNoticCell ()
@property (weak, nonatomic) IBOutlet UILabel *jusSeLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end

@implementation MsgNoticCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(MsgNoticModel *)model
{
    _model = model;
    
    _jusSeLab.text = _model.rule;
    _phoneLab.text = _model.phone;
    _nameLab.text = _model.person;
    _idStr = _model.idStr;
    
}

- (IBAction)shanchuClick:(UIButton *)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if (_editUserInfo) {
        _editUserInfo(btn.tag);
    }
}


@end
