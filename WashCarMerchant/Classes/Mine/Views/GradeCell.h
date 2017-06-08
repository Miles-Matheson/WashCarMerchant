//
//  GradeCell.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/24.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *progressBgLbl;
@property (strong, nonatomic)  UILabel *progressLab;
@property (copy, nonatomic)  NSArray *titleArray;
@property (nonatomic,assign)CGFloat progress;

- (void)setUI;
@end
