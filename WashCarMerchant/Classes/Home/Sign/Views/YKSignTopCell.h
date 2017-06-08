//
//  YKSignTopCell.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/22.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^blockClick)(BOOL);
@interface YKSignTopCell : UITableViewCell
@property (nonatomic,copy)blockClick signCallBack;
@property (nonatomic,copy)blockClick switchCallBack;
@property (nonatomic,copy)blockClick signDetailCallBack;
@property (nonatomic,assign)int signDayNum;
@property (nonatomic,assign)BOOL signType;
@property (nonatomic,assign)BOOL signSwitch;
@end
