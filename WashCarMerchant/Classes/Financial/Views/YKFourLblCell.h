//
//  YKFourLblCell.h
//  MerchantCenter
//
//  Created by kevin on 2017/2/24.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FinancialModel.h"
@interface YKFourLblCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UILabel *lbl3;
@property (weak, nonatomic) IBOutlet UILabel *lbl4;

@property (nonatomic,copy)FinancialModel *model;

@end
