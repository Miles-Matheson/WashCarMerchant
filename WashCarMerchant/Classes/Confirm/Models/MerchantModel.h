//
//  MerchantModel.h
//  WashCarMerchant
//
//  Created by 青盲半夏 on 2017/6/1.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MerchantModel : NSObject

@property (nonatomic,copy)NSString * idStr;//车行服务类型id
@property (nonatomic,copy)NSString * isNewRecord;
@property (nonatomic,copy)NSString * createDate;
@property (nonatomic,copy)NSString * updateDate;
@property (nonatomic,copy)NSString * companyId;
@property (nonatomic,copy)NSString * carServiceId;//服务内容id
@property (nonatomic,copy)NSString * carshopId;//车行id
@property (nonatomic,copy)NSString * carLx;//车子类型0:轿车1：suv
@property (nonatomic,copy)NSString * ordPrice;//门市价
@property (nonatomic,copy)NSString * nowPrice;//优惠价
@property (nonatomic,copy)NSString * stat;//状态：0待确认 1已驳回 2已上线 3已下线
@property (nonatomic,copy)NSString * serviceName;//"法式按摩"	//服务内容

@end
