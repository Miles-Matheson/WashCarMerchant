//
//  ReplyCell.h
//  WashCarMerchant
//
//  Created by Miles on 2017/5/8.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^sendCallBack)(NSString *string);
@interface ReplyCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *pleaceHolderLab;
@property (nonatomic,copy)sendCallBack sendCallBack;
@end
