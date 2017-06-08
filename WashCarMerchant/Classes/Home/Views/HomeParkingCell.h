//
//  HomeParkingCell.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/5.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeMainModel.h"


typedef void(^detaleCallCack)(HomeMainModel *model);

@interface HomeParkingCell : UITableViewCell
@property (nonatomic,copy)detaleCallCack detaleCallCack;
@property (nonatomic,strong)HomeMainModel *model;

@end
