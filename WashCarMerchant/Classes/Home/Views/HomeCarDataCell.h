//
//  HomeCarDataCell.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/5.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeMainModel.h"

typedef void(^changeDayData)(NSInteger selectedIndex );
@interface HomeCarDataCell : UITableViewCell
@property (nonatomic,strong)HomeMainModel *model;

@property(nonatomic,copy)changeDayData changeDayDataCallBack;
@end
