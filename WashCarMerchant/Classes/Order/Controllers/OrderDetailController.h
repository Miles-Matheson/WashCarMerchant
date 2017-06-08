//
//  OrderDetailController.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/13.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderDetailController : BaseViewController

@property (nonatomic,assign)int orderState;
@property (nonatomic,copy)NSString *orderId;

@end
