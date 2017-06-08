//
//  HomeCarDataCell.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/5.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "HomeCarDataCell.h"

@interface HomeCarDataCell ()
//@property (weak, nonatomic) IBOutlet UIButton *thisWeakBtn;
//
//@property (weak, nonatomic) IBOutlet UIButton *thisMonthBtn;
@property (weak, nonatomic) IBOutlet UILabel *washCarNumLab;
@property (weak, nonatomic) IBOutlet UILabel *washCarMoneyLab;


@end

@implementation HomeCarDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
////    _thisWeakBtn.layer.masksToBounds = YES;
//    _thisWeakBtn.layer.borderWidth = 1;
//    _thisWeakBtn.layer.borderColor = APPColor.CGColor;
////    _thisWeakBtn.layer.cornerRadius = 3;
//    
////    _thisMonthBtn.layer.masksToBounds = YES;
//    _thisMonthBtn.layer.borderWidth = 1;
//    _thisMonthBtn.layer.borderColor = APPColor.CGColor;
////    _thisMonthBtn.layer.cornerRadius = 3;
//    
//
//    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:_thisWeakBtn.layer.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(5.0f, 5.0f)];
//    CAShapeLayer * maskLayer = [CAShapeLayer new];
//    maskLayer.frame = _thisWeakBtn.layer.bounds;
//    maskLayer.path = maskPath.CGPath;
//    _thisWeakBtn.layer.mask = maskLayer;
//    
//    UIBezierPath * maskPath2 = [UIBezierPath bezierPathWithRoundedRect:_thisMonthBtn.layer.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0f, 5.0f)];
//    CAShapeLayer * maskLayer2 = [CAShapeLayer new];
//    maskLayer2.frame = _thisMonthBtn.layer.bounds;
//    maskLayer2.path = maskPath2.CGPath;
//    _thisMonthBtn.layer.mask = maskLayer2;

}
- (IBAction)changeData:(id)sender {
    
    UISegmentedControl *segment =sender;
    
    ws(bself);
    NSInteger index =  segment.selectedSegmentIndex;
    
    [segment handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        
         UISegmentedControl *segmentControl =sender;
        
        if (bself.changeDayDataCallBack) {
            bself.changeDayDataCallBack(segmentControl.selectedSegmentIndex);
        }
    }];
}

- (void)setModel:(HomeMainModel *)model
{
    _model = model;
}

@end
