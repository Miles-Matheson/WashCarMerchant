//
//  LLDatePicker.h
//  Coach
//
//  Created by LL on 16/8/10.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import <UIKit/UIKit.h>

//attributes key define
static const NSString * LLPickerMinDateKey = @"LLPickerMinDateKey";
static const NSString * LLPickerMaxDateKey = @"LLPickerMaxDateKey";
static const NSString * LLPickerToolBarHeightKey = @"LLPickerToolBarHeightKey";
static const NSString * LLPickerDoneBtnTitleKey = @"LLPickerDoneBtnTitleKey";
static const NSString * LLPickerCancelBtnTitleKey = @"LLPickerCancelBtnTitleKey";
static const NSString * LLPickerObjectKey = @"LLPickerObjectKey";
static const NSString * LLPickerTitleLblTextKey = @"LLPickerTitleLblTextKey";

@class LLDatePicker;

typedef void(^ValueChangedCallback)(LLDatePicker *view,UIDatePicker *dataPicker);
typedef void(^ClickDownBtnCallback)(LLDatePicker *view,UIButton *doneBtn);

@interface LLDatePicker : UIView

+ (LLDatePicker *)show:(NSDate *)date datePickerMode:(UIDatePickerMode)mode attributes:(NSDictionary *)attributes valueChanged:(ValueChangedCallback)valueChanged clickDoneBtn:(ClickDownBtnCallback)clickDoneBtn;

+ (void)dismissFromView:(UIView *)view;  //移除DatePickerView

@property (nonatomic,strong) UIDatePicker *datePicker;

@property (nonatomic,strong) id object;  //default is nil

@end
