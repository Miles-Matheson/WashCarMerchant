//
//  LLSinglePickerView.m
//  StoreIntegral
//
//  Created by kevin on 2017/1/20.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#define kAddressPickerTag 2017
#define kAnimationDuration 0.5f

#import "LLSinglePickerView.h"

@interface LLSinglePickerView () <UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *barView;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *doneBtn;
@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, assign) NSUInteger selIndex;
@property (nonatomic, strong) NSDictionary *attributes;
@property (nonatomic, copy) SinglePickerCompletion completion;

@end

@implementation LLSinglePickerView

+ (void)show:(NSDictionary *)attributes callback:(SinglePickerCompletion)completion{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *oldView = [keyWindow viewWithTag:kAddressPickerTag];
    if (oldView) {
        [oldView removeFromSuperview];
    }
    
    LLSinglePickerView *picker = [[LLSinglePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    picker.dataSource = attributes[@"datasource"];
    picker.attributes = attributes;
    picker.completion = completion;
    [keyWindow addSubview:picker];
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
        [self setUI];
    }
    return self;
}

- (void)commonInit{
   
}

- (void)setUI{
    //蒙版
    _coverView = [UIView new];
    [self addSubview:_coverView];
    [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [_coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCoverView:)]];
    _coverView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.2];
    
    CGFloat bgViewHeight = kScreenHeight*0.4;
    
    //工具条和pickerView背景
    _bgView = [UIView new];
    [self addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(bgViewHeight);
        make.bottom.offset(bgViewHeight);
    }];
    _bgView.backgroundColor = [UIColor whiteColor];
    
    //工具条
    _barView = [UIView new];
    [_bgView addSubview:_barView];
    [_barView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(35);
    }];
    
    CGFloat btnOffset = 20;
    CGFloat btnWidth = 40;
    UIColor *btnTitleColor = [UIColor blackColor];
    UIFont  *btnFont = kFont15;
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_barView addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(btnOffset);
        make.top.bottom.offset(0);
        make.width.offset(btnWidth);
    }];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:btnTitleColor forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    _cancelBtn.titleLabel.font = btnFont;
    
    _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_barView addSubview:_doneBtn];
    [_doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-btnOffset);
        make.top.bottom.offset(0);
        make.width.offset(btnWidth);
    }];
    [_doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_doneBtn setTitleColor:btnTitleColor forState:UIControlStateNormal];
    [_doneBtn addTarget:self action:@selector(clickDoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    _doneBtn.titleLabel.font = btnFont;
    
    _pickerView = [[UIPickerView alloc] init];
    [_bgView addSubview:_pickerView];
    WeakObj(_barView)
    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.top.equalTo(_barViewWeak.mas_bottom);
    }];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    
    _coverView.alpha = 0;
    [LLUtils showSpring:kAnimationDuration animations:^{
        _coverView.alpha = 1;
        _bgView.transform = CGAffineTransformMakeTranslation(0, -bgViewHeight);
    } completion:nil];
}

- (void)setAttributes:(NSDictionary *)attributes{
    _attributes = attributes;
    
    NSString *initString = _attributes[@"initstring"];
    if (isEmptyStr(initString)) {
        return;
    }
    
    for (int i = 0; i < _dataSource.count; i++) {
        NSString *item = _dataSource[i];
        if ([item isEqualToString:initString]) {
            [_pickerView selectRow:i inComponent:0 animated:YES];
            _selIndex = i;
            break;
        }
    }
}

#pragma mark - UIPickerViewDelegate && UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _dataSource.count;
}

// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return kScreenWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 35;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{
    if (view) {
        UILabel *titleLbl = [view viewWithTag:1001];
        titleLbl.text = _dataSource[row];
        return view;
    } else {
        UIView *bgView = [UIView new];
        UILabel *titleLbl = [UILabel new];
        [bgView addSubview:titleLbl];
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        titleLbl.text = _dataSource[row];
        titleLbl.font = kFont17;
        titleLbl.tag = 1001;
        titleLbl.textAlignment = NSTextAlignmentCenter;
        return bgView;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _selIndex = row;
}

- (void)clickCancelBtn:(UIButton *)cancelBtn{
    [self dismiss];
}

- (void)clickDoneBtn:(UIButton *)doneBtn{
    if ((_selIndex<_dataSource.count) && _completion) {
        _completion(integerToStr(_selIndex),_dataSource[_selIndex]);
    }
    [self dismiss];
}

- (void)tapCoverView:(UITapGestureRecognizer *)tap{
    [self dismiss];
}

- (void)dismiss{
    [UIView animateWithDuration:kAnimationDuration animations:^{
        _coverView.alpha = 0;
        _bgView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
