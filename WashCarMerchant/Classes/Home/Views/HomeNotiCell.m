//
//  HomeNotiCell.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/5.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "HomeNotiCell.h"

@interface HomeNotiCell ()


@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)int downTime;


@end

@implementation HomeNotiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _notiTitleLab.frame = CGRectMake(_notiTitleLab.left, _notiTitleLab.top, 0, _notiTitleLab.height);
}

- (void)setLineStatus:(BOOL)isOutLine
{
    
    CGSize size = [LLUtils getStringSize:_notiTitleLab.text font:14 width:kScreenWidth];
    
     ws(bself);
    if (isOutLine) {
        
        [UIView animateWithDuration:3.0 animations:^{
            
            bself.notiTitleLab.frame = CGRectMake(bself.notiTitleLab.left, bself.notiTitleLab.top, 0, bself.notiTitleLab.height);
        }];
    }else{
        
        [UIView animateWithDuration:3.0 animations:^{
            
            bself.notiTitleLab.frame = CGRectMake(bself.notiTitleLab.left, bself.notiTitleLab.top, size.width, bself.notiTitleLab.height);
        }];
    }
}

- (void)setModel:(HomeMainModel *)model
{
    _model = model;

}

- (void)setUI
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerr) userInfo:nil repeats:YES];
}

- (void)timerr
{
//    _downTime ++;
//    
//     _notiTitleLab.text = _titleArray[_downTime];
//    
//    if (_downTime == _titleArray.count) {
//        [_timer invalidate];
//        _timer = nil;
//    }
}
@end
