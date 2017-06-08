//
//  ConfirmCell.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/6.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MerchantModel.h"
typedef void(^caoZuoCallBack)(NSInteger tag);

@interface ConfirmCell : UITableViewCell
@property (nonatomic,copy)MerchantModel *model;
@property (nonatomic,copy)NSString *idStr;
@property (nonatomic,copy)caoZuoCallBack caozuoBack;

@end
