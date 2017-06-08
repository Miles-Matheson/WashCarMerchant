//
//  YKLeftLblRightTFCell.h
//  Message
//
//  Created by kevin on 2017/2/6.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YKLeftLblRightTFCell;

@protocol YKLeftLblRightTFCellDelegate <NSObject>

@optional
- (void)YKLeftLblRightTFCell:(YKLeftLblRightTFCell *)cell editingChanged:(UITextField *)textFiled;
- (void)YKLeftLblRightTFCell:(YKLeftLblRightTFCell *)cell clickRightBtn:(UIButton *)rightBtn;

@end

@interface YKLeftLblRightTFCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *leftLbl;
@property (weak, nonatomic) IBOutlet UITextField *rightTF;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineLeftContraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLblLeftContraints;

@property (nonatomic,assign) id <YKLeftLblRightTFCellDelegate> delegate;
@property (nonatomic,strong) NSIndexPath *indexPath;

- (void)startCountdown;
@end
