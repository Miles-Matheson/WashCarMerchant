//
//  YKSignController.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/22.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "YKSignController.h"
#import "YKSignTopCell.h"
#import "YKSignRuleCell.h"
#import "BQLCalendar.h"
@interface YKSignController ()
@property (weak, nonatomic) IBOutlet UITableView *aTableView;
@property (nonatomic,strong)NSMutableDictionary *dataDic;
@property (nonatomic,strong)BQLCalendar *calendar;

@end

@implementation YKSignController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"签到";
    self.aTableView.tableFooterView = [UIView new];
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"YKSignTopCell" bundle:nil] forCellReuseIdentifier:@"YKSignTopCell"];
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"YKSignRuleCell" bundle:nil] forCellReuseIdentifier:@"YKSignRuleCell"];
    
    _dataDic = [NSMutableDictionary dictionary];
    
    [self requestData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    if (indexPath.section == 0) {
        return 460./2.0;
    }
    return 345/2.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    ws(bself);
    if (indexPath.section == 0) {
        YKSignTopCell *topCell = [tableView dequeueReusableCellWithIdentifier:@"YKSignTopCell"];
        
        if (_dataDic.count != 0) {
            
            topCell.signDayNum = [[LLUtils strRelay:_dataDic[@"lianxu"]] intValue];//签到天数
            topCell.signType   = [[LLUtils strRelay:_dataDic[@"signed"]] boolValue];//其拿到状态
            topCell.signSwitch = [[LLUtils strRelay:_dataDic[@"type"]] boolValue];//签到开关
        }
        topCell.switchCallBack =^(BOOL select){//签到开关
            [bself requestSignswitch:select];
        } ;

        topCell.signCallBack = ^(BOOL select){//点击签到
            [bself requestSign];
        };
        topCell.signDetailCallBack = ^(BOOL select){//点击签到详情
            [bself requestSignDetailWithDate:[NSDate date]];
        };
        return topCell;
    }
    
    YKSignRuleCell *ruleCell = [tableView dequeueReusableCellWithIdentifier:@"YKSignRuleCell"];
    
    return  ruleCell;
}

- (void)requestData{
    ws(bself)
    NSDictionary *param = @{@"key":@"MYSIGN",
                            @"userId":MemberId,
                            @"type":@"1",//0会员签到 1商家签到
                            };
    
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
        RC0001;
        
        bself.dataDic = json;
        
        [bself.aTableView reloadData];
    } fail:^{
        
    }];
}

- (void)requestSign{
    ws(bself)
    NSDictionary *param = @{@"key":@"SIGN",
                            @"userId":MemberId,
                            @"type":@"1",
                            };
    
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
        RC0001;
        
        [KeyWindow showCenterToast:@"签到成功"];
        
        [bself requestData];
        
    } fail:^{
        
    }];
}

- (void)requestSignswitch:(BOOL)isOpen
{
    NSString *type = isOpen?@"1":@"0";
    
    NSDictionary *param = @{@"key":@"CHANGEREMIND",
                            @"userId":MemberId,
                            @"type":type,//0 关闭  1 开启
                            };
    
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
        RC0001;
        
        [KeyWindow showCenterToast:isOpen?@"提醒已开启":@"提醒已关闭"];
        
    } fail:^{
        
    }];
}

- (void)requestSignDetailWithDate:(NSDate *)date{
    ws(bself)
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    NSInteger currentYear=[[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"MM"];
    NSInteger currentMonth=[[formatter stringFromDate:date]integerValue];
    [formatter setDateFormat:@"dd"];
    NSInteger currentDay=[[formatter stringFromDate:date] integerValue];

    NSDictionary *param = @{@"key":@"SIGNDETAIL",
                            @"year":[NSString stringWithFormat:@"%ld",(long)currentYear],
                            @"month":[NSString stringWithFormat:@"%ld",(long)currentMonth],
                            @"userId":MemberId,
                            };
    
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:YES success:^(id json) {
        RC0001;
        
        NSArray *arr = json[@"qdDays"];
        
        NSMutableArray *signArray = [NSMutableArray array];
        
        for (NSDictionary *dic in arr ) {
            
            NSString *signDate = [LLUtils strRelay:dic[@"day"]];
            [signArray addObject:signDate];
        }
        
        [bself reloadCalendarWithArray:signArray];//刷新日期
        
        
    } fail:^{
        
    }];
}

- (BQLCalendar *)calendar
{
    ws(bself);
    if (!_calendar) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//        view.backgroundColor = RGB_COLOR(245, 250, 250);
        [self.view addSubview:view];
        UIColor *color = [UIColor blackColor];
        view.backgroundColor = [color colorWithAlphaComponent:0.1];
        
        [view addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelf:)]];
        
        _calendar = [[BQLCalendar alloc] initWithFrame:CGRectMake(0, 0, KeyWindow.width-40, KeyWindow.width-30)];
        _calendar.backgroundColor = WhiteColor;
        
        _calendar.center = self.view.center;
        
        _calendar.changeMonthBlock = ^(NSDate *date) {//点击选择月回调
            
            [bself requestSignDetailWithDate:date];
        };
        [view addSubview:_calendar];
    }
    return _calendar;
}
- (void)reloadCalendarWithArray:(NSArray *)array
{
    [self.calendar initSign:array Touch:^(NSDate *date) {
        
//        NSLog(@"点击了日期:%@",date);
    }];
}

- (void)removeSelf:(UITapGestureRecognizer *)tap
{
    
    if (_calendar) {
        [_calendar removeFromSuperview];
        _calendar = nil;
    }
    UIView * view = tap.view;
    [view removeFromSuperview];
    
    
}
-(void)dealloc
{
    NSLog(@"%@ 内存释放",self.navigationItem.title);
}
@end
