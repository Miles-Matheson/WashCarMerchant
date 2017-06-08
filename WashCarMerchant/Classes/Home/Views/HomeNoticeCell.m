//
//  HomeNoticeCell.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/5.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "HomeNoticeCell.h"

@interface HomeNoticeCell ()

@property (weak, nonatomic) IBOutlet UIScrollView *baseScrollView;

@end

@implementation HomeNoticeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)doAnimation{

    NSArray *labs = [_baseScrollView subviews];
    
    __block  CGFloat lastBottom = labs.count * 30;

    for (UILabel *lab in labs) {

        [UIView animateWithDuration: 0.5 delay: 0.35 options: UIViewAnimationOptionCurveEaseInOut animations: ^{
            
            lab.top -= lab.height;

        } completion: ^(BOOL finished) {

            if (lab.top < 0) {
                lab.bottom = lastBottom;
            }
        }];
    }
}
- (IBAction)moreNoticClick:(UIButton *)sender {
    
    if (_noticCallBack) {
        _noticCallBack(@"");
    }
}

- (void)setNotics:(NSArray *)notics
{
    _notics  = notics;
    
    if (_baseScrollView.subviews.count) {
        return;
    }    
    _baseScrollView.contentSize = CGSizeMake(0,  30*_notics.count);
    
    for (int i = 0; i < _notics.count; i ++) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10,i *30, _baseScrollView.width, 30)];
        lab.tag = i;
        lab.text = [NSString stringWithFormat:@"         %@",_notics[i]];
        lab.font = kFont13;
        [_baseScrollView addSubview:lab];
    }
}

@end
