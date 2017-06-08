//
//  LDPullSearchView.m
//  LimiBuyer
//
//  Created by 厘米科技 on 16/6/29.
//  Copyright © 2016年 limi360. All rights reserved.
//

#import "LDPullSearchView.h"

@interface LDPullSearchView ()

@property (nonatomic,copy)NSArray *dataArray;
@property (nonatomic,strong)UIView *baseView;
@end

@implementation LDPullSearchView

- (id)initWithFrame:(CGRect)frame dataArray:(NSArray *)array
{
    if (self = [super initWithFrame:frame]) {
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        bgView.backgroundColor = [UIColor lightGrayColor];
        bgView.alpha  = 0.3;
        [self addSubview:bgView];
        
        UITapGestureRecognizer *tap =   [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remove)];
        
        [bgView addGestureRecognizer:tap ];
        
        _dataArray = array;
        
        [self createIndex];
    }
    return self;
}


- (void)remove
{
    if (self.removeSelfCallBack) {
        self.removeSelfCallBack(@"");
    }
}
- (void)createIndex
{
    ws(bself);
    _baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bself.width, 0)];
    _baseView.backgroundColor = WhiteColor;
    _baseView.clipsToBounds = YES;
    [self addSubview:_baseView];
    
    [UIView animateWithDuration: 0.2 delay:0.1 options: UIViewAnimationOptionCurveEaseInOut animations: ^{
        
        bself.baseView.frame = CGRectMake(0, 0, bself.width, _dataArray.count/4*30+50);
        
    } completion: ^(BOOL finished) {
    }];

    double kong = (kScreenWidth -200)/5;
    int width = 50;
    
    for (int i = 0; i < _dataArray.count ; i ++) {
        
        UIButton *btn = [self createButtonTitle:_dataArray[i][@"title"]  tag:100];
        
        btn.frame = CGRectMake(i%4*(width +kong)+kong , i/4*30  + 20, 50, 20);
        
        [btn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            
            UIButton *btnn = (UIButton *)sender;
            btnn.selected = !btnn.selected;
            
            [bself changeColorWithButton:btnn WithOtherTag:100];
            
            if (bself.idCallBack) {
                bself.idCallBack(_dataArray[i][@"id"]);
            }
        }];
        
        [_baseView addSubview:btn];
    }
}

- (UIButton *)createButtonTitle:(NSString *)string tag:(int)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = tag;
    
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 10;
    btn.titleLabel.font = HeiTiSize(22);
    [btn setTitle:string forState:UIControlStateNormal];
    [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
    btn.backgroundColor = GrayColor;
    return btn;
}

- (UIButton *)createDataBtnWtihTop:(int)top
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn  = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, top, 120, 20);
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 10;
    btn.layer.borderWidth = 1;
    btn.titleLabel.font = HeiTiSize(22);
    btn.layer.borderColor = [UIColor grayColor].CGColor;// WS_Color_Line.CGColor;
    [btn setTitleColor: [UIColor colorWithHexString:@"#333333"]forState:UIControlStateNormal];
//    [self addSubview:btn];
    
    return btn;
}

- (void)changeColorWithButton:(UIButton *)btn WithOtherTag:(int)tag
{
    for (NSObject *obj in _baseView.subviews ) {
        
        if ([obj isKindOfClass:[UIButton class]]) {
            
            UIButton *btnn = (UIButton *)obj;
            if (btnn == btn) {
                
                if (btnn.selected) {
                    btnn.backgroundColor =  APPColor;//WS_Color_Nav;
                }else{
                    btnn.backgroundColor = APPColor;//WS_Color_666666;
                }
                      
            }else if (btnn.tag == tag){
                btnn.selected = NO;
                btnn.backgroundColor  = GrayColor;
            }
        }
    }
}

- (void)removeSelf{
    WS(bself);
    
    [UIView animateWithDuration: 0.2 delay:0.1 options: UIViewAnimationOptionCurveEaseInOut animations: ^{
        
        bself.baseView.frame = CGRectMake(0, 0, bself.width, 0);
        
    } completion: ^(BOOL finished) {

        [bself removeFromSuperview];
        
    }];
   
}

@end
