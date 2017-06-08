//
//  HomeTopBarCell.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/4.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeMainModel.h"
typedef void(^topClickCallBack)(UIButton *buttton);

@interface HomeTopBarCell : UITableViewCell
@property (nonatomic,strong)HomeMainModel *model;
@property (nonatomic,copy)topClickCallBack topCallBack;
@end
