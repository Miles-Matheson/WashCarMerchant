//
//  YKNoticModel.h
//  WashCarMerchant
//
//  Created by 青盲半夏 on 2017/6/1.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKNoticModel : NSObject

@property (nonatomic,copy)NSString *idStr;//公告id
@property (nonatomic,assign)BOOL isNewRecord;
@property (nonatomic,copy)NSString *createDate;//公告创建时间
@property (nonatomic,copy)NSString *updateDate;//公告更新时间
@property (nonatomic,copy)NSString *companyId;
@property (nonatomic,copy)NSString *content;//公告内容
@property (nonatomic,copy)NSString *type;//type为1时代表是公告
@property (nonatomic,copy)NSString *stat;//0代表会员，1代表代理商


@end
