//
//  HomeNoticeCell.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/5.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKNoticModel.h"

typedef void(^noticCallBack)(NSString *messId);
@interface HomeNoticeCell : UITableViewCell
@property (nonatomic,copy)NSArray *notics;//消息列表
@property (nonatomic,copy)noticCallBack noticCallBack;

- (void)doAnimation;
@end
