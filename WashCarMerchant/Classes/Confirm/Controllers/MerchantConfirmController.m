//
//  MerchantConfirmController.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/6.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "MerchantConfirmController.h"
#import "LDPullSearchView.h"
#import "YKCommonFilterView.h"
#import "ConfirmCell.h"
#import "YKSubbranchSelView.h"
#import "MerchantModel.h"
@interface MerchantConfirmController ()<YKCommonFilterViewDelegate,YKSubbranchSelViewDelegate,YKSubbranchSelViewDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet UITableView *aTableView;
@property (strong, nonatomic)LDPullSearchView *searchView;
@property (nonatomic,copy)NSArray *dataArray;

@property (nonatomic, assign) NSInteger serviceSelIndex;
@property (nonatomic, assign) NSInteger statusSelIndex;
@property (nonatomic,strong)NSMutableArray *allServiceList;//服务选项
@property (nonatomic,strong)NSMutableArray *allServiceId;//服务选项Id

@property (nonatomic,copy)NSString *type;//服务类型
@property (nonatomic,copy)NSString *serviceId;//服务选项Id

@end

@implementation MerchantConfirmController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"商家确认";
    
    self.aTableView.tableFooterView = [UIView new];
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"ConfirmCell" bundle:nil] forCellReuseIdentifier:@"ConfirmCell"];
    
    [self rerquestData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor colorWithWhite:248/255.0 alpha:1];
    //
    YKCommonFilterView *filterView = [[YKCommonFilterView alloc] initWithFrame:CGRectMake(0,5, kScreenWidth, 40) titles:@[@"服务",@"优惠价",@"门市价",@"状态",@"操作"] isShowImgs:@[@"1",@"0",@"0",@"1",@"0"] interactions:@[@(1),@(0),@(0),@(1),@(0),]  imgTitleIntervals:@[@(0),@(0),@(0),@(0),@(0)] titleIntervals:@[@(-5),@(0),@(0),@(-10),@(0)]];
    
    [headerView addSubview:filterView];
    filterView.delegate = self;
    filterView.tag = 100;
    
    return headerView;
}

- (void)rerquestData
{
    ws(bself);
    
    [self setScroll:_aTableView firstPageNor:1 pageSize:3 networkCallback:^(NSInteger page, CompletionCallback completionCallback) {
        
        
        NSDictionary *param = @{
                                @"key":@"SHOPSERVICE",
                                @"stat":bself.type?bself.type:@"",//0待确认 1已驳回 2已上线 3已下线
                                @"serviceId":bself.serviceId?bself.serviceId:@"",
                                @"userId":MemberId,
                                @"pageNo":[NSString stringWithFormat:@"%ld",(long)page],
                                @"pageSize":@"3",
                                };
        [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
            
            bself.dataArray = [MerchantModel mj_objectArrayWithKeyValuesArray:json[@"serviceList"]];
            
            bself.allServiceList = [[NSMutableArray alloc]initWithObjects:@"全部", nil];
            bself.allServiceId = [[NSMutableArray alloc]initWithObjects:@"", nil];
            
            NSArray *arr = json[@"allServiceList"];
            
            for (NSDictionary *dic in arr) {
                
                [bself.allServiceList addObject:[LLUtils strNilOrEmpty:dic[@"carServiceNm"] elseBack:@""]];
                
                [bself.allServiceId addObject:[LLUtils strNilOrEmpty:dic[@"id"] elseBack:@""]];
            }
            
            completionCallback(YES,bself.dataArray);
            
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

- (void)setStatusWithMaxId:(NSString *)mxId ype:(NSString *)type
{
    
    NSString *notic;
    
    if ([type isEqualToString:@"2"]) {
        notic = @"驳回操作成功";
    }else{
        notic = @"确认操作成功";
    }

    ws(bself);
    NSDictionary *param = @{
                            @"key":@"CONFIRMSERVICE",
                            @"serviceMxId":mxId?mxId:@"",//车行服务类型明细id
                            @"type":type?type:@"",//确认or驳回（确认2  驳回1）
                            };
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:YES success:^(id json) {
        RC0001
        
        [bself.view showCenterToast:notic];
        [bself rerquestData];
        
    } fail:^{
        
    }];
}
#pragma mark YKCommonFilterView delegate
- (void)YKCommonFilterView:(YKCommonFilterView *)view clickBtn:(UIButton *)btn
{
    //点击账单时间 订单编号....
    //状态：0待确认 1已驳回 2已上线 3已下线
    if (btn.selected) {
        [YKSubbranchSelView showInView:self.view frame:CGRectMake(0, 64+45, kScreenWidth, 200) delegate:self  dataSource:btn.tag==0?_allServiceList:@[@"全部",@"待确认",@"已驳回",@"已上线",@"已下线"]  object:@(btn.tag) lastSelIndex:btn.tag == 0 ? _serviceSelIndex : _statusSelIndex];
    } else {
        
        [YKSubbranchSelView dismissFromView:self.view];
    }
}

- (void)YKSubbranchSelView:(YKSubbranchSelView *)view selectedIndex:(NSInteger)selectedIndex{
    [YKSubbranchSelView dismissFromView:self.view];
    int tag = [view.object intValue];
    if (tag==0) {
        _serviceSelIndex = view.lastSelIndex;
        
        self.serviceId = _allServiceId[_serviceSelIndex];
    } else if (tag==3){
        //选择状态
        _statusSelIndex = view.lastSelIndex;
        
        if (_statusSelIndex == 0) {
            self.type = @"";
        }else{
             self.type = [NSString stringWithFormat:@"%ld",(long)_statusSelIndex-1];
        }
    }
    
    [self rerquestData];
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
    
    ws(bself);
    __weak ConfirmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmCell"];
    cell.model = self.contentArr[indexPath.row];
    
    
    cell.caozuoBack = ^(NSInteger tag) {//操作 10 预览  20 确认  30 驳回
        
        NSString *str;
        
        switch (tag) {
            case 20:
            {
            str = @"2";
            }
                break;
            case 30:
            {
               str = @"1";
            }
                break;
                
            default:
                break;
        }
        if (tag != 10) {//确认 or  驳回
            [bself setStatusWithMaxId:cell.model.idStr ype:str];
        }else{//预览
            
        }

    };
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)dealloc
{
    NSLog(@"%@ 内存释放",self.navigationItem.title);
}
@end
