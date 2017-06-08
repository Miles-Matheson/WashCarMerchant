//
//  WSButton.h
//  WiseSellerReport
//
//  Created by jienliang on 15-2-5.
//  Copyright (c) 2015年 jienliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSView : UIView
@property (nonatomic,copy) id userInfo;
@property (nonatomic,copy) void (^onTap)(void);
- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;
@end

@interface WSLabel : UILabel
@property (nonatomic,copy) id userInfo;
@property (nonatomic,copy) UITapGestureRecognizer *tap;
@property (nonatomic,copy) UILongPressGestureRecognizer *longPress;
@property (nonatomic,copy) void (^onTap)(void);
@property (nonatomic,copy) void (^onLongPress)(UILongPressGestureRecognizer *longPress);
- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;
@end

@interface WSImageView : UIImageView
@property (nonatomic,copy) id userInfo;
@property (nonatomic,copy) void (^onTap)(void);
- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;
@end

@interface WSButton : UIButton
@property (nonatomic,strong) id userInfo;
@property (nonatomic,copy) void (^onClick)(void);
- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;
@end

@interface WSBarButtonItem : UIBarButtonItem
@property (nonatomic,copy) id userInfo;
@property (nonatomic,copy) void (^onClick)(void);
@end

@interface WSLongPressGestureRecognizer : UILongPressGestureRecognizer
@property (nonatomic,copy) id userInfo;
@property (nonatomic,assign) int tag;
@end

@interface WSActionSheet : UIActionSheet
@property (copy, readwrite, nonatomic) void (^onClick)(int index);
@end

@interface WSAlertView : UIAlertView
@property (nonatomic,copy) id userInfo;
@property (copy, readwrite, nonatomic) void (^onClick)(int index);

@end

