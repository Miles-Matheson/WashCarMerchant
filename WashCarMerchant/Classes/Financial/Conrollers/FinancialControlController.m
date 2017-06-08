//
//  FinancialControlController.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/10.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "FinancialControlController.h"
#import "YKFourLblCell.h"
#import "YKPayDetailHeader.h"
#import "YKCommonFilterView.h"
#import "BackMoneyViewController.h"
#import "BackMoneyDetailController.h"
#import "YKSubbranchSelView.h"
#import "FinancialModel.h"

@interface FinancialControlController ()<YKCommonFilterViewDelegate,YKPayDetailHeaderDelegate,YKSubbranchSelViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *aTableView;
@property (nonatomic,assign)NSInteger lastSelectIndex;
@property (nonatomic,copy)NSString *balance;//结算金额
@property (nonatomic,copy)NSString *endDate;//截止时间
@end

@implementation FinancialControlController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"财务管理";
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"YKFourLblCell" bundle:nil] forCellReuseIdentifier:@"YKFourLblCell"];
    
    [self requestMainData];
}

- (void)requestMainData
{
    ws(bself);
    [self setScroll:_aTableView firstPageNor:1 pageSize:10 networkCallback:^(NSInteger page, CompletionCallback completionCallback) {
        
        NSDictionary *param = @{
                                @"key":@"MERSETTLEMENTLIST",
                                @"userId":MemberId,
                                @"pageNo":[NSString stringWithFormat:@"%ld",page],
                                @"pageSize":@"10",
                                };
        [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:YES success:^(id json) {
            
            RC0001
            
            bself.balance  = json[@"balance"];
            bself.endDate  = json[@"endDate"];
            
            NSArray *array = [FinancialModel mj_objectArrayWithKeyValuesArray:json[@"mersettlementList"]];
            
            completionCallback(YES,array);
            
        } fail:^{
            completionCallback(NO,@[]);
        }];
        
    } noMoreDataCallback:^(NSInteger page) {
        
        if (page!= 1) {
            [bself.view showCenterToast:@"没有更多数据"];
        }
    }];
    [self silenceRefresh];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50+5+70+5+40 -50 +5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor colorWithWhite:248/255.0 alpha:1];
    //财务管理
    
    NSArray *payDetailArr = [[NSBundle mainBundle] loadNibNamed:@"YKPayDetailHeader" owner:nil options:nil];
    //        if (payDetailArr.count) {
    YKPayDetailHeader *payDetailHeader = payDetailArr[0];
    [headerView addSubview:payDetailHeader];
    
    payDetailHeader.frame = CGRectMake(0, 5, kScreenWidth, 70);
    payDetailHeader.delegate = self;
    
    NSMutableAttributedString *attStr = [NSMutableAttributedString attributeStringWithText:@"结算金额：" attributes:@[payDetailHeader.topLbl.font,payDetailHeader.topLbl.textColor]];
    
    [attStr appendText:[NSString stringWithFormat:@"¥%@",[LLUtils strRelay:self.balance]] withAttributesArr:@[payDetailHeader.topLbl.font,BlackColor]];
    payDetailHeader.topLbl.attributedText = attStr;
    
    
    if (self.endDate.length < 1) {
        payDetailHeader.bottomLbl.text = @"";
        payDetailHeader.topLabTopCons.constant = 30;
    }else{
        NSMutableAttributedString *attPayStr = [NSMutableAttributedString attributeStringWithText:@"截止时间：" attributes:@[payDetailHeader.topLbl.font,payDetailHeader.topLbl.textColor]];
        
        [attPayStr appendText:[NSString stringWithFormat:@"%@",[LLUtils strRelay:self.endDate]] withAttributesArr:@[payDetailHeader.topLbl.font,LightGrayColor]];
        
        payDetailHeader.bottomLbl.attributedText = attPayStr;
    }

    YKCommonFilterView *filterView = [[YKCommonFilterView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(payDetailHeader.frame)+5, kScreenWidth, 40) titles:@[@"账单时间",@"订单编号",@"结算类型",@"结算金额"] isShowImgs:@[@"0",@"",@"",@""] interactions:@[@(0),@(0),@(0),@(0)]  imgTitleIntervals:@[@(5),@(0),@(0),@(0)] titleIntervals:@[@(0),@(0),@(0),@(0),@(0)]];
    
    [headerView addSubview:filterView];
    filterView.delegate = self;
    
    
    return headerView;
}

#pragma mark YKPayDetailHeader delegate
- (void)YKPayDetailHeader:(YKPayDetailHeader *)header clickRightBtn:(UIButton *)rightBtn
{
    //跳转到提款界面
    BackMoneyViewController *vc =[[BackMoneyViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark YKCommonFilterView delegate
- (void)YKCommonFilterView:(YKCommonFilterView *)view clickBtn:(UIButton *)btn
{
    //点击账单时间 订单编号....
    
    if (btn.selected) {
        [YKSubbranchSelView showInView:self.view frame:CGRectMake(0, 65 +64+50, kScreenWidth, 200) delegate:self dataSource:[self getTheLastMonth] object:@(btn.tag) lastSelIndex:_lastSelectIndex];
    } else {
        
        [YKSubbranchSelView dismissFromView:self.view];
    }
}

- (void)YKSubbranchSelView:(YKSubbranchSelView *)view selectedIndex:(NSInteger)selectedIndex{
    
    _lastSelectIndex = selectedIndex;
    
    if (view.tag==0) {
        
    }
    [YKSubbranchSelView dismissFromView:self.view];
}

- (void)YKSubbranchSelViewDismiss:(YKSubbranchSelView *)view
{
    [_aTableView reloadData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    YKFourLblCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKFourLblCell"];
    cell.model = self.contentArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YKFourLblCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    BackMoneyDetailController *VC = [[BackMoneyDetailController alloc]init];
    VC.mersettlementId = cell.model.idStr;
    [self.navigationController pushViewController:VC animated:YES];
}

- (NSArray *)getTheLastMonth
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSDate*nowDate = [NSDate date];
    
    NSDate* theDate;
    
    NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
    
    for (int i = 1; i < 31; i ++) {
        
        
        theDate = [nowDate initWithTimeIntervalSinceNow: -oneDay*1];
        NSString *str =[LLUtils dateStrWithDate:theDate dateFormat:@"yyyy-MM-dd"];
        
        [array addObject:str];
    }
    
    return array;
}

-(void)dealloc
{
    NSLog(@"%@ 内存释放",self.navigationItem.title);
}
@end
