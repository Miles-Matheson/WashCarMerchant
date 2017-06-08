//
//  MessageCell.h
//  WashCarMerchant
//
//  Created by 青盲半夏 on 2017/6/8.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MsgTypeOrder = 0,
    MsgTypeNews,
    MsgTypeNotice,
} MessageType;

@interface MessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (nonatomic,assign)NSInteger noReadCount;


@property (nonatomic,assign) MessageType MessageType;

@end
