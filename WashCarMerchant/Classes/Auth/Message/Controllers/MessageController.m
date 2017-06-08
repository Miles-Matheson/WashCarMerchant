//
//  MessageController.m
//  WashCarMerchant
//
//  Created by 青盲半夏 on 2017/6/8.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "MessageController.h"
#import "MessageCell.h"
#import "WashCarMerchant-Swift.h"

@interface MessageController ()
@property (weak, nonatomic) IBOutlet UITableView *aTableView;
@property (nonatomic,copy)NSDictionary *dataDic;

@end

@implementation MessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.aTableView.tableFooterView = [UIView new];
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"MessageCell" bundle:nil] forCellReuseIdentifier:@"MessageCell"];
  
    [self requestMainData];
}

- (void)requestMainData
{
    ws(bself);
    NSDictionary *param = @{
                            @"key":@"MESSAGECENTER",
                            @"type":@"1",
                            @"userId":MemberId,
                            };
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {

        bself.dataDic = json;
        
        [bself.aTableView reloadData];
        
    } fail:^{
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 124/2.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *NoReadCounts = @[@"orderNoReadCount",@"infoNoReadCount",@"noticeNoReadCount"];
    
    NSArray *contents = @[@"order",@"infoMsg",@"noticeMsg"];
    
    
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    
    if (_dataDic.count < indexPath.row) {
        
        cell.noReadCount = [_dataDic[NoReadCounts[indexPath.row]] integerValue];
        cell.contentLab.text = [LLUtils strRelay:_dataDic[contents[indexPath.row]][@"content"]];
        cell.timeLab.text = [LLUtils strRelay:_dataDic[contents[indexPath.row]][@"createDate"]];
        
        NSLog(@"\n MessageType = %ld \n noReadCount = %ld \n contentLab.text = %@ \n timeLab.text = %@",indexPath.row,[_dataDic[NoReadCounts[indexPath.row]] integerValue],_dataDic[contents[indexPath.row]][@"content"],_dataDic[contents[indexPath.row]][@"createDate"]);
    }
    cell.MessageType = indexPath.row;
    
    switch (indexPath.row) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
            
        default:
            break;
    }
    return cell;
    
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    YKMessageListVC *VC= [[YKMessageListVC alloc]init];
    [VC setTypeWithType:indexPath.row+1];
    
    [self.navigationController pushViewController:VC  animated:YES];
    
    
//    MessageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
}


@end
