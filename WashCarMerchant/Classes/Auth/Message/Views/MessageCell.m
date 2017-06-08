//
//  MessageCell.m
//  WashCarMerchant
//
//  Created by 青盲半夏 on 2017/6/8.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "MessageCell.h"

@interface MessageCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@end

@implementation MessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setMessageType:(MessageType)MessageType
{
    _MessageType = MessageType;
    
    if (_MessageType == MsgTypeOrder) {
        _titleLab.text = @"订单消息";
        _iconImageView.image = [UIImage imageNamed:@"center_dd"];
        
    }else if (_MessageType == MsgTypeNews){
        _titleLab.text = @"通知消息";
        _iconImageView.image = [UIImage imageNamed:@"center_tz"];
    }else if (_MessageType == MsgTypeNotice){
        _titleLab.text = @"公告";
        _iconImageView.image = [UIImage imageNamed:@"center_gg"];
    }
}


- (void)setNoReadCount:(NSInteger)noReadCount
{
    _noReadCount = noReadCount;
    
    if (_noReadCount == 0) {
        return;
    }
    
    UILabel *noReadLab =  [[UILabel alloc]init];
    
    noReadLab.text = [NSString stringWithFormat:@"%ld",_noReadCount];
    [noReadLab sizeToFit];
    
    
    noReadLab.bounds = CGRectMake(0, 0, 15, 15);
    noReadLab.right = _iconImageView.width +5;
    _iconImageView.tag = -3;
    noReadLab.layer.masksToBounds = YES;
    noReadLab.layer.cornerRadius = 15.0/2.0;
    
    [_iconImageView addSubview:noReadLab];
}
@end
