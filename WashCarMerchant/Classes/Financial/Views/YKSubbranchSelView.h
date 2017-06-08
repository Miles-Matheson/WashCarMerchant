//
//  YKSubbranchSelView.h
//  MerchantCenter
//
//  Created by kevin on 2017/2/22.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YKSubbranchSelView;

@protocol YKSubbranchSelViewDelegate <NSObject>

- (void)YKSubbranchSelView:(YKSubbranchSelView *)view selectedIndex:(NSInteger)selectedIndex;
- (void)YKSubbranchSelViewDismiss:(YKSubbranchSelView *)view;

@end

@interface YKSubbranchSelView : UIView

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) id object;

@property (nonatomic, assign) id <YKSubbranchSelViewDelegate> delegate;

@property (nonatomic, assign) NSInteger lastSelIndex; //上次选择index

+ (void)showInView:(UIView *)superView frame:(CGRect)frame delegate:(id)delegate dataSource:(NSArray <NSString *> *)dataSource object:(id)object lastSelIndex:(NSInteger)lastSelIndex;

+ (void)dismissFromView:(UIView *)superView;

@end
