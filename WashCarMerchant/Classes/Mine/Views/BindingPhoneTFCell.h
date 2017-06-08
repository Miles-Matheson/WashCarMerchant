//
//  BindingPhoneTFCell.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/13.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^inputCallBack)(UITextField *textField);


@interface BindingPhoneTFCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UITextField *TF;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (nonatomic,copy)inputCallBack inputCallBack;

@property (nonatomic,assign)float mixLength;//最小数值
@property (nonatomic,assign)float maxLength;//最最大数值
@end
