//
//  OrderModel.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/25.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

+(NSDictionary*)mj_replacedKeyFromPropertyName  {
    return @{@"idStr":@"id",
             };
}
@end
