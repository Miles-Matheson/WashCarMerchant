//
//  YKFourLblCell.m
//  MerchantCenter
//
//  Created by kevin on 2017/2/24.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import "YKFourLblCell.h"

@implementation YKFourLblCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(FinancialModel *)model
{
    _model = model;
    
    self.lbl1.text = [LLUtils dateStrWithDate:[LLUtils dateWithDateStr:_model.creattime dateFormat:@"yyyy-MM-dd"] dateFormat:@"yyyy-MM-dd"];
    self.lbl2.text = _model.zdNm;
    self.lbl3.text = _model.jsType;
    self.lbl4.text = _model.amt;
}
@end
