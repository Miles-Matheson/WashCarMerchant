//
//  HomeParkingCell.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/5.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "HomeParkingCell.h"

@interface HomeParkingCell ()
@property (weak, nonatomic) IBOutlet UIButton *parkingBtn;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;

@end

@implementation HomeParkingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)setModel:(HomeMainModel *)model
{
    _model = model;
    
}
- (IBAction)detailCallBack:(UIButton *)sender {
    
    if  (_detaleCallCack){
        _detaleCallCack (_model);
    }
    
}


@end
