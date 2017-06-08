//
//  FinancialModel.h
//  WashCarMerchant
//
//  Created by 青盲半夏 on 2017/6/1.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FinancialModel : NSObject

@property (nonatomic,copy)NSString*idStr;//提款id
@property (nonatomic,copy)NSString*createDate;
@property (nonatomic,copy)NSString*zdNm;//账单编号
@property (nonatomic,copy)NSString*jsType;//结算类型0：自提1：周期
@property (nonatomic,copy)NSString*amt;//结算金额
@property (nonatomic,copy)NSString*creattime;//账单时间
@property (nonatomic,copy)NSString*userId;//用户id
@property (nonatomic,copy)NSString*stat;//审核状态 0待审核 1已拒绝 2已通过
@property (nonatomic,copy)NSString*shopName;//车行名称
@end
