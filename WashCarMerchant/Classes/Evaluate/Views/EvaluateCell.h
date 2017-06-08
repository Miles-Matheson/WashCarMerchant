//
//  EvaluateCell.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/8.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EvaluateModel.h"
typedef void(^OperationCallBack)(EvaluateModel *model);
@interface EvaluateCell : UITableViewCell

@property (nonatomic,strong)EvaluateModel *model;
@property (nonatomic,copy)OperationCallBack operationCallBack;
@end
