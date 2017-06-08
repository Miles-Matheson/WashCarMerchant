//
//  YKCommonFilterView.h
//  MerchantCenter
//
//  Created by kevin on 2017/2/24.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YKCommonFilterView;

@protocol YKCommonFilterViewDelegate <NSObject>

- (void)YKCommonFilterView:(YKCommonFilterView *)view clickBtn:(UIButton *)btn;

@end

@interface YKCommonFilterView : UIView

@property (nonatomic, assign) id <YKCommonFilterViewDelegate> delegate;

@property (nonatomic, strong) UIButton *lastSelBtn;

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles isShowImgs:(NSArray *)isShowImgs interactions:(NSArray *)interactions imgTitleIntervals:(NSArray *)imgTitleIntervals titleIntervals:(NSArray *)titleIntervals;

- (void)rotateArrow:(UIButton *)btn;

@end
