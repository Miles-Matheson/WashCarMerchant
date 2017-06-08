//
//  YKLeftLblRightTFCell.m
//  Message
//
//  Created by kevin on 2017/2/6.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import "YKLeftLblRightTFCell.h"

@interface YKLeftLblRightTFCell ()

@property (nonatomic,assign) NSInteger timerTotalSecond;    //定时总时间

@property (nonatomic,assign) CGFloat   timerInterval; //定时器时间间隔

@property (nonatomic,copy)  NSString *captchaBtnTitle;

@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,assign) NSInteger lastSecond;

@end

@implementation YKLeftLblRightTFCell

- (void)awakeFromNib {
    [super awakeFromNib];

    //设置定时初始值
    _timerInterval = 1.0f;
    _timerTotalSecond = 60;
    _captchaBtnTitle = @"获取验证码";
}

- (IBAction)editingChanged:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(YKLeftLblRightTFCell:editingChanged:)]) {
        [_delegate YKLeftLblRightTFCell:self editingChanged:sender];
    }
}

- (IBAction)editingDidEnd:(id)sender {
    [self editingChanged:sender];
}


- (IBAction)clickRightBtn:(id)sender {
//    [self startCountdown];
    if (_delegate && [_delegate respondsToSelector:@selector(YKLeftLblRightTFCell:clickRightBtn:)]) {
        [_delegate YKLeftLblRightTFCell:self clickRightBtn:sender];
    }
}

//开始倒计时
- (void)startCountdown
{
    _rightBtn.userInteractionEnabled = NO;
    _lastSecond = _timerTotalSecond;
    
    [_rightBtn setTitle:[NSString stringWithFormat:@"%lds",_lastSecond] forState:UIControlStateNormal];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:_timerInterval target:self selector:@selector(tiemrHandle:) userInfo:nil repeats:YES];
}

//停止倒计时
- (void)stopCountdown
{
    //重置按钮title
    [_rightBtn setTitle:_captchaBtnTitle forState:UIControlStateNormal];
    //设置按钮可以交互
    _rightBtn.userInteractionEnabled = YES;
    //废弃定时器，并指针置空
    [_timer invalidate] , _timer = nil;
}

- (void)tiemrHandle:(NSTimer *)timer
{
    if (_lastSecond==0) {
        [timer invalidate];
        _rightBtn.userInteractionEnabled = YES;
        [_rightBtn setTitle:_captchaBtnTitle forState:UIControlStateNormal];
        return ;
    }
    [_rightBtn setTitle:[NSString stringWithFormat:@"%lds",--_lastSecond] forState:UIControlStateNormal];
}

@end
