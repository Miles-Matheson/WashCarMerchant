//
//  ReplyModel.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/9.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "ReplyModel.h"

@implementation ReplyModel

+(NSDictionary*)mj_replacedKeyFromPropertyName  {
    return @{@"idStr":@"id",
             @"nowPrice":@"newPrice",
             };
}

@end
