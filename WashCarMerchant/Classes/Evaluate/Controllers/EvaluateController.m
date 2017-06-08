//
//  EvaluateController.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/8.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "EvaluateController.h"
#import "EvaluateDetailController.h"
#import "ReplyController.h"
#import "EvaluateCell.h"
#import "YKCommonFilterView.h"
#import "EvaluateModel.h"
#import "LDPullSearchView.h"
#import "YKSubbranchSelView.h"
@interface EvaluateController ()<YKCommonFilterViewDelegate>

@property (nonatomic,strong)LDPullSearchView *pullSearchView;

@property (nonatomic,strong)NSMutableArray *serverTitleArray;
@property (nonatomic,strong)NSMutableArray *serverIdArray;

@property (nonatomic,copy)NSString *repayStatus;
@property (nonatomic,copy)NSString *repayId;

@property (nonatomic,assign)NSInteger statusSelIndex;
@property (nonatomic,assign)NSInteger serviceSelIndex;

@property (weak, nonatomic) IBOutlet UITableView *aTableView;

@end

@implementation EvaluateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"EvaluateCell" bundle:nil] forCellReuseIdentifier:@"EvaluateCell"];

    self.navigationItem.title = @"口碑评价";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestDataServiceId:_repayId];
}

- (void)requestDataServiceId:(NSString *)serviceId
{
 ws(bself)
    
    if (serviceId != nil) {
         _repayId =serviceId;
    }
   

    [self setScroll:_aTableView firstPageNor:1  pageSize:10 networkCallback:^(NSInteger page, CompletionCallback completionCallback) {

        NSDictionary *param = @{@"key":@"SHOPCOMMENT",
                                @"userId":MemberId,
                                @"isRecall":bself.repayStatus?bself.repayStatus:@"", //0否1是  是否回复@"" 全部
                                @"serviceId":bself.repayId?bself.repayId:@"",//服务类型ID
                                @"pageNo":[NSString stringWithFormat:@"%ld",(long)page],//页码
                                @"pageSize":@"10",//页容量
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

              NSArray *arr =   [EvaluateModel mj_objectArrayWithKeyValuesArray:json[@"commentList"]];
                completionCallback(YES,arr);
                
            }else{
                
                [[UIApplication sharedApplication].keyWindow showCenterToast:json[@"msg"]];
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
//    headerView.backgroundColor = [UIColor colorWithWhite:248/255.0 alpha:1];

    YKCommonFilterView *filterView = [[YKCommonFilterView alloc] initWithFrame:CGRectMake(0,5, kScreenWidth, 40) titles:@[@"服务",@"状态"] isShowImgs:@[@(1),@(1),] interactions:nil  imgTitleIntervals:@[@(-50),@(-50)] titleIntervals:@[@(-5),@(-5)]];
    
    [headerView addSubview:filterView];
    filterView.delegate = self;
    
    return headerView;
}

#pragma mark YKCommonFilterView delegate
- (void)YKCommonFilterView:(YKCommonFilterView *)view clickBtn:(UIButton *)btn
{
    //点击账单时间 订单编号....
    
    if (btn.selected) {

        [YKSubbranchSelView showInView:self.view frame:CGRectMake(0, 64+45, kScreenWidth, 200) delegate:self  dataSource:btn.tag == 0?_serverTitleArray:@[@"全部",@"已回复",@"未回复"] object:@(btn.tag) lastSelIndex:btn.tag == 0 ? _serviceSelIndex : _statusSelIndex];
        
    } else {
        [YKSubbranchSelView dismissFromView:self.view];
    }
}

- (void)YKSubbranchSelView:(YKSubbranchSelView *)view selectedIndex:(NSInteger)selectedIndex{
    [YKSubbranchSelView dismissFromView:self.view];
    
    int tag = [view.object intValue];
    if (tag==0) {
        _serviceSelIndex = view.lastSelIndex;
        
        [self requestDataServiceId:_serverIdArray[selectedIndex]];
        
    } else if (tag==1){
        //选择状态
        _statusSelIndex = view.lastSelIndex;
        
        switch (selectedIndex) {
                
        case 0:
            {
                _repayStatus = @"";
            }
                break;
        case 1:

            {
                _repayStatus = @"1";
            }
                break;
        case 2:
            {
                _repayStatus = @"0";
            }
                break;
                
            default:
                break;
        }
         [self requestDataServiceId:nil];
    }
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

//    return 50;
    tableView.estimatedRowHeight = 50.f;
    tableView.rowHeight =UITableViewAutomaticDimension;
    return tableView.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    ws(bself);
    EvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EvaluateCell"];
    
    cell.operationCallBack = ^(EvaluateModel *model) {// 10 回复  or 20 修改
        
        ReplyController *controller = [[ReplyController alloc] init];
        controller.repleId = model.idStr;
        controller.isRecall = model.isRecall;
        controller.fhContent = model.fhContent;
        [bself.navigationController pushViewController:controller  animated:YES];;
    };
    cell.model = self.contentArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EvaluateModel *model = self.contentArr[indexPath.row];
    
    EvaluateDetailController *vc = [[EvaluateDetailController alloc]init];
    vc.repleId = model.idStr;
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)dealloc
{
    NSLog(@"%@ 内存释放",self.navigationItem.title);
}

@end
