//
//  EvaluateCell.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/8.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "EvaluateCell.h"

@interface EvaluateCell ()

@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (weak, nonatomic) IBOutlet UILabel *gradeLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (strong, nonatomic)  UIButton *clickBtn;
@end

@implementation EvaluateCell

- (void)awakeFromNib {
    [super awakeFromNib];

    ws(bself);
    _clickBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 25)];
    [_clickBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        if (_operationCallBack) {
            _operationCallBack(bself.model);
        }
    }];
    _clickBtn.titleLabel.font = kFont13;
    _clickBtn.backgroundColor = APPColor;
    _clickBtn.layer.cornerRadius = 5;
    _clickBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:_clickBtn];
    
}

- (void)setModel:(EvaluateModel *)model
{
    _model = model;
    
    _gradeLab.text = _model.serviceName;
    
    if (_model.isRecall) {
        _statusLab.text = @"已回复";
        [_clickBtn setTitle:@"回复修改" forState:0];
        _clickBtn.frame = CGRectMake(0, 0, 70, 25);
        _clickBtn.right = KeyWindow.width-23;
    }else{
        _statusLab.text = @"未回复";
        [_clickBtn setTitle:@"回复" forState:0];
        _clickBtn.frame = CGRectMake(0, 0, 50, 25);
        _clickBtn.right = KeyWindow.width-23;
    }
    _clickBtn.centerY = _statusLab.centerY;
    
    _contentLab.text = _model.content;
    _timeLab.text = [self getTimeStr: _model.createDate];
}

- (NSString *)getTimeStr:(NSString *)time
{
    NSDateFormatter *dateFormatter =  [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSDate *date = [dateFormatter dateFromString:time];
    
    dateFormatter.dateFormat = @"YYYY-MM-dd";
    NSString *timeStr = [dateFormatter stringFromDate: date];
    return timeStr;
}

- (IBAction)replyOrChangeClick:(id)sender {

    if (_operationCallBack) {
        _operationCallBack(self.model);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end
