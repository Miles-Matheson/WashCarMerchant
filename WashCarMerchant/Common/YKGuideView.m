//
//  YKGuideView.m
//  MurphysLaw
//
//  Created by Miles on 2017/4/26.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import "YKGuideView.h"

@interface YKGuideView ()<UIScrollViewDelegate>
{
    UIPageControl *pagVC;
    UIButton *cliclBtn;
}
@end

@implementation YKGuideView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        ws(bself);
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIApplication sharedApplication].keyWindow.size.width, self.height)];
    
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.bounces = NO;
        _scrollView.autoresizesSubviews = NO;
        _scrollView.clipsToBounds = NO;
//        _scrollView.contentOffset = CGPointMake(self.width, 0);
        [self addSubview:_scrollView];
    
        pagVC = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        pagVC.currentPage = 0;
        pagVC.backgroundColor = ClearColor;
        pagVC.tintColor = [UIColor grayColor];
        pagVC.currentPageIndicatorTintColor = RGB_COLOR(29, 165, 238);
        pagVC.pageIndicatorTintColor = RGB_COLOR(175, 175, 175);
        pagVC.centerX = _scrollView.centerX;
        pagVC.top = _scrollView.bottom-50;
        [self addSubview:pagVC];
        
        CGPoint contentOffset = _scrollView.contentOffset;
        [_scrollView setContentOffset:CGPointMake(contentOffset.x, 0) animated:YES];
        //其中X和Y分别是x轴和y轴滚动的距离
        
        cliclBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 23, 90, 70)];
        cliclBtn.backgroundColor = [UIColor clearColor];
        cliclBtn.titleLabel.font = kFont15;
        cliclBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        cliclBtn.right = _scrollView.right;
        [cliclBtn setTitle:@"跳过" forState:0];
        [cliclBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            
            [bself removeFromSuperview];
        }];
        [cliclBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self addSubview:cliclBtn];
       
    }
    return self;
}


- (void)setImageAarray:(NSMutableArray *)imageAarray
{
    pagVC.numberOfPages = imageAarray.count;
    _scrollView.contentSize = CGSizeMake([UIApplication sharedApplication].keyWindow.size.width *imageAarray.count,self.height);
    for (int i  = 0; i < imageAarray.count; i ++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i *[UIApplication sharedApplication].keyWindow.size.width, 0, [UIApplication sharedApplication].keyWindow.size.width, self.height)];
        imgView.image = [UIImage imageNamed:imageAarray[i]];
        [_scrollView addSubview:imgView];
    }
   
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pagVC.currentPage = (int)(scrollView.contentOffset.x/[UIApplication sharedApplication].keyWindow.size.width);
//    NSLog(@"scrollView.contentOffset.x/self.width ===%f",(int)scrollView.contentOffset.x/self.width);
    if (pagVC.currentPage == 3) {
        [cliclBtn setTitle:@"立即体验" forState:0];
    }else{
        [cliclBtn setTitle:@"跳过" forState:0];
    }
}
@end
