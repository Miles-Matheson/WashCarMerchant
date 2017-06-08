//
//  ReplyModel.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/9.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReplyModel : NSObject

@property (nonatomic,copy)NSString *serviceNm;//”服务名”
@property (nonatomic,copy)NSString *serviceType;//”服务类型”,
@property (nonatomic,copy)NSDictionary *commentDetail;//内容
@property (nonatomic,copy)NSString *nowPrice;//”优惠价”,
@property (nonatomic,copy)NSString *oldPrice;//”市场价”,
//@property (nonatomic,copy)NSString *name;
//@property (nonatomic,copy)NSString *name;
//@property (nonatomic,copy)NSString *name;
//@property (nonatomic,copy)NSString *name;
//@property (nonatomic,copy)NSString *name;






//{
//    ”code”: ”10000”,
//    ”serviceNm”: ”服务名”,
//    ”serviceType”: ”服务类型”,
//    ”newPrice”: ”优惠价”,
//    ”oldPrice”: ”市场价”,
//    ”commentDetail”: {
//        ”content”: ”评论内容”,
//        ”fhContent”: ”商家回复内容”,
//        ”score”: ”评分”,
//        ”createDate”: ”评论时间”,
//        ”img”: ”评论图片”,
//        ”isRecall”: ”商家是否回复”
//    }



@end
