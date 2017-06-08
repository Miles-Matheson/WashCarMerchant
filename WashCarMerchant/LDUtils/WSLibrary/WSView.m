//
//  WSButton.m
//  WiseSellerReport
//
//  Created by jienliang on 15-2-5.
//  Copyright (c) 2015年 jienliang. All rights reserved.
//

#import "WSView.h"

@implementation WSLabel
- (instancetype)init
{
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture)];
        [self addGestureRecognizer:_tap];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture)];
        [self addGestureRecognizer:_tap];
        
        _longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGesture:)];
        [self addGestureRecognizer:_longPress];
    }
    
    return self;
}

- (void)tapGesture
{
    if (self.onTap) {
        self.onTap();
    }
}

- (void)longPressGesture:(UILongPressGestureRecognizer *)longPress
{
    if (self.onLongPress) {
        self.onLongPress(longPress);
    }
}

@end



@implementation WSView
- (instancetype)init
{
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)tapGesture
{
    if (self.onTap) {
        self.onTap();
    }
}
@end

@implementation WSImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)tapGesture
{
    if (self.onTap) {
        self.onTap();
    }
}
@end

@implementation WSButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addTarget:self action:@selector(btnPress) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self addTarget:self action:@selector(btnPress) forControlEvents:UIControlEventTouchUpInside];
    }

    return self;
}
- (void)btnPress
{
    if (self.onClick) {
        self.onClick();
    }
}
@end

@implementation WSBarButtonItem
@end

@implementation WSLongPressGestureRecognizer
@end

@implementation WSActionSheet
@end

@implementation WSAlertView
@end
