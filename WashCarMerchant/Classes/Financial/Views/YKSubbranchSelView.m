//
//  YKSubbranchSelView.m
//  MerchantCenter
//
//  Created by kevin on 2017/2/22.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#define kSubbranchTag 1122

#import "YKSubbranchSelView.h"

@interface YKSubbranchSelView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, assign) CGRect tableFrame;

@property (nonatomic, strong) NSArray <NSString *> *dataSource;

@end

@implementation YKSubbranchSelView

+ (void)showInView:(UIView *)superView frame:(CGRect)frame delegate:(id)delegate dataSource:(NSArray <NSString *> *)dataSource object:(id)object lastSelIndex:(NSInteger)lastSelIndex{
    [YKSubbranchSelView dismissFromView:superView];
    YKSubbranchSelView *view = [[YKSubbranchSelView alloc] initWithFrame:frame dataSource:dataSource];
    [superView addSubview:view];
    view.object = object;
    view.delegate = delegate;
    view.lastSelIndex = lastSelIndex;
}

- (id)initWithFrame:(CGRect)frame dataSource:(NSArray <NSString *> *)dataSource{
    if (self = [super initWithFrame:CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), kScreenHeight-CGRectGetMinY(frame))]) {
        self.tag = kSubbranchTag;
        _tableFrame = frame;
        _dataSource = dataSource;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    self.layer.masksToBounds = YES;
    
    _coverView = [UIView new];
    [self addSubview:_coverView];
    _coverView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [_coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCoverView)]];
    _coverView.alpha = 0;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(-CGRectGetHeight(self.tableFrame));
        make.left.right.offset(0);
        make.height.offset(CGRectGetHeight(self.tableFrame));
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:5.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _coverView.alpha = 1;
        _tableView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(self.tableFrame));
    } completion:nil];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section   {
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.text = _dataSource[indexPath.row];
    cell.textLabel.font = Font14;
    cell.accessoryType = _lastSelIndex == indexPath.row ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
//    if (_model.selDic) {
//        cell.accessoryType = _model.selDic==areaDic?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
//    } else {
//        cell.accessoryType = indexPath.section==0&&indexPath.row==0?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _lastSelIndex = indexPath.row;
    if (_delegate && [_delegate respondsToSelector:@selector(YKSubbranchSelView:selectedIndex:)]) {
        [_delegate YKSubbranchSelView:self selectedIndex:indexPath.row];
    }
}

- (void)tapCoverView{
    [YKSubbranchSelView dismissFromView:self.superview];
}

+ (void)dismissFromView:(UIView *)superView{
    YKSubbranchSelView *view = [superView viewWithTag:kSubbranchTag];
    if(view){
        if (view.delegate && [view.delegate respondsToSelector:@selector(YKSubbranchSelViewDismiss:)]) {
            [view.delegate YKSubbranchSelViewDismiss:view];
        }
        view.tag = 0; //复位view tag
        [UIView animateWithDuration:0.5 animations:^{
            view.tableView.transform = CGAffineTransformIdentity;
            view.coverView.alpha = 0;
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
