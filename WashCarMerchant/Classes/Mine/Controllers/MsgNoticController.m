//
//  MsgNoticController.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/11.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "MsgNoticController.h"
#import "MsgNoticCell.h"
#import "YKCommonFilterView.h"
#import "BindingController.h"
#import "MsgNoticModel.h"

@interface MsgNoticController ()
@property (weak, nonatomic) IBOutlet UITableView *aTableView;
@property (nonatomic,copy)NSArray *dataArray;
@property (nonatomic,copy)NSString *carShopName;
@property (nonatomic,copy)NSString *smsId;//短信提醒id(删除，修改操作时必传)
@property (nonatomic,copy)NSString *rule;//角色（店长，收营员，服务员）添加和修改操作时必传
@property (nonatomic,copy)NSString *phone;//手机号（添加和修改操作时必传
@property (nonatomic,copy)NSString *person;//姓名（添加和修改操作时必传）

@end

@implementation MsgNoticController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requestMainDataWithType:@"2"];
    
//    [self.aTableView silenceRefresh];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"短信提醒";
    
    self.aTableView.tableFooterView = [UIView new];
    [self.aTableView registerNib:[UINib nibWithNibName:@"MsgNoticCell" bundle:nil] forCellReuseIdentifier:@"MsgNoticCell"];
}

- (void)requestMainDataWithType:(NSString *)type
{
    ws(bself)
    
//    [self setScroll:_aTableView firstPageNor:1 networkCallback:^(NSInteger page, CompletionCallback completionCallback) {
    
        
        NSDictionary *param = @{@"key":@"SHOPADDSMSALERTS",
                                @"type":type,//0:删除操作  1：增加或修改操作 2：查询
                                @"userId":MemberId,
                                @"smsId":self.smsId?self.smsId:@"",//短信提醒id(删除，修改操作时必传)
                                @"rule":self.rule?self.rule:@"",//角色（店长，收营员，服务员）添加和修改操作时必传
                                @"phone":self.phone?self.phone:@"",//手机号（添加和修改操作时必传
                                @"person":self.person?self.person:@"",//姓名（添加和修改操作时必传）
                                };
        
        [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
            
            RC0001;
            
            bself.dataArray = [MsgNoticModel mj_objectArrayWithKeyValuesArray:json[@"smsList"]];
            bself.carShopName = json[@"carShopName"];
            [bself.aTableView reloadData];
            
        } fail:^{
            
        }];
        
//        
//    }];
//    [self silenceRefresh];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45 +50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    ws(bself);
    UIView *headerView = [UIView new];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, KeyWindow.width, 45)];
    topView.backgroundColor = WhiteColor;
    [headerView addSubview:topView];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(15, 5, 150/2., 30);
    [btn setTitle:@"绑定手机" forState:0];
    [btn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        [bself editUserInfoWithShopName:bself.carShopName?bself.carShopName:@"" rule:@"" name:@"" phone:@""];
    }];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    btn.backgroundColor = APPColor;
    [btn setTitleColor:WhiteColor forState:0];
    btn.titleLabel.font = kFont13;
    [topView addSubview:btn];
    
    UILabel *lab = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"温馨提示: 最多只能添加5个短信提醒用户" textColor:BlackColor textAlignment:NSTextAlignmentCenter font:kFont12];
    [lab sizeToFit];
    lab.left = btn.right +30;
    lab.centerY = btn.centerY;
    [topView addSubview:lab];
   
    
    UIView *line = [ViewCreate createLineFrame:CGRectMake(0, 44, KeyWindow.width, 0.3) backgroundColor:LightGrayColor];
    line.alpha = 0.8;
    [topView addSubview:line];
    
    headerView.backgroundColor = [UIColor colorWithWhite:248/255.0 alpha:1];
    //
    YKCommonFilterView *filterView = [[YKCommonFilterView alloc] initWithFrame:CGRectMake(0,50, kScreenWidth, 40) titles:@[@"角色",@"手机号",@"姓名",@"操作"] isShowImgs:@[@(0),@(0),@(0),@(0)] interactions:nil  imgTitleIntervals:nil titleIntervals:@[@(10),@(10),@(10),@(0)]];
    
    [headerView addSubview:filterView];
//    filterView.delegate = self;

    return headerView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray?self.dataArray.count:0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    ws(bself);
    __weak MsgNoticCell * bcell  = [tableView dequeueReusableCellWithIdentifier:@"MsgNoticCell"];
    
    bcell.model = self.dataArray[indexPath.row];
    
    bcell.editUserInfo = ^(NSInteger tag) {
        
        if (tag == 10) {
            
            bself.smsId = bcell.idStr;
            
            [bself showAlterView:bcell.model.phone];
            
        }else{
            [bself editUserInfoWithShopName:bcell.model.carshopName rule:bcell.model.rule name:bcell.model.person phone:bcell.model.phone];
        }
    };
    return bcell;
}

- (void)editUserInfoWithShopName:(NSString *)carShopName rule:(NSString *)rule name:(NSString *)name phone:(NSString *)phone
{
    BindingController *vc = [[BindingController alloc]init];
    vc.carShopName = carShopName;
    vc.rule = rule;
    vc.name = name;
    vc.phone = phone;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showAlterView:(NSString *)phone
{
    ws(bself);
    NSString *title =  [NSString stringWithFormat:@"%@\n您确定删除该短信用户提醒吗?",phone];

    [LLUtils showAlterView:self title:@"温馨提示" message:title yesBtnTitle:@"确定" noBtnTitle:@"取消" yesBlock:^{

        [bself requestMainDataWithType:@"0"];
    } noBlock:^{
        
    }];
}

-(void)dealloc
{
    NSLog(@"%@ 内存释放",self.navigationItem.title);
}
@end
