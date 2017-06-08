//
//  YKCommonFilterView.m
//  MerchantCenter
//
//  Created by kevin on 2017/2/24.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import "YKCommonFilterView.h"
#import "UIButton+KZExtension.h"

@interface YKCommonFilterView ()

@property (nonatomic, strong) UIView *btnBgView;

@property (nonatomic, strong) NSArray *titles;       //标题
@property (nonatomic, strong) NSArray *isShowImgs;   //是否显示下拉图片
@property (nonatomic, strong) NSArray *interactions; //是否可以交互
@property (nonatomic, assign) NSArray *imgTitleIntervals;//图片文字间隔
@property (nonatomic, assign) NSArray *titleIntervals;//图片文字间隔

@end

@implementation YKCommonFilterView

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles isShowImgs:(NSArray *)isShowImgs interactions:(NSArray *)interactions imgTitleIntervals:(NSArray *)imgTitleIntervals titleIntervals:(NSArray *)titleIntervals{
    if (self = [super initWithFrame:frame]) {
        _titles = titles;
        _isShowImgs = isShowImgs;
        _interactions = interactions;
        _imgTitleIntervals = imgTitleIntervals;
        _titleIntervals   = titleIntervals;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    _btnBgView = [UIView new];
    [self addSubview:_btnBgView];
    _btnBgView.frame = self.bounds;
    CGRect frame = _btnBgView.frame;
    frame.origin.x -= 10;
    _btnBgView.frame = frame;
    
    UIView *lineView = [UIView new];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(0.5f);
    }];
    lineView.backgroundColor = kSepLineColor;
    
    int row = 1; //总行数
    int col = (int)_titles.count; //总列数
    
    CGFloat btnWidth = kScreenWidth /col;
    CGFloat btnHeight = CGRectGetHeight(_btnBgView.frame);
    
    if (isEmptyArr(_titles)) {
        return;
    }
    NSArray *btnNameArr = @[_titles
                            ];
    
    for (int i = 0; i < row; i++) {
        
        for (int j = 0; j < col; j++) {
            UIButton *aBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.btnBgView addSubview:aBtn];
            aBtn.frame = CGRectMake(10+j*btnWidth, i*btnHeight, btnWidth, btnHeight);
            [aBtn setTitle:btnNameArr[i][j] forState:UIControlStateNormal];

            [aBtn setTitleColor:[UIColor colorWithWhite:50/255.0 alpha:1] forState:UIControlStateNormal];

            aBtn.titleLabel.font = Font14;

            aBtn.tag = i*col+j;
            if ( !_isShowImgs || (_isShowImgs && [_isShowImgs[i*col+j] boolValue])) {

                UIImageView *imgView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"xiala"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
                [aBtn addSubview:imgView];
                
                [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.offset(0);
                    make.right.offset(-10+(_imgTitleIntervals?[_imgTitleIntervals[i*col+j] floatValue]:0));
//                    make.width.height.offset(15);
                }];

                imgView.tintColor = [UIColor colorWithHexString:@"323232"];
                imgView.tag = 101;

               
            }
            CGFloat interval = -10+(_titleIntervals?[_titleIntervals[i*col+j] floatValue]:0);
            aBtn.titleEdgeInsets = UIEdgeInsetsMake(0,interval, 0, -interval);

            aBtn.userInteractionEnabled = _interactions?[_interactions[i*col+j] boolValue]:YES;
            [aBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];

        }
    }
}

- (void)clickBtn:(UIButton *)btn{
    if (_lastSelBtn != btn && _lastSelBtn.selected) {
        _lastSelBtn.selected = NO;
        [self rotateArrow:_lastSelBtn];
//        return;
    }
    btn.selected = !btn.selected;
    _lastSelBtn = btn;
//    btn.selected = !btn.selected;
    [self rotateArrow:btn];
    if (_delegate && [_delegate respondsToSelector:@selector(YKCommonFilterView:clickBtn:)]) {
        [_delegate YKCommonFilterView:self clickBtn:btn];
    }
}

- (void)rotateArrow:(UIButton *)btn{
    UIImageView *imgView = [btn viewWithTag:101];
    if (imgView) {
        [UIView animateWithDuration:0.5 animations:^{
            imgView.transform = btn.selected?CGAffineTransformMakeRotation(M_PI):CGAffineTransformRotate(imgView.transform, -M_PI_2);
            if (!btn.selected) {
                imgView.transform = CGAffineTransformRotate(imgView.transform, -M_PI_2);
            }
        }];
    }
}

@end
