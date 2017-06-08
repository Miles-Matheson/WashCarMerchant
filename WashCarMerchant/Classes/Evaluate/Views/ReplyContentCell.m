//
//  ReplyContentCell.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/9.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "ReplyContentCell.h"

@interface ReplyContentCell ()
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;


@end

@implementation ReplyContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
     self.imgView.image = [self.imgView.image resizableImageWithCapInsets:UIEdgeInsetsMake(30, 0, 30, 0) resizingMode:UIImageResizingModeStretch];
}


@end
