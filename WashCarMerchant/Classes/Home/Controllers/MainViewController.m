//
//  MainViewController.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/4.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "MainViewController.h"
#import "MerchantConfirmController.h"
#import "EvaluateController.h"
#import "FinancialControlController.h"
#import "MineController.h"
#import "HomeTopBarCell.h"
#import "HomeNotiCell.h"
#import "HomeParkingCell.h"
#import "HomeCarDataCell.h"
#import "HomeNoticeCell.h"
#import "HomeMainModel.h"
#import "OrderController.h"
#import "WashCarMerchant-Swift.h"
#import "OrderDetailController.h"
#import "YKSignController.h"
#import "YKNoticModel.h"
#import "MessageController.h"

@interface MainViewController ()
{
    NSTimer *countDownTimer;
    
    BOOL isonLine;//是否已经上线
}
@property (weak, nonatomic) IBOutlet UIButton *onLineBtn;//上线
@property (weak, nonatomic) IBOutlet UIButton *outLineBtn;//下线
@property (nonatomic,copy)NSArray *noticArray;//公告数组
@property (nonatomic,assign)NSInteger noReadNum;//未读消息数量

@end

@implementation MainViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [countDownTimer invalidate];
    countDownTimer = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setTimer];
    [self getMsgData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"快快洗车行";
    
    [self starApp];//启动app
    [self getNotic];//请求公告
    
    [self setLeftText:nil textColor:nil ImgPath:@"qiandao"];
    [self setRightText:nil textColor:nil ImgPath:@"new"];
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"HomeNotiCell" bundle:nil] forCellReuseIdentifier:@"HomeNotiCell"];
    [self.aTableView registerNib:[UINib nibWithNibName:@"HomeParkingCell" bundle:nil] forCellReuseIdentifier:@"HomeParkingCell"];
    [self.aTableView registerNib:[UINib nibWithNibName:@"HomeCarDataCell" bundle:nil] forCellReuseIdentifier:@"HomeCarDataCell"];
    [self.aTableView registerNib:[UINib nibWithNibName:@"HomeNoticeCell" bundle:nil] forCellReuseIdentifier:@"HomeNoticeCell"];
    
    //forHeaderFooterView
    [self.aTableView registerNib:[UINib nibWithNibName:@"HomeTopBarCell" bundle:nil] forHeaderFooterViewReuseIdentifier:@"HomeTopBarCell"];
}

- (void)clickLeftBtn:(UIButton *)leftBtn{
    //点击签到
    [self.navigationController pushViewController:[YKSignController new] animated:YES];
}

- (void)clickRightBtn:(UIButton *)rightBtn{
    //点击消息
    [self.navigationController pushViewController:[YKMessageController new] animated:YES];
//    [self.navigationController pushViewController:[MessageController new] animated:YES];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        ws(bself);
        HomeTopBarCell *cell = [[NSBundle mainBundle] loadNibNamed:@"HomeTopBarCell" owner:nil options:nil][0];
        
        cell.topCallBack = ^(UIButton*button ){
            
            [bself topJumpVC:button.tag];
        };
        
        return cell;
    }
    
    return [UIView new];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return kWidthScale*100;
    }
    else{
        return CGFLOAT_MIN;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 4){
        return 0;
    }
    
    return 5.0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    
    switch (indexPath.section) {
        case 0:
            return 90;
            break;
        case 1:
            return 270./2.;
            break;
        case 2:
            return 250./2.;
            break;
        case 3:
            return 120;// 310./2.;
            break;
        default:
            break;
    }
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    ws(bself);
    switch (indexPath.section) {
        case 0:
        {
            HomeNotiCell *notiCell = [tableView dequeueReusableCellWithIdentifier:@"HomeNotiCell"];
            notiCell.notiTitleLab.text = @"行车已经上线.........";
            [notiCell setLineStatus:YES];
            
            return notiCell;
        }
            break;
        case 1:
        {
            HomeParkingCell *parkingCell = [tableView dequeueReusableCellWithIdentifier:@"HomeParkingCell"];
            parkingCell.detaleCallCack = ^(HomeMainModel *model){
                
                OrderDetailController *vc = [[OrderDetailController alloc]init];
                
                //                vc.orderId = model.id;
                [bself.navigationController pushViewController:vc animated:YES];
            };
            return parkingCell;
            
        }
            break;
        case 2:
        {
            HomeCarDataCell *carDataCell = [tableView dequeueReusableCellWithIdentifier:@"HomeCarDataCell"];
            
            carDataCell.changeDayDataCallBack = ^(NSInteger selectedIndex) {//0 本周  1 本月
                
            };
            return carDataCell;
        }
            break;
        case 3:
        {
            HomeNoticeCell *noticeCell = [tableView dequeueReusableCellWithIdentifier:@"HomeNoticeCell"];
            
            NSMutableArray *array = [NSMutableArray array];
            
            for (YKNoticModel *model in self.noticArray) {
                
                [array addObject:model.content];
            }
            noticeCell.notics  = array;
            
            noticeCell.noticCallBack = ^(NSString *messId) {
                
                YKMessageListVC *vc = [[YKMessageListVC alloc]init];
                [vc setTypeWithType:3];
                [bself.navigationController pushViewController:vc animated:YES];
                
            };
            
            return noticeCell;
            
        }
            break;
            
        default:
            break;
    }
    
    return [UITableViewCell new];
    
}

- (void)topJumpVC:(NSInteger )tag{
    
    switch (tag) {
        case 10:
        {
            MerchantConfirmController *VC = [[MerchantConfirmController alloc]init];
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }
            break;
        case 20:
        {
            EvaluateController *VC = [[EvaluateController alloc]init];
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }
            break;
        case 30:
        {
            
            FinancialControlController *VC = [[FinancialControlController alloc]init];
            
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 40:
        {
            
            OrderController *VC = [[OrderController alloc]init];
            
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 50:
        {
            MineController *VC =   [[MineController alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        default:
            break;
    }
}

- (IBAction)changeUserStatusClick:(UIButton*)sender {
    
    
    HomeNotiCell *cell = [_aTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    if (!isonLine && sender.tag == 1) {//上线
        
        
        [self.onLineBtn setTitle:@"接单中..." forState:0];
        
        self.outLineBtn.hidden = NO;
        
        [cell setLineStatus:NO];
        //        [self requstOutLineOrOnLineKey:@"STARTAPP" userId:MemberId];
        isonLine = YES;
    }else if (isonLine && sender.tag == 1){
        [self.view showCenterToast:@"车行已经在上线状态哦"];
    }
    
    if (isonLine && sender.tag != 1){//下线
        
         [self.onLineBtn setTitle:@"上线" forState:0];
        
        self.outLineBtn.hidden = YES;
         [cell setLineStatus:YES];
        //        [self requstOutLineOrOnLineKey:@"STOPTAPP" userId:MemberId];
        isonLine  = NO;
    }else if (!isonLine && sender.tag != 1){
        [self.view showCenterToast:@"车行已经在下线状态哦"];
    }
}

//设置定时器
- (void)setTimer
{
    if (!countDownTimer) {
        countDownTimer = [NSTimer timerWithTimeInterval:3.0f target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        //将定时器添加到runloop中
        [[NSRunLoop currentRunLoop] addTimer:countDownTimer forMode:NSRunLoopCommonModes];
    }
}
-(void)timeFireMethod
{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:3];
    
    HomeNoticeCell * cell = [self.aTableView cellForRowAtIndexPath:indexPath];
    
    [cell doAnimation];
    
}

- (void)requstIsOutLine:(BOOL )isOutLine
{
    ws(bself)
    
    NSString *key = isOutLine?@"STARTAPP":@"STOPTAPP";
    
    NSDictionary *param = @{@"key":key,
                            @"userId":MemberId,
                            };
    
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
        
        RC0001;
        
        [bself.view showCenterToast:@""];
        
        [bself.aTableView reloadData];
        
    } fail:^{
        
    }];
}

- (void)showSign
{
    ws(bself);
    
    [YKSignRemindView show:^(UIView * view, UIButton * btn) {
        
        [bself.navigationController pushViewController:[YKSignController new] animated:YES];
        
    }];
}

- (void)starApp
{
    ws(bself);
    
    NSDictionary *param = @{@"key":@"STARTAPP",
                            @"userId":MemberId,
                            };
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
        
        if ([json[@"code"] isEqualToString:@"10002"]) {// 10002表示需要签到提醒
            
            [bself showSign];
            
        }else if ([json[@"code"] isEqualToString:@"10003"]){//10003 表示不需要签到提醒
            
        }
        
    } fail:^{
        
    }];
}


- (void)getMsgData
{
    ws(bself);
    NSDictionary *param = @{
                            @"key":@"NOMSGREADCOUNT",
                            @"userId":MemberId,
                            };
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
        
        if (![json[@"code"] isEqualToString:@"10000"]) {
            return ;
        }
        
        bself.noReadNum = [json[@"notReadCount"] integerValue];
        
    } fail:^{
        
    }];
}

- (void)getNotic
{
    ws(bself);
    NSDictionary *param = @{
                            @"key":@"ANNOUNCEMENT",
                            @"stat":@"1",// 0代表会员，1代表代理商
                            @"pageNO":@"1",
                            @"pageSize":@"100",
                            };
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
        bself.noticArray =[YKNoticModel mj_objectArrayWithKeyValuesArray:json[@"messList"]];
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:3];
        [bself.aTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:0];
        
    } fail:^{
        
    }];
}

- (void)setNoReadNum:(NSInteger)noReadNum
{
    _noReadNum = noReadNum;
    
    if (_noReadNum == 0) {
        
        return;
    }
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 7, 7)];
    view.backgroundColor = RedColor;
    view.tag = 999;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 3.5;
    
    UIBarButtonItem *msgBtn = self.navigationItem.rightBarButtonItem;

    UIButton *btn = [msgBtn customView];
    
    UIView *vvv = [btn viewWithTag:999];
    [vvv removeFromSuperview];
    
    if (btn.tag == 888) {

        view.right = btn.width+10;
        view.top = 0;
        
        [btn addSubview:view];
    }
}
@end
