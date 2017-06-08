//
//  YKPhoneLoninIndexCell.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/18.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^logOrFindCallBack)(NSInteger tag);

@interface YKPhoneLoninIndexCell : UITableViewCell
@property (nonatomic,copy)logOrFindCallBack logOrFindCallBack;
@end
