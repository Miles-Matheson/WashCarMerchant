
//
//  OrderController.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/10.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "OrderController.h"
#import "OrderListCell.h"
#import "YKCommonFilterView.h"
#import "YKSubbranchSelView.h"
#import "OrderDetailController.h"
#import "OrderModel.h"

@interface OrderController ()<YKCommonFilterViewDelegate ,YKSubbranchSelViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *aTableView;
@property (nonatomic,copy)NSString *stat;
@property (nonatomic,copy)NSString *serviceId;
@property (nonatomic,assign)NSInteger statusSelIndex;
@property (nonatomic,assign)NSInteger serviceSelIndex;
@property (nonatomic,copy)NSArray *statusArray;
@property (nonatomic,strong)NSMutableArray *serverTitleArray;
@property (nonatomic,strong)NSMutableArray *serverIdArray;

@end

@implementation OrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"洗车订单";
   
    [self.aTableView registerNib:[UINib nibWithNibName:@"OrderListCell" bundle:nil] forCellReuseIdentifier:@"OrderListCell"];
    
    _statusArray = @[@"全部",@"待付款",@"待洗车",@"待确认",@"已完成",@"已取消",@"已过期"];//0待付款、1待洗车、2待确认、3已完成、4已取消、5已过期
    
    [self requestData];
}

- (void)requestData
{
    ws(bself)

    _serviceId = _serverIdArray[_serviceSelIndex];

    [self setScroll:self.aTableView firstPageNor:1 pageSize:2 networkCallback:^(NSInteger page, CompletionCallback completionCallback) {
        
        NSDictionary *param = @{@"key":@"SHOPORDER",
                                @"userId":MemberId,//1:IOS 2:安卓
                                @"stat":bself.stat?bself.stat:@"",//0待付款、1待洗车、2待确认、3已完成、4已取消、5已过期
                                @"serviceId":bself.serviceId?bself.serviceId:@"",//服务类型ID
                                @"pageNo":[NSString stringWithFormat:@"%ld",page],//页码
                                @"pageSize":@"2",//也容量
                                };
        
        [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:YES success:^(id json) {
            
            if ([json[@"code"] isEqualToString:@"10000"]) {

                bself.serverTitleArray = [NSMutableArray array];
                bself.serverIdArray  =   [NSMutableArray array];
                [bself.serverTitleArray addObject:@"全部"];
                [bself.serverIdArray addObject:@""];
                
                NSArray *array =  json[@"serviceList"];
                
                for (NSDictionary *dic in array) {
                    
                    [bself.serverTitleArray addObject:dic[@"carServiceNm"]];
                    [bself.serverIdArray addObject:dic[@"id"]];
                }
                
                NSArray * orderList =  [OrderModel mj_objectArrayWithKeyValuesArray:json[@"orderList"]];
                
                completionCallback(YES,orderList);
            }
        } fail:^{
            
             completionCallback(NO,@[]);
            
        }];

    }noMoreDataCallback:^(NSInteger page) {
        
        if (page!= 1) {
            [bself.view showCenterToast:@"没有更多数据"];
        }
    }];
    [self silenceRefresh];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor colorWithWhite:248/255.0 alpha:1];
//
    YKCommonFilterView *filterView = [[YKCommonFilterView alloc] initWithFrame:CGRectMake(0,5, kScreenWidth, 40) titles:@[@"订单编号",@"服务",@"顾客",@"状态",@"消费时间"] isShowImgs:@[@"0",@"1",@"0",@"1",@"0"] interactions:@[@(0),@(1),@(0),@(1),@(0)]  imgTitleIntervals:@[@(0),@(10),@(0),@(5),@(0)] titleIntervals:@[@(10),@(10),@(10),@(5),@(10)]];
    
    [headerView addSubview:filterView];
    filterView.delegate = self;
    
    
    return headerView;
}
#pragma mark YKCommonFilterView delegate
- (void)YKCommonFilterView:(YKCommonFilterView *)view clickBtn:(UIButton *)btn
{
    //点击账单时间 订单编号....
    
    if (btn.selected) {

        [YKSubbranchSelView showInView:self.view frame:CGRectMake(0,64+45, kScreenWidth, 200) delegate:self dataSource:btn.tag == 1?self.serverTitleArray:self.statusArray object:@(btn.tag) lastSelIndex:btn.tag == 1?_serviceSelIndex:_statusSelIndex];
    } else {

        [YKSubbranchSelView dismissFromView:self.view];
    }
}
- (void)YKSubbranchSelView:(YKSubbranchSelView *)view selectedIndex:(NSInteger)selectedIndex
{
    [YKSubbranchSelView dismissFromView:self.view];
    
    int tag = [view.object intValue];
    
    if (tag==1) {//选择服务
        
        _serviceSelIndex = view.lastSelIndex;

       
        
    } else if (tag==3){//选择状态
        
        if (view.lastSelIndex == 0) {
            
            _stat = @"";
            
        }else{
             _stat = [NSString stringWithFormat:@"%ld",view.lastSelIndex-1];
        }
    }
    
     [self requestData];
}
- (void)YKSubbranchSelViewDismiss:(YKSubbranchSelView *)view
{
    [self.aTableView reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 55;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderListCell"];
    cell.model = self.contentArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OrderDetailController *vc = [[OrderDetailController alloc]init];
    
    OrderListCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    vc.orderId = cell.model.orderId;
    
    vc.orderState = [cell.model.stat intValue];
    
    [self.navigationController   pushViewController:vc animated:YES];
}

-(void)dealloc
{
    NSLog(@"%@ 内存释放",self.navigationItem.title);
}
@end
