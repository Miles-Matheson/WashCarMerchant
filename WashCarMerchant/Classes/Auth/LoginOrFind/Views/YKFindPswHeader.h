//
//  YKFindPswHeader.h
//  MerchantCenter
//
//  Created by kevin on 2017/2/23.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,YKFindPswType) {
    YKFindPswTypeStepOne = 1,
    YKFindPswTypeStepTwo,
    YKFindPswTypeStepThree,
};

@interface YKFindPswHeader : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *stageImgView;

@property (nonatomic, assign) YKFindPswType type;

@end
