//
//  YKSignTopCell.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/22.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "YKSignTopCell.h"

@interface YKSignTopCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *sinLab;
@property (weak, nonatomic) IBOutlet UIButton *switckBtn;
@property (weak, nonatomic) IBOutlet UIButton *signBtn;
@property (nonatomic,assign)NSInteger signNum;
@end

@implementation YKSignTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setSignDayNum:(int)signDayNum{
    
    _signDayNum = signDayNum;
    NSString *name = [NSString stringWithFormat:@"jf_qd_jc_0%d",signDayNum];
    _imgView.image = [UIImage imageNamed:name];
    
    _sinLab.text = [NSString stringWithFormat:@"再签到%d天,获得大礼包",7-self.signDayNum];
}

- (void)setSignType:(BOOL)signType
{
    _signType  = signType;
    if (!signType) {
        [_signBtn setBackgroundImage:[UIImage imageNamed:@"qd_succ"] forState:0];
    }else{
        [_signBtn setBackgroundImage:[UIImage imageNamed:@"jf_qd_btn"] forState:0];
    }
 
}

- (void)setSignSwitch:(BOOL)signSwitch
{
    
    _signSwitch  = signSwitch;
    
    if (!signSwitch) {
            [_switckBtn setBackgroundImage:[UIImage imageNamed:@"kaiguan_close"] forState:0];
            _switckBtn.selected = NO;
        }else{
            [_switckBtn setBackgroundImage:[UIImage imageNamed:@"kaiguan_open"] forState:0];
            _switckBtn.selected = YES;
        }
}

- (IBAction)signBtnClick:(id)sender {//点击签到
    
    if (!_signType) {//
        
        [KeyWindow showCenterToast:@"已经签到喽!"];
        return;
    }
    if (_signCallBack) {
        _signCallBack(YES);
    }
}

- (IBAction)signDetailClick:(id)sender {//点击签到详情
    
    if (_signDetailCallBack) {
        _signDetailCallBack(YES);
    }
}

- (IBAction)switchClick:(id)sender {//签到提醒开关
    
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    
    if ( btn.selected) {
      [btn setBackgroundImage:[UIImage imageNamed:@"kaiguan_open"] forState:0];
    }else{
        [btn setBackgroundImage:[UIImage imageNamed:@"kaiguan_close"] forState:0];
    }
    
    if (_switchCallBack) {
        _switchCallBack(btn.selected);//0关闭  1开启
    }
    //jf_qd_jc_01
}


@end
