//
//  BackMoneyDetailController.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/10.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "BackMoneyDetailController.h"
#import "YKOneLblCell.h"
#import "RankingListCell.h"

@interface BackMoneyDetailController ()
@property (weak, nonatomic) IBOutlet UITableView *aTableView;

@property (nonatomic,copy)NSDictionary *dataDic;
@end

@implementation BackMoneyDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"详情";
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"RankingListCell" bundle:nil] forCellReuseIdentifier:@"RankingListCell"];
    
    [self requestMainData];
}

- (void)requestMainData
{
    ws(bself);
    NSDictionary *param = @{
                            @"key":@"MERSETTLEMENTDETAIL",
                            @"mersettlementId":self.mersettlementId?self.mersettlementId:@"",//账单id
                            };
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
        
        bself.dataDic = json[@"mersettlement"];
        
        [bself.aTableView reloadData];
    } fail:^{
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    RankingListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankingListCell"];
    
    cell.lastLab.text = @"";
    
    switch (indexPath.row) {
        case 0:
        {
            cell.titleLab.text = @"账单编号:";
            cell.centerLab.text = [LLUtils strNilOrEmpty:self.dataDic[@"zdNm"] elseBack:@""];
            return cell;
        }
            break;
        case 1:
        {
            cell.titleLab.text = @"账单时间:";
            cell.centerLab.text = [LLUtils strNilOrEmpty:self.dataDic[@"creattime"] elseBack:@""];
            return cell;
        }
            break;
        case 2:
        {
            cell.titleLab.text = @"付款周期:";
            cell.centerLab.text = [LLUtils strNilOrEmpty:self.dataDic[@"paydays"] elseBack:@"--"];
            return cell;
        }
            break;
        case 3:
        {
            cell.titleLab.text = [self.dataDic[@"jsType"] intValue] == 0?@"提款金额":@"付款金额";
            cell.centerLab.text = [LLUtils strNilOrEmpty:self.dataDic[@"amt"] elseBack:@""];
            return cell;
        }
            break;
        case 4:
        {
            cell.titleLab.text = @"结算类型:";////结算类型0：自提1：周期
            
            cell.centerLab.text =  [self.dataDic[@"jsType"] intValue] == 0?@"自提":@"周期";

            return cell;
        }
            break;
        case 5:
        {
            cell.titleLab.text = @"状态:";
            
            switch ([self.dataDic[@"stat"] intValue]) {//状态 0待审核 1已拒绝 2已通过
                case 0:
                {
                    cell.centerLab.text = @"待审核";
                }
                    break;
                case 1:
                {
                    cell.centerLab.text = @"已拒绝";
                }
                    break;
                    
                case 2:
                {
                    cell.centerLab.text = @"已通过";
                }
                    break;
                    
                    
                default:
                    break;
            }
            
            return cell;
        }
            break;
    }
    
    return [UITableViewCell new];
    
}

-(void)dealloc
{
    NSLog(@"%@ 内存释放",self.navigationItem.title);
}
@end
