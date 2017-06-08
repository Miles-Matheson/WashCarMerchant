//
//  YKSubbranchModel.h
//  MerchantCenter
//
//  Created by kevin on 2017/2/22.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKSubbranchModel : NSObject

@property (nonatomic, strong) NSDictionary *subbranchDic;

//当前选中
@property (nonatomic, weak) NSDictionary *selDic;

//上一次选中
@property (nonatomic, weak) NSDictionary *lastSelDic;

@end
