//
//  YKAdView.h
//  MurphysLaw
//
//  Created by Miles on 2017/4/27.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickImgCallback)(NSString *urlStr);

@interface YKAdView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *cutdownBtn;

+ (void)showAdView:(ClickImgCallback)callback superView:(UIView *)supView imgUrlPath:(NSString *)imgUrlPath removeTime:(NSUInteger)removeTime;

@end
