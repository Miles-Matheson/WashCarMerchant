//
//  LoginBtnCell.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/10.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^loginCallBack)(void);
@interface LoginBtnCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic,copy)loginCallBack  loginCallBack;

@end
