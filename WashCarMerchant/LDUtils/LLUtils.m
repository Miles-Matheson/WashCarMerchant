//
//  LLUtils.m
//  StoreIntegral
//
//  Created by kevin on 2016/12/20.
//  Copyright © 2016年 Ecommerce. All rights reserved.
//

#define hudDismissTime 3

#import "SVProgressHUD.h"
#import "LLUtils.h"

@implementation LLUtils

+ (BOOL)strNilOrEmpty:(NSString *)str{
    return str == nil
    || str == NULL
    || [str isKindOfClass:[NSNull class]]
    ||([str respondsToSelector:@selector(length)]
       && [(NSData *)str length] == 0)
    || ([str respondsToSelector:@selector(count)]
        && [(NSArray *)str count] == 0);
}

+ (NSString *)strRelay:(id)str
{
    if([LLUtils strNilOrEmpty:str]){
        return @"";
    }
    else if([str isKindOfClass:[NSString class]]){
        return str;
    }
    else if([str isKindOfClass:[NSNumber class]]){
        return [str stringValue];
    }
    return str;
}

+ (NSString *)strNilOrEmpty:(id)str elseBack:(id)back
{
    if([LLUtils strNilOrEmpty:str]){
        return back;
    }
    else if([str isKindOfClass:[NSString class]]){
        return str;
    }
    else if([str isKindOfClass:[NSNumber class]]){
        return [str stringValue];
    }
    return str;
}

/**
将图片缩小到指定尺寸
 image  : 原图片
 size   : 缩小到的尺寸
 return : 缩小的图片
 */
+ (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate tag:(NSInteger)tag type:(AlertViewType)type
{
    UIAlertView *alertView = nil;
    if (type == AlertViewTypeOnlyYes || type == AlertViewTypeOnlyConfirm) {
        alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:type == AlertViewTypeOnlyYes ? @"是" : @"确定" otherButtonTitles:nil, nil];
    }
    else
    {
        alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:type==AlertViewTypeYesAndNo?@"是":@"确定" otherButtonTitles:type==AlertViewTypeYesAndNo?@"否":@"取消", nil];
    }
    alertView.tag = tag;
    [alertView show];
}

+ (void)callPhoneWithPhone:(NSString *)phoneStr
{
    if (isEmptyStr(phoneStr)) {
        return;
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneStr]]];
}

+ (NSString *)jsonStrWithJSONObject:(id)jsonObj
{
    if (!jsonObj || ![NSJSONSerialization isValidJSONObject:jsonObj]) {
        return @"";
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObj options:0 error:&error];
    if (error || !jsonData) {
        return @"";
    }
    else
    {
        
        NSString * policyStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        policyStr = [policyStr stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
        return  policyStr;
        
//       return  [NSString stringWithUTF8String:[jsonData bytes]];
        
//        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

+ (id)jsonObjectWithJSONStr:(NSString *)jsonStr
{
    if (!jsonStr) {
        return @{};
    }
    NSError *error = nil;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    if (!error && jsonObj) {
        return jsonObj;
    }
    else
    {
        return @{};
    }
}

+ (NSString *)replaceUnicode:(NSString *)unicodeStr
{
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    // NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"%u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2]stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [ NSPropertyListSerialization  propertyListFromData:tempData
                                                             mutabilityOption:NSPropertyListImmutable
                                                                       format:NULL
                                                             errorDescription:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

//回弹动画
//实现view由小放大再缩小，回弹效果的动画
//view : 要做动画的view
+ (void)showSpringBackAnimationView:(UIView *)view
{
    
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:popAnimation forKey:nil];
}

//消失动画
//alphaView   : alphaView 要做透明度变化到完全透明的View
//scaleView   : 要做缩放动画的View
//dismissBlock: alphaView从父视图移除时的回调block
+ (void)showDismissAnimationWithAlphaView:(UIView *)alphaView scaleView:(UIView *)scaleView didDismissBlock:(void(^)())dismissBlock
{
    [UIView animateWithDuration:0.2f animations:^{
        alphaView.alpha = 0;
        scaleView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    } completion:^(BOOL finished) {
        [alphaView removeFromSuperview];
        if (dismissBlock) {
            dismissBlock();
        }
    }];
}

//将时间戳转换成NSDate
//timeStamp  : 时间戳 NSString / NSNumber
//return     : 返回对应的日期 NSDate
+ (NSDate *)dateWithTimeStamp:(id)timeStamp
{
    if (isNull(timeStamp)) {
        return [NSDate date];
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]];
    if (isNull(date)) {
        return [NSDate date];
    }
    else
    {
        return date;
    }
}

//将时间戳转换成NSString
//timeStamp  : 时间戳 NSString / NSNumber
//dateFormat : 返回的时期格式 eg. @"yyyy-MM-dd"
//return     : 返回对应的日期字符串 NSString
+ (NSString *)dateStrWithTimeStamp:(id)timeStamp dateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    dateFormater.dateFormat = isNull(dateFormat)?@"yyyy-MM-dd":dateFormat;
    if (isNull(timeStamp)) {
        return [dateFormater stringFromDate:[NSDate date]];
    }
    NSString *timeStampStr = [NSString stringWithFormat:@"%@",timeStamp];
    if (timeStampStr.length>10) {
        timeStampStr = [timeStampStr substringToIndex:10];
    }
    NSDate *date = [self dateWithTimeStamp:timeStampStr];
    NSString *dateStr = [dateFormater stringFromDate:date];
    if (isNull(dateStr)) {
        return [dateFormater stringFromDate:[NSDate date]];
    }
    else
    {
        return dateStr;
    }
}

//将日期转换成 制定格式的日期字符串
//date       : 待转换日期 NSDate
//dateFormat : 返回的时期格式 eg. @"yyyy-MM-dd"
//return     : 返回对应的日期字符串 NSString
+ (NSString *)dateStrWithDate:(NSDate *)date dateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    dateFormater.dateFormat = isNull(dateFormat)?@"yyyy-MM-dd":dateFormat;
    if (isNull(date)) {
        return [dateFormater stringFromDate:[NSDate date]];
    }
    NSString *dateStr = [dateFormater stringFromDate:date];
    if (isNull(dateStr)) {
        return [dateFormater stringFromDate:[NSDate date]];
    }
    else
    {
        return dateStr;
    }
}

//将日期字符串 按照相应的格式 转换成对应的 日期
//dateStr    : 待转换日期字符串 NSString
//dateFormat : 返回的时期格式 eg. @"yyyy-MM-dd"  注意：dateFormat参数传入的字符串格式必须和传入的dateStr的格式一致，否则会崩溃!
//return     : 返回对应的日期 NSDate
+ (NSDate *)dateWithDateStr:(NSString *)dateStr dateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    dateFormater.dateFormat = isNull(dateFormat)?@"yyyy-MM-dd":dateFormat;
    if (isNull(dateStr)) {
        return [NSDate date];
    }
    NSDate *date = [dateFormater dateFromString:dateStr];
    if (isNull(date)) {
        return [NSDate date];
    }
    else
    {
        return date;
    }
}

//获取对应日期的时间戳
//date   : NSDate
//return : 时间戳
+ (long long)timestampsWithDate:(NSDate *)date
{
    if (isNull(date)) {
        return [[NSDate date] timeIntervalSince1970];
    }
    long long timestamps = [date timeIntervalSince1970];
    if (timestamps<0) {
        return [[NSDate date] timeIntervalSince1970];
    }
    else
    {
        return timestamps;
    }
}

//获取对应日期字符串的时间戳
//dateStr   : NSString
//format    :格式化的字符串
//return    : 时间戳
+ (long long)timestampsWithDateStr:(NSString *)dateStr dateFormat:(NSString *)format
{
    if (isNull(dateStr)) {
        return [[NSDate date] timeIntervalSince1970];
    }
    NSDate *date = [self dateWithDateStr:dateStr dateFormat:format];
    long long timestamps = [self timestampsWithDate:date];
    return timestamps;
}

#pragma mark - HUD

+ (void)showOnlyProgressHud
{
    [SVProgressHUD show];
}

+ (void)showTextAndProgressHud:(NSString *)status
{
    [SVProgressHUD showWithStatus:status];
}

+ (void)showTextAndProgressHud:(NSString *)status afterDelay:(NSTimeInterval)delay
{
    [SVProgressHUD showWithStatus:status];
    [SVProgressHUD dismissWithDelay:delay];
}

+ (void)showOnlyTextHub:(NSString *)text
{
    
}

+ (void)showSuccessHudWithStatus:(NSString *)statusStr
{
    if (isNull(statusStr)) {
        return;
    }
    [self setSVProgressHideTime];
    [SVProgressHUD showSuccessWithStatus:statusStr];
}

+ (void)showErrorHudWithStatus:(NSString *)statusStr
{
    if (isNull(statusStr)) {
        return;
    }
    [self setSVProgressHideTime];
    [SVProgressHUD showErrorWithStatus:statusStr];
}

+ (void)showInfoHudWithStatus:(NSString *)statusStr
{
    if (isNull(statusStr)) {
        return;
    }
    [self setSVProgressHideTime];
    [SVProgressHUD showInfoWithStatus:statusStr];
}

+ (void)setSVProgressHideTime
{
    [SVProgressHUD setMinimumDismissTimeInterval:hudDismissTime];
}

+ (void)dismiss
{
    [SVProgressHUD dismiss];
}

+(BOOL)validateMobile:(NSString *)mobileNum
{
    NSString *pattern = @"1[3|5|7|8|][0-9]{9}";;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:mobileNum];
    return isMatch;
}

+(BOOL)validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

/**
 *
 *  判断用户输入的密码是否符合规范，符合规范的密码要求：
 1. 长度大于等于maxLength 小于maxLenght
 2. 密码中必须同时包含数字和字母
 */
+(BOOL)validatePassword:(NSString *)pass minLength:(int)minLength maxLength:(int)maxLength{
    BOOL result = false;
    if ([pass length] >= minLength && [pass length] <= maxLength){
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = [NSString stringWithFormat:@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{%d,%d}$",minLength,maxLength];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}

//UIImage ===> NSData
+ (NSData *)dataWithImage:(UIImage *)image
{
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil) {
        
        data = UIImageJPEGRepresentation(image, 1);
        
    } else {
        
        data = UIImagePNGRepresentation(image);
    }
    return data;
}

+ (NSString *)previousMonthWithProviceMonthIndex:(NSInteger)monthIndex dateFormat:(NSString *)format
{
    NSCalendar *calender = [NSCalendar currentCalendar];//获取NSCalender单例。
    NSDateComponents *cmp = [calender components:(NSMonthCalendarUnit | NSYearCalendarUnit
                                                  |NSDayCalendarUnit | NSHourCalendarUnit
                                                  |NSMinuteCalendarUnit
                                                  |NSSecondCalendarUnit) fromDate:[[NSDate alloc] init]];// 设置属性，因为我只需要年和月，这个属性还可以支持时，分，秒。
    [cmp setMonth:[cmp month] - monthIndex];//设置上个月，即在现有的基础上减去一个月。这个地方可以灵活的支持跨年了，免去了繁琐的计算年份的工作。
    NSDate *lastMonDate = [calender dateFromComponents:cmp];//拿到上个月的NSDate，再用
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    NSString *dateStr = [formatter stringFromDate:lastMonDate];
    return dateStr;
}

+ (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}

//将日期的时分秒置为0
+ (NSDate *)setHourMinSecToZero:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                    |NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:date];
    
    components.hour = components.minute = components.second = 0;
    
    return [calendar dateFromComponents:components];
}

//过滤手机号的86,+86,+86·
+ (NSString *)filterPhoneNum86:(NSString *)phone
{
    if ([phone hasPrefix:@"86"]) {
        NSString *formatStr = [phone substringWithRange:NSMakeRange(2, [phone length]-2)];
        return formatStr;
    }
    else if ([phone hasPrefix:@"+86"])
    {
        if ([phone hasPrefix:@"+86·"]) {
            NSString *formatStr = [phone substringWithRange:NSMakeRange(4, [phone length]-4)];
            return formatStr;
        }
        else
        {
            NSString *formatStr = [phone substringWithRange:NSMakeRange(3, [phone length]-3)];
            return formatStr;
        }
    }
    return phone;
}

//获取url字符串中某一参数值对应的参数值
//paraName : 要扣取的参数名
//url      : url字符串
//return   : 返回对应参数名的参数值
+ (NSString *)getParaValueWithParaName:(NSString *)paraName url:(NSString *)url
{
    NSArray *urlSepArr = [url componentsSeparatedByString:@"?"];
    if (isEmptyStr(paraName) || isEmptyStr(url) || urlSepArr.count != 2) {
        return @"";
    }
    NSString *paraListStr = [urlSepArr lastObject];
    NSArray *paraSepArr = [paraListStr componentsSeparatedByString:@"&"];
    for (NSString *paraStr in paraSepArr) {
        if ([paraStr containsString:paraName]) {
            NSArray *getArr = [paraStr componentsSeparatedByString:@"="];
            if (getArr.count==0) {
                return @"";
            }
            else if (getArr.count==1)
            {
                return @"";
            }
            else
            {
                return [getArr lastObject];
            }
        }
    }
    return @"";
}

/**
 获取url的所有参数
 url : 要获取参数的url字符串
 return : 获得的参数字典
 */
+ (NSDictionary *)getUrlParametersWithUrl:(NSString *)url{
    NSArray *urlSepArr = [url componentsSeparatedByString:@"?"];
    if (urlSepArr.count != 2) {
        return @{};
    }
    NSString *paraListStr = [urlSepArr lastObject];
    NSArray *paraSepArr = [paraListStr componentsSeparatedByString:@"&"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (NSString *paraStr in paraSepArr) {
        NSArray *getArr = [paraStr componentsSeparatedByString:@"="];
        if (getArr.count != 2) {
            continue;
        } else {
            [dic setValue:[getArr lastObject] forKey:[getArr firstObject]];
        }
    }
    return dic;
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

/**
 url编码
 */
+ (NSString *)encodeUrlWithUrlStr:(NSString *)urlStr{
   return  [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLUserAllowedCharacterSet]];
}

/**
 url解码
 */
+ (NSString *)decodeUrl:(NSString *)str{
  return [str stringByRemovingPercentEncoding];
}

/**
     url编码
     encodeURL方法不会对下列字符编码 ASCII字母 数字 ~!@#$&*()=:/,;?+'
     encodeURIComponent方法不会对下列字符编码 ASCII字母 数字 ~!*()'
     所以encodeURIComponent比encodeURI编码的范围更大。
     实际例子来说，encodeURIComponent会把 http:// 编码成 http%3A%2F%2F 而encodeURL却不会。
 */
+ (NSString *)encodeURIComponent:(NSString *)paraStr{
   return (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)paraStr,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?#[]",
                                                              kCFStringEncodingUTF8));
}

/**
 旋转按钮的剪头
 */
+ (void)rotateBtnArrow:(UIButton *)btn{
    UIImageView *imgView = btn.imageView;
    if (imgView) {
        [UIView animateWithDuration:0.5 animations:^{
            imgView.transform = btn.selected?CGAffineTransformMakeRotation(M_PI):CGAffineTransformRotate(imgView.transform, -M_PI_2);
            if (!btn.selected) {
                imgView.transform = CGAffineTransformRotate(imgView.transform, -M_PI_2);
            }
        }];
    }
}

/**
 显示回弹动画，比如从下划到屏幕内再回弹一点
 */
+ (void)showSpring:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion{
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:5.0f options:UIViewAnimationOptionCurveEaseInOut animations:animations completion:completion];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/*
 过滤字符串中的html标签
 */
+ (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    //过滤&nbsp
    NSArray *sepArr = [html componentsSeparatedByString:@"&nbsp;"];
    html = [sepArr componentsJoinedByString:@" "];
    return html;
}

/**
 根据日期获得星期几
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate{
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

/**
 用某个字符串分割字符串
 originStr  : 原字符串
 decollator : 分割符
 length     : 分割长度
 */
+ (nullable NSString *)separateStr:(nonnull NSString *)originStr decollator:(nonnull NSString *)decollator separateLength:(int)separateLength{
    NSUInteger lenght = originStr.length;
    NSUInteger num = lenght/separateLength+(lenght%separateLength!=0);
    NSMutableString *appendStr = [NSMutableString string];
    for (int i = 0; i < num; i++) {
        [appendStr appendString:[originStr substringWithRange:NSMakeRange(i*separateLength, i==num-1?(lenght%separateLength?:separateLength):separateLength)]];
        if (i!=num-1) {
            [appendStr appendString:decollator];
        }
    }
    return appendStr;
}

/**
 手机号安全处理，加*处理
 */
+ (nullable NSString *)phoneSecureHandle:(nonnull NSString *)phone{
    if (phone.length<11) {
        return phone;
    }
    NSString *securePhone = [NSString stringWithFormat:@"%@****%@",[phone substringToIndex:3],[phone substringFromIndex:phone.length-4]];
    return securePhone;
}

+ (void)showAlterView:(UIViewController *)controller title:(NSString *)title message:(NSString *)message yesBtnTitle:(NSString *)yesTitle noBtnTitle:(NSString *)noTitle  yesBlock:(void (^)(void))yesAction  noBlock:(void (^)(void))noAction{
    

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:1];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:noTitle style:1 handler:^(UIAlertAction * _Nonnull action) {
        noAction();
    }];
    
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:yesTitle style:0 handler:^(UIAlertAction * _Nonnull action) {
        yesAction();
    }];
    
    
    [alertController addAction:actionCancel];
    [alertController addAction:actionOk];
    [controller presentViewController:alertController animated:YES completion:nil];
    
}

+ (UIColor *)colorWithHex:(NSString *)color alpha:(CGFloat)alpha{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

+ (UIColor *)colorWithHex:(NSString *)color{
    return [LLUtils colorWithHex:color alpha:1.f];
}



/**
 旋转imgView的剪头
 */
+ (void)rotateImgViewArrow:(UIImageView *)imgView isSelected:(BOOL)isSelected{
    if (imgView) {
        [UIView animateWithDuration:0.5 animations:^{
            imgView.transform = isSelected? CGAffineTransformRotate(imgView.transform, M_PI) : CGAffineTransformRotate(imgView.transform, -M_PI_2);
            if (!isSelected) {
                imgView.transform = CGAffineTransformRotate(imgView.transform, -M_PI_2);
            }
        }];
    }
}

+ (CGSize )getStringSize:(NSString *)string font:(CGFloat )font width:(CGFloat)width
{
    CGSize titleSize = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    
    return titleSize;
}

@end
