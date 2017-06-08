//
//  OrderListCell.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/10.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "OrderListCell.h"

@interface OrderListCell ()

@property (weak, nonatomic) IBOutlet UILabel *orserNoLab;
@property (weak, nonatomic) IBOutlet UILabel *fuwuLab;
@property (weak, nonatomic) IBOutlet UILabel *gukeLab;
@property (weak, nonatomic) IBOutlet UILabel *zhuangtaiLab;
@property (weak, nonatomic) IBOutlet UILabel *shijianLab;

@end


@implementation OrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(OrderModel *)model
{
    _model = model;
    
    _orserNoLab.text = _model.orderNum;
    _fuwuLab.text = _model.serviceName;
    _gukeLab.text = _model.nick;

    _shijianLab.text =  [LLUtils dateStrWithDate:_model.createDate dateFormat: @"YYYY.MM.dd HH:mm"];
    
    
    switch ([_model.stat intValue]) {//0待付款、1待洗车、2待确认、3已完成、4已取消、5已过期

        case 0:
        {
          _zhuangtaiLab.text =@"待付款";
        }
            break;
        case 1:
        {
            _zhuangtaiLab.text =@"待洗车";
        }
            break;
        case 2:
        {
           _zhuangtaiLab.text =@"待确认";
        }
            break;
        case 3:
        {
            _zhuangtaiLab.text =@"已完成";
        }
            break;
        case 4:
        {
            _zhuangtaiLab.text =@"已取消";
        }
            break;
        case 5:
        {
            _zhuangtaiLab.text =@"已过期";
        }
            break;
            
        default:
            break;
    }
}
@end
