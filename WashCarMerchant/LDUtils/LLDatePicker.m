//
//  LLDatePicker.m
//  Coach
//
//  Created by LL on 16/8/10.
//  Copyright © 2016年 sskz. All rights reserved.
//

int const datePikerTag = 1200;

#import "LLDatePicker.h"

@interface LLDatePicker ()

@property (nonatomic, copy) ValueChangedCallback valueChangedCallback;
@property (nonatomic, copy) ClickDownBtnCallback clickDownBtnCallback;

@end

@implementation LLDatePicker
{
    NSDate *_date;
    NSDate *_minDate;
    NSDate *_maxDate;
    UIDatePickerMode _mode;
    CGRect _datePickerFrame;
    
    UIView *_coverView;
    
    UIView *_bgView;
    
    UIView *_toolBar;
    CGFloat _toolBarHeight;
    
    UIButton *_cancelBtn;
    NSString *_cancelBtnTitle;
    
    UILabel  *_titleLbl;
    NSString *_titleLblText;
    
    UIButton *_doneBtn;
    NSString *_doneBtnTitle;
    
}

+ (LLDatePicker *)show:(NSDate *)date datePickerMode:(UIDatePickerMode)mode attributes:(NSDictionary *)attributes valueChanged:(ValueChangedCallback)valueChanged clickDoneBtn:(ClickDownBtnCallback)clickDoneBtn
{
    UIView *oldView = [[UIApplication sharedApplication].keyWindow viewWithTag:datePikerTag];
    if (oldView) {
        [oldView removeFromSuperview];
    }
    
    CGFloat datePickerHeight = 180*kHeightScale;
    
    LLDatePicker *pickerView = [[LLDatePicker alloc] initWithFrame:CGRectMake(0, kScreenHeight-datePickerHeight, kScreenWidth, datePickerHeight) date:date datePickerMode:mode attributes:attributes valueChanged:valueChanged clickDoneBtn:clickDoneBtn];
    [[UIApplication sharedApplication].keyWindow addSubview:pickerView];
    pickerView.tag = datePikerTag;
    
//    pickerView.alpha = 0;
//    [UIView animateWithDuration:0.25f animations:^{
//        pickerView.alpha = 1;
//    }];
    
    return pickerView;
}

- (id)initWithFrame:(CGRect)frame date:(NSDate *)date datePickerMode:(UIDatePickerMode)mode attributes:(NSDictionary *)attributes valueChanged:(ValueChangedCallback)valueChanged clickDoneBtn:(ClickDownBtnCallback)clickDoneBtn
{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        _date = date;
        _minDate = attributes[LLPickerMinDateKey];
        _maxDate = attributes[LLPickerMaxDateKey];
        _mode = mode;
        _datePickerFrame = frame;
        _toolBarHeight = attributes[LLPickerToolBarHeightKey]?[attributes[LLPickerToolBarHeightKey] floatValue]:44;
        _doneBtnTitle = attributes[LLPickerDoneBtnTitleKey]?:@"完成";
        _cancelBtnTitle = attributes[LLPickerCancelBtnTitleKey]?:@"取消";
        _object = attributes[LLPickerObjectKey];
        _titleLblText = attributes[LLPickerTitleLblTextKey];
        self.valueChangedCallback = valueChanged;
        self.clickDownBtnCallback  = clickDoneBtn;
        [self setUI];
        [self setContraints];
        [self setAttributes];
    }
    return self;
}

#pragma mark - Setup

- (void)setUI
{
    _coverView = [UIView new];
    [self addSubview:_coverView];
    
    _toolBar = [UIView new];
    [self addSubview:_toolBar];
    
    _cancelBtn = [UIButton new];
    [_toolBar addSubview:_cancelBtn];
    
    _titleLbl = [UILabel new];
    [_toolBar addSubview:_titleLbl];
    
    _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_toolBar addSubview:_doneBtn];
    
    _bgView = [UIView new];
    [self addSubview:_bgView];
    
    _datePicker = [[UIDatePicker alloc] init];
    [_bgView addSubview:_datePicker];
}

- (void)setContraints
{
    [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    _bgView.frame = _datePickerFrame;
    
    WeakObj(_bgView)
    
    [_toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_bgViewWeak);
        make.bottom.equalTo(_bgViewWeak.mas_top);
        make.height.offset(_toolBarHeight);
    }];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.offset(0);
        make.width.offset(70);
    }];
    
    [_doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.offset(0);
        make.width.offset(70);
    }];
    
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_cancelBtn.mas_right);
        make.right.equalTo(_doneBtn.mas_left);
        make.top.bottom.offset(0);
    }];
    
    [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)setAttributes
{
    _coverView.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.5];
    
    _bgView.backgroundColor = [UIColor whiteColor];
    
    _toolBar.backgroundColor = [UIColor whiteColor];
    
    [_cancelBtn setTitle:_cancelBtnTitle forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:kAppThemeColor forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    _cancelBtn.titleLabel.font = Font15;
    
    _titleLbl.textAlignment = NSTextAlignmentCenter;
    _titleLbl.text = _titleLblText;
    _titleLbl.textColor = [UIColor blackColor];
    _titleLbl.font = Font14;
    
    [_doneBtn setTitle:_doneBtnTitle forState:UIControlStateNormal];
    [_doneBtn setTitleColor:kAppThemeColor forState:UIControlStateNormal];
    [_doneBtn addTarget:self action:@selector(clickDoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    _doneBtn.titleLabel.font = Font15;
    
    _datePicker.date = isNull(_date)?[NSDate date]:_date; // default is current date when picker created
    _datePicker.minimumDate = _minDate; // default is nil
    _datePicker.maximumDate = _maxDate; // default is nil
    _datePicker.datePickerMode = _mode; // default is UIDatePickerModeDateAndTime
    _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelf:)];
    [self addGestureRecognizer:tap];
}

- (void)clickCancelBtn:(UIButton *)cancelBtn{
    [LLDatePicker dismissFromView:[UIApplication sharedApplication].keyWindow];
}

- (void)clickDoneBtn:(UIButton *)doneBtn
{
    [LLDatePicker dismissFromView:[UIApplication sharedApplication].keyWindow];
    if (_clickDownBtnCallback) {
        _clickDownBtnCallback(self,doneBtn);
    }
}

- (void)datePickerValueChanged:(UIDatePicker *)datePicker
{
    if (_valueChangedCallback) {
        _valueChangedCallback(self,datePicker);
    }
}

- (void)tapSelf:(UITapGestureRecognizer *)tap
{
    [LLDatePicker dismissFromView:[UIApplication sharedApplication].keyWindow];
//    [self clickDoneBtn:_doneBtn];
}

+ (void)dismissFromView:(UIView *)view
{
    UIView *datePickerView = [view viewWithTag:datePikerTag];
    if (!datePickerView) {
        return;
    }
    
    [UIView animateWithDuration:0.15f animations:^{
        datePickerView.alpha = 0;
    } completion:^(BOOL finished) {
        [datePickerView removeFromSuperview];
    }];
}

@end
