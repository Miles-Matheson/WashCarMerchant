//
//  MinePactCell.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/5.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^pactClickCallBack)(UIButton *buttton);
@interface MinePactCell : UITableViewCell
@property (nonatomic,copy)pactClickCallBack pactCallBack;
@end
