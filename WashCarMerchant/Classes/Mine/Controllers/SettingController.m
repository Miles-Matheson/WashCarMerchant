//
//  SettingController.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/25.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "SettingController.h"

@interface SettingController ()

@property (weak, nonatomic) IBOutlet UITableView *aTableView;
@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"设置";
    _aTableView.tableFooterView = [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.font = cell.detailTextLabel.font = kFont13;
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"检查更新";
        cell.detailTextLabel.text = @"当前版本1.0.0";
    }else{
         cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text = @"清除缓存";
        cell.detailTextLabel.text = @"";
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WS(bself);
    if (indexPath.row == 0) {
        [self checkUpdata];
    }else{
        [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
            [bself.view showCenterToast:@"清除缓存成功!"];
        }];;
    }
}

- (void)checkUpdata
{
    ws(bself)
    NSDictionary *param = @{@"key":@"VERSION",
                            @"type":@"1",
                            @"plat":@"2",
                            };
    
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
        
        RC0001;
        
        NSString *version = json[@"version"];
        [bself.view showCenterToast:[NSString stringWithFormat:@"当前最新版本为%@",version]];
        
    } fail:^{
        
    }];
}

-(void)dealloc
{
    NSLog(@"%@ 内存释放",self.navigationItem.title);
}
@end
