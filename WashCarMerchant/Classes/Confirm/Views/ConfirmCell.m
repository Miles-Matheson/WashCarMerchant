//
//  ConfirmCell.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/6.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "ConfirmCell.h"

@interface ConfirmCell ()
{
    
}
@property (weak, nonatomic) IBOutlet UILabel *fuwuLab;
@property (weak, nonatomic) IBOutlet UILabel *youhuiLab;
@property (weak, nonatomic) IBOutlet UILabel *menshiLab;
@property (weak, nonatomic) IBOutlet UILabel *zhuangtaiLab;
@property (weak, nonatomic) IBOutlet UIView *baseView;

@property (nonatomic,strong)UILabel *lineLab;
@property (nonatomic,strong)UIButton *yesBtn;
@property (nonatomic,strong)UIButton *backBtn;
@property (nonatomic,strong)UIButton *checkBtn;
@end

@implementation ConfirmCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setModel:(MerchantModel *)model
{
    _model = model;
    
    _fuwuLab.text = _model.serviceName;
    _youhuiLab.text = _model.nowPrice;
    _menshiLab.text = _model.ordPrice;
    _idStr = _model.carServiceId;
    
    _lineLab.hidden = _checkBtn.hidden = _yesBtn.hidden = _backBtn.hidden = YES;
    
    switch ([_model.stat intValue]) {
        case 0:
        {
             _zhuangtaiLab.text = @"待确认";//2
            
            self.yesBtn.hidden = self.backBtn.hidden = NO;
        }
            break;
        case 1:
        {
             _zhuangtaiLab.text = @"已驳回";//--
            self.lineLab.hidden = NO;
        }
            break;
        case 2:
        {
             _zhuangtaiLab.text = @"已上线";//yu
            self.checkBtn.hidden = NO;
        }
            break;
        case 3:
        {
             _zhuangtaiLab.text = @"已下线";//--
            self.lineLab.hidden = NO;
        }
            break;
            
        default:
            break;
    }
}

- (UILabel*)lineLab
{
    if (!_lineLab) {
        _lineLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
        _lineLab.font = kFont13;
         [_baseView addSubview:_lineLab];
        _lineLab.text = @"--";
        _lineLab.textColor = BlackColor;
        _lineLab.textAlignment = Center;
        [_lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(10, 20, 10, 20));
        }];
    }
    return _lineLab;
}

- (UIButton*)checkBtn
{
    if (!_checkBtn) {
        ws(bself);
        _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkBtn setTitle:@"预览" forState:0];
        [_checkBtn setTitleColor:WhiteColor forState:0];
        _checkBtn.backgroundColor = APPColor;
        [_baseView addSubview:_checkBtn];
        [_checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(10, 20, 10, 20));
        }];
        _checkBtn.titleLabel.font = kFont13;
        _checkBtn.layer.masksToBounds = YES;
        _checkBtn.layer.cornerRadius = 5.0;
        
        [_checkBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            
            if (bself.caozuoBack) {
                bself.caozuoBack(10);
            }
        }];
    }
    return _checkBtn;
}

- (UIButton*)yesBtn
{
    if (!_yesBtn) {
         ws(bself);
        _yesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_yesBtn setTitle:@"确认" forState:0];
        [_yesBtn setTitleColor:WhiteColor forState:0];
        _yesBtn.backgroundColor = APPColor;
        [_baseView addSubview:_yesBtn];
        
        [_yesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(5);
            make.top.offset(10);
            make.bottom.offset(-10);
        }];
        [_yesBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            
            if (bself.caozuoBack) {
                bself.caozuoBack(20);
            }
        }];
        _yesBtn.titleLabel.font = kFont13;
        _yesBtn.layer.masksToBounds = YES;
        _yesBtn.layer.cornerRadius = 5.0;
    }
    
    return _yesBtn;
}

- (UIButton*)backBtn
{
    if (!_backBtn) {
        ws(bself);
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setTitle:@"驳回" forState:0];
        [_backBtn setTitleColor:WhiteColor forState:0];
        _backBtn.backgroundColor = RedColor;
        [_baseView addSubview:_backBtn];
        [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-5);
            make.top.offset(10);
            make.bottom.offset(-10);
            make.width.equalTo(bself.yesBtn);
            make.left.equalTo(bself.yesBtn.mas_right).offset(10);
        }];
        [_backBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            
            if (bself.caozuoBack) {
                bself.caozuoBack(30);
            }
        }];
        _backBtn.titleLabel.font = kFont13;
        _backBtn.layer.masksToBounds = YES;
        _backBtn.layer.cornerRadius = 5.0;
    }
    
    return _backBtn;
}

- (IBAction)downClick:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if (_caozuoBack) {
        _caozuoBack(btn.tag);
    }
}

@end
