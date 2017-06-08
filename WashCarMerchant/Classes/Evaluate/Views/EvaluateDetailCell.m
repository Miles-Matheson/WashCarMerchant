//
//  EvaluateDetailCell.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/8.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "EvaluateDetailCell.h"

@interface EvaluateDetailCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;
@property (weak, nonatomic) IBOutlet UIImageView *img5;

@end

@implementation EvaluateDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImages:(NSArray *)images
{
    _images = images;

    int width = (KeyWindow.width - 12*4)/3;
    
    for ( int i = 0; i < _images.count;i ++ ) {

        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.frame = CGRectMake(i%3*(width +12) +12, i/3*(width +12) +12, width, width);
        
        [imgView sd_setImageWithURL:[NSURL URLWithString:_images[i]] placeholderImage:[UIImage imageNamed:@""]];

        [_baseView addSubview:imgView];
    }
}

- (void)setStar:(NSInteger)star
{
    _star = star;
    
    switch (_star) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            _img1.image =  [UIImage imageNamed:@"big_star_yellow"];
        }
            break;
        case 2:
        {
            _img1.image = _img2.image = [UIImage imageNamed:@"big_star_yellow"];
        }
            break;
        case 3:
        {
            _img1.image = _img2.image = _img3.image = [UIImage imageNamed:@"big_star_yellow"];
        }
            break;
        case 4:
        {
            _img1.image =  _img2.image = _img3.image = _img4.image = [UIImage imageNamed:@"big_star_yellow"];
        }
            break;
        case 5:
        {
            _img1.image = _img2.image =  _img3.image = _img4.image = _img5.image = [UIImage imageNamed:@"big_star_yellow"];
        }
            break;
            
        default:
            break;
    }
}

@end
