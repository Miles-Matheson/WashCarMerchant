//
//  MineDealViewCell.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/5.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^dealClickCallBack)(UIButton *buttton);

@interface MineDealViewCell : UITableViewCell

@property (nonatomic,copy)dealClickCallBack dealCallBack;

@end
