//
//  MerchantModel.m
//  WashCarMerchant
//
//  Created by 青盲半夏 on 2017/6/1.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "MerchantModel.h"

@implementation MerchantModel
+(NSDictionary*)mj_replacedKeyFromPropertyName  {
    return @{@"idStr":@"id",
             @"nowPrice":@"newPrice",
             };
}
@end
