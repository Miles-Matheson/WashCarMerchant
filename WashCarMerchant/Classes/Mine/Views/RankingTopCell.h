//
//  RankingTopCell.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/24.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^dengJiClick)(void);
@interface RankingTopCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *dengjiLab;

@property (weak, nonatomic) IBOutlet UILabel *cehngzahngzhiLab;
@property (weak, nonatomic) IBOutlet UILabel *bottomLab;
@property (nonatomic,copy)dengJiClick dengJiClick;

@end
