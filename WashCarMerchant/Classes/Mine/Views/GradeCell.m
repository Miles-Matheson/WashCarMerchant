//
//  GradeCell.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/24.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "GradeCell.h"

@implementation GradeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _progressLab = [[UILabel alloc]init];
    _progressLab.frame = CGRectMake(0, 0, 0, 5);
    
    [_progressBgLbl addSubview:_progressLab];
    
    _progressLab.backgroundColor = APPColor;
}

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    
    
    for (UIView *view in self.contentView.subviews) {
        
        if (view.tag == 666) {
            [view removeFromSuperview];
        }
    }

    //    for (int i = 0; i < _titleArray.count; i ++) {
    //
    //        NSDictionary *dic = _titleArray[i];
    //        NSString *title = [LLUtils strNilOrEmpty:dic[@"title"] elseBack:@""];
    //        CGFloat  cha =  _progressBgLbl.width /_titleArray.count;
    //
    //        UILabel *lab = [ViewCreate createLabelFrame:CGRectMake(0, _progressBgLbl.bottom +5, cha, 10) backgroundColor:WhiteColor text:title textColor:BlackColor textAlignment:Center font:kFont11];
    //         lab.tag = 666;
    //        [self.contentView addSubview:lab];
    //        lab.left = cha*i +12;
    //        if (i == _titleArray.count-1) {
    //            lab.right = _progressBgLbl.right;
    //        }
    //         UILabel *lab2 = [ViewCreate createLabelFrame:CGRectMake(0, lab.bottom+5, cha, 10) backgroundColor:WhiteColor text:dic[@"small"] textColor:BlackColor textAlignment:Center font:kFont10];
    //        lab2.centerX = lab.centerX;
//                lab2 = 666;
    //        [self.contentView addSubview:lab2];
    //    }
    //
    

    CGFloat mixSmal = [[_titleArray firstObject][@"small"] floatValue];
    CGFloat maxBig  = [[_titleArray lastObject][@"big"] floatValue];
    
    CGFloat MaxCha = maxBig-mixSmal;
    
    CGFloat initCha = 12;
    
    for (int i = 0; i < _titleArray.count; i ++) {
        
        NSDictionary *dic = _titleArray[i];
        
        CGFloat thisMixSmal = [ dic[@"small"] floatValue];
        CGFloat thisMaxBig  = [dic[@"big"] floatValue];
        
        CGFloat thisMaxCha = thisMaxBig-thisMixSmal;
        
        CGFloat percent = thisMaxCha/MaxCha;
        
        CGFloat thisWidth = percent * _progressBgLbl.width;
        
        initCha += thisWidth;
        
        CGFloat  cha =  _progressBgLbl.width /_titleArray.count;
        
        NSString *title = [LLUtils strNilOrEmpty:dic[@"title"] elseBack:@""];
        
        UILabel *lab = [ViewCreate createLabelFrame:CGRectMake(0, _progressBgLbl.bottom +5, cha, 10) backgroundColor:WhiteColor text:title textColor:BlackColor textAlignment:Center font:kFont11];
        [self.contentView addSubview:lab];
        lab.tag = 666;
        [lab sizeToFit];
        
        
        lab.centerX = initCha- thisWidth/2.0;
        
        if (i == 0) {
            lab.left = 12;
        }else if (i == _titleArray.count -1){
            lab.right = _progressBgLbl.width +12;
        }
        
        UILabel *lab2 = [ViewCreate createLabelFrame:CGRectMake(0, lab.bottom+5, cha, 10) backgroundColor:WhiteColor text:dic[@"small"] textColor:BlackColor textAlignment:Center font:kFont10];
        [self.contentView addSubview:lab2];
        lab2.tag = 666;
        [lab2 sizeToFit];
        lab2.centerX = lab.centerX;
    }
}

- (void)setUI
{
    CGFloat width = _progress * (KeyWindow.width - 24);
    
    ws(bself);
    [UIView animateWithDuration:2.0 animations:^{
        bself.progressLab.frame = CGRectMake(0, 0, width,5);
    }];
}
@end
