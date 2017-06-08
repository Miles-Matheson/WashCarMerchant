//
//  EvaluateDetailCell.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/8.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReplyModel.h"

@interface EvaluateDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *washTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UIImageView *carLogoImgview;
@property (weak, nonatomic) IBOutlet UILabel *carName;

@property (weak, nonatomic) IBOutlet UILabel *carNumberLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (nonatomic,strong)NSArray *images;
@property (nonatomic,assign)NSInteger star;
@end
