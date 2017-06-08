//
//  MsgNoticCell.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/11.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgNoticModel.h"

/*
 tag 10 删除    20编辑
 */
typedef void(^editUserInfo)(NSInteger tag);

@interface MsgNoticCell : UITableViewCell
@property (nonatomic,copy)NSString *idStr;
@property (nonatomic,copy)MsgNoticModel *model;
@property (nonatomic,copy)editUserInfo editUserInfo;

@end
