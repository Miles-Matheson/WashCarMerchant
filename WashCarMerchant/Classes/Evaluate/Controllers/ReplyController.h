//
//  ReplyController.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/8.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "BaseViewController.h"

@interface ReplyController : BaseViewController
@property (nonatomic,copy)NSString *fhContent;
@property (nonatomic,copy)NSString *repleId;//回复id
@property (nonatomic,assign)BOOL isRecall;//是否已回复
@end
