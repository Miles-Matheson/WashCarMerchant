//
//  EvaluateModel.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/23.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EvaluateModel : NSObject

@property (nonatomic,copy)NSString *content;//回复内容
@property (nonatomic,copy)NSString *idStr;//id
@property (nonatomic,assign)BOOL isRecall;//1已回复
@property (nonatomic,copy)NSString *serviceName;//服务名称
@property (nonatomic,copy)NSString *createDate;//创建时间
@property (nonatomic,copy)NSString *fhContent;//回复内容
@end
