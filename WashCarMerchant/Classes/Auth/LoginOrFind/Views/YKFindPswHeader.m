//
//  YKFindPswHeader.m
//  MerchantCenter
//
//  Created by kevin on 2017/2/23.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import "YKFindPswHeader.h"

@interface YKFindPswHeader ()

@property (nonatomic, strong) NSMutableArray <UIButton *>*btnArr;

@end

@implementation YKFindPswHeader

- (void)awakeFromNib {
    [super awakeFromNib];

    _btnArr = [NSMutableArray array];
    NSArray *titles = @[@"安全验证",@"设置新密码",@"修改成功"];
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:APPColor forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorWithWhite:195 / 255.0 alpha:1] forState:UIControlStateNormal];
        [btn.superview addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_stageImgView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        btn.titleLabel.font = Font12;
        [_btnArr addObject:btn];
    }
    [_btnArr[0].superview addConstraint:[NSLayoutConstraint constraintWithItem:_btnArr[0] attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_stageImgView attribute:NSLayoutAttributeLeft multiplier:1 constant:-10]];
    [_btnArr[1].superview addConstraint:[NSLayoutConstraint constraintWithItem:_btnArr[1] attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_stageImgView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [_btnArr[2].superview addConstraint:[NSLayoutConstraint constraintWithItem:_btnArr[2] attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_stageImgView attribute:NSLayoutAttributeRight multiplier:1 constant:10]];
}

- (void)setType:(YKFindPswType)type{
    if (_type != type) {
        _type = type;
        NSArray *imgs = @[@"zh_01",@"zh_02",@"zh_03"];
        _stageImgView.image = [UIImage imageNamed:imgs[_type-1]];
        for (int i = 0; i < 3; i++) {
            _btnArr[i].selected = i < _type;
        }
//        NSArray *lblArr = @[_leftFlagLbl,_centerFlagLbl,_rightFlagLbl];
//        for (int i = 1; i <= _type ; i++) {
//            UILabel *lbl = lblArr[i-1];
//            lbl.textColor = [UIColor whiteColor];
//            lbl.backgroundColor = RGB_COLOR(46, 178, 242);
//        }
//        if (_type == YKFindPswTypeStepTwo) {
//            _leftLineView.backgroundColor = RGB_COLOR(46, 178, 242);
//        } else if (_type == YKFindPswTypeStepThree){
//            _leftLineView.backgroundColor = RGB_COLOR(46, 178, 242);
//            _rightLineView.backgroundColor = RGB_COLOR(46, 178, 242);
//        }
    }
}

@end
