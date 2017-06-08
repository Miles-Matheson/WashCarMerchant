//
//  OrderDetailListCell.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/15.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNumLab;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLab;

@property (weak, nonatomic) IBOutlet UILabel *phoneNumLab;
@property (weak, nonatomic) IBOutlet UILabel *quanLab;
@property (weak, nonatomic) IBOutlet UILabel *waitPayLab;
@property (weak, nonatomic) IBOutlet UILabel *realPayLab;

@end
