//
//  YKAdView.m
//  MurphysLaw
//
//  Created by Miles on 2017/4/27.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import "YKAdView.h"

@interface YKAdView ()

@property (nonatomic, copy) ClickImgCallback callback;

@property (nonatomic, copy) NSString *imgUrlPath;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSUInteger removeTime;


@end

@implementation YKAdView

+ (void)showAdView:(ClickImgCallback)callback superView:(UIView *)supView imgUrlPath:(NSString *)imgUrlPath removeTime:(NSUInteger)removeTime{
    NSArray *viewArr = [[NSBundle mainBundle] loadNibNamed:@"YKAdView" owner:nil options:nil];
    if (viewArr.count) {
        YKAdView *adView = viewArr[0];
        [supView addSubview:adView];
        [adView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        adView.callback = callback;
        adView.imgUrlPath = imgUrlPath;
        adView.removeTime = removeTime;
    }
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [_imgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImgView:)]];
}

- (void)setImgUrlPath:(NSString *)imgUrlPath{
    if(_imgUrlPath != imgUrlPath) {

        _imgView.image = [UIImage imageWithContentsOfFile:imgUrlPath];
        if (!_timer) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerHandle) userInfo:nil repeats:YES];

        }
    }
}

- (void)timerHandle{
    if (_removeTime == 0) {
        [_timer invalidate],_timer=nil;
        
        [self removeFromSuperview];
    } else {
        _removeTime --;
    
    }
//    [_cutdownBtn setTitle:[NSString stringWithFormat:@"%lds",_removeTime] forState:UIControlStateNormal];
}

- (void)clickImgView:(UIImageView *)imgView{
    if (_callback) {
        _callback(@"");
    }
}

- (IBAction)removeFromeSubView:(id)sender {
    
    
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    if (btn.selected) {
        
        [self removeFromSuperview];
    }
}


@end
