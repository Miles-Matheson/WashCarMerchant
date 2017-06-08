//
//  OrderDetailTopCell.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/13.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailTopCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nowPrice;
@property (weak, nonatomic) IBOutlet UILabel *oldPirce;
@property (weak, nonatomic) IBOutlet UILabel *carNumberLab;
@property (weak, nonatomic) IBOutlet UILabel *washCarAddLab;

@property (weak, nonatomic) IBOutlet UIButton *LefTlawBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightlawBtn;

@property (nonatomic,copy)NSString * userMobile;

@property (weak, nonatomic) IBOutlet UIButton *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *washName;

@end
