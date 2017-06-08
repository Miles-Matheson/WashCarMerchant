//
//  HomeNotiCell.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/5.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeMainModel.h"

@interface HomeNotiCell : UITableViewCell
@property (nonatomic,strong)HomeMainModel *model;

@property (weak, nonatomic) IBOutlet UILabel *notiTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *notiContentLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

- (void)setLineStatus:(BOOL)isOutLine;
- (void)setUI;
@end
