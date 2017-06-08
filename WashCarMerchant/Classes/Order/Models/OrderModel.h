//
//  OrderModel.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/25.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property (nonatomic,copy)NSDate *createDate;
@property (nonatomic,copy)NSString *isNewRecord;
@property (nonatomic,copy)NSString *nick;
@property (nonatomic,copy)NSString *orderNum;
@property (nonatomic,copy)NSString *serviceName;
@property (nonatomic,copy)NSString *stat;
@property (nonatomic,copy)NSString *orderId;
@end
