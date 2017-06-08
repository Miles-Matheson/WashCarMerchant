//
//  YKPayDetailHeader.h
//  MerchantCenter
//
//  Created by kevin on 2017/3/4.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YKPayDetailHeader;

@protocol YKPayDetailHeaderDelegate <NSObject>

- (void)YKPayDetailHeader:(YKPayDetailHeader *)header clickRightBtn:(UIButton *)rightBtn;

@end

@interface YKPayDetailHeader : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLabTopCons;

@property (weak, nonatomic) IBOutlet UILabel *topLbl;
@property (weak, nonatomic) IBOutlet UILabel *bottomLbl;

@property (nonatomic, assign) id <YKPayDetailHeaderDelegate> delegate;

@end
