//
//  RankingController.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/24.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "RankingController.h"
#import "RankingTopCell.h"
#import "GradeCell.h"
#import "RankingListCell.h"
#import "YMWebViewController.h"
#import "WebViewController.h"
@interface RankingController ()
@property (weak, nonatomic) IBOutlet UITableView *aTableView;
@property (nonatomic,copy)NSDictionary *dataDic;//topData
@property (nonatomic,copy)NSArray *dataArray;//topData
@property (nonatomic,copy)NSArray *listArray;//topData
@property (nonatomic,assign)float maxNum;//最大成长值
@property (nonatomic,assign)float grow;//当前成长值
@end

@implementation RankingController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"等级";
    self.aTableView.tableFooterView = [UIView new];
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"RankingTopCell" bundle:nil] forCellReuseIdentifier:@"RankingTopCell"];
    [self.aTableView registerNib:[UINib nibWithNibName:@"GradeCell" bundle:nil] forCellReuseIdentifier:@"GradeCell"];
    [self.aTableView registerNib:[UINib nibWithNibName:@"RankingListCell" bundle:nil] forCellReuseIdentifier:@"RankingListCell"];

    [self getTopMainData];
    [self listMainData];
}

- (void)getTopMainData
{
    ws(bself);
    NSDictionary *param = @{
                            @"key":@"ACCOUNT",
                            @"userId":MemberId,
                            };
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
        
        bself.dataDic = json[@"carOwner"];
        bself.dataArray = json[@"levelList"];
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
        NSIndexPath *path2 = [NSIndexPath indexPathForRow:1 inSection:0];
        [bself.aTableView  reloadRowsAtIndexPaths:@[path,path2] withRowAnimation:0];
    } fail:^{
        
    }];
}
- (void)listMainData
{
    ws(bself);
    NSDictionary *param = @{
                            @"key":@"LEVELINFO",
                            @"userId":MemberId,
                            @"pageNo":@"1",
                            @"pageSize":@"10",
                            };
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
        bself.listArray = json[@"integalRecordList"];
        [bself.aTableView reloadData];
        
    } fail:^{
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 5;
    }
    return CGFLOAT_MIN;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else{
        return _listArray.count +1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    if (indexPath.section != 0) {
        return 95./2.0;
    }
    switch (indexPath.row) {
        case 0:
        {
            return 190.0;
        }
            break;
        case 1:
        {
            return 60;
        }
            break;

        default:
            break;
    }
    return 44.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    if (indexPath.section != 0) {

        RankingListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankingListCell"];
        
        
        if (indexPath.row == 0) {
            cell.titleLab.text = @"累计成长值记录";
            cell.centerLab.text = @"";
            cell.lastLab.text = @"";
             return cell;
        }

        NSDictionary *dic = _listArray[indexPath.row-1];
        switch ([dic[@"source"] intValue]) {
            case 0:
            {
             cell.titleLab.text = @"签到";
            }
                break;
            case 1:
            {
              cell.titleLab.text = @"首次注册";
            }
                break;
            case 2:
            {
              cell.titleLab.text = @"支付订单";
            }
                break;
            case 3:
            {
              cell.titleLab.text = @"评价订单";
            }
                break;
            case 4:
            {
               cell.titleLab.text = @"完成个人资料";
            }
                break;
            case 5:
            {
                cell.titleLab.text = @"分享";
            }
                break;
            case 6:
            {
                cell.titleLab.text = @"抽奖";
            }
                break;
                
            default:
                break;
        }

        
        cell.centerLab.text = [LLUtils dateStrWithDate:[LLUtils dateWithDateStr:dic[@"createDate"] dateFormat:@"yyyy-MM-dd"] dateFormat:@"yyyy-MM-dd"];

        if ([dic[@"stat"] intValue] == 0) {
            cell.lastLab.text =  [NSString stringWithFormat:@"+%@",dic[@"value"]];
        }else{
            cell.lastLab.text =  [NSString stringWithFormat:@"-%@",dic[@"value"]];
        }

        return cell;
    }
    switch (indexPath.row) {
        case 0:
        {
            ws(bself);
            
            RankingTopCell *topCell = [tableView dequeueReusableCellWithIdentifier:@"RankingTopCell"];
            topCell.dengjiLab.text =[LLUtils strNilOrEmpty: self.dataDic[@"level"] elseBack:@""];
            
            NSMutableAttributedString *att = [NSMutableAttributedString attributeStringWithText:@"我的累计成长值:" attributes:@[BlackColor,kFont13]];
            
            
            NSString *growthvalue = [NSString stringWithFormat:@"%@",[LLUtils strNilOrEmpty:self.dataDic[@"growthvalue"] elseBack:@""]];
            
            [att appendText:growthvalue withAttributesArr:@[APPColor,kFont13]];

            topCell.cehngzahngzhiLab.attributedText = att ;
            
            _grow =  [self.dataDic[@"growthvalue"] floatValue];
            
            NSString *nsxtTitle = @"";
            int nextTitleCha = 0;
            BOOL isNextTitle = NO;
            
            for (NSDictionary *dic in self.dataArray) {
                
                int mix = [dic[@"small"] intValue];
                int max = [dic[@"big"] intValue];
                
                if (mix <= _grow &&  _grow <  max ) {
                    
                    isNextTitle = YES;
                    
                }else if (isNextTitle){
                    isNextTitle = NO;
                    nsxtTitle = dic[@"title"];
                    nextTitleCha =  [dic[@"small"] intValue] - _grow;
                }
                
            }
            
            NSString *str = [NSString stringWithFormat:@"距离%@还需%d成长值",nsxtTitle,nextTitleCha];
            topCell.bottomLab.text = str;
            
            topCell.dengJiClick = ^{//点击等级规则
                [bself dengji];
            };
            
            return topCell;
        }
            break;
        case 1:
        {
            GradeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GradeCell"];
            
            if (self.dataDic.count != 0) {
                NSDictionary *dic = self.dataArray.lastObject;
                
                _maxNum = [dic[@"big"] floatValue];
                _grow =  [self.dataDic[@"growthvalue"] floatValue];
                cell.progress  =  _grow/_maxNum;
                
                cell.titleArray = self.dataArray;
                
                [cell setUI];
            }
            
            return cell;
        }
            break;
    }
    
    
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dengji
{
//    YMWebViewController *webView = [[YMWebViewController alloc]init];
//    webView.navigationItem.title = @"等级规则";
//    webView.requestUrlString = [NSString stringWithFormat:@"%@/%@",@"http://10.0.0.16:8080",@"ykds-admin/App/washcar/guide/api?type=2"];
    
//    [self.navigationController pushViewController:webView animated:YES];

    
    
    
    NSString * url = [NSString stringWithFormat:@"%@/%@",@"http://10.0.0.16:8080",@"ykds-admin/App/washcar/guide/api?type=2"];
    
//    if(!url.length) url = @"m.baidu.com";
    
    if (![url hasPrefix:@"http://"]) {
        url = [NSString stringWithFormat:@"http://%@",url];
    }
    
    WebViewController * web = [[WebViewController alloc]init];
    web.url = url;
    web.title = @"商户等级规则";
    [self.navigationController pushViewController:web animated:YES];
    
}

-(void)dealloc
{
    NSLog(@"%@ 内存释放",self.navigationItem.title);
}
@end
