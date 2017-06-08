//
//  MineController.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/5.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "MineController.h"
#import "MineAccountController.h"
#import "MinePactController.h"
#import "WashCarMerchant-Swift.h"
#import "MsgNoticController.h"
#import "SettingController.h"
@interface MineController ()

{
    NSArray *titleArray;
}
@property (weak, nonatomic) IBOutlet UITableView *aTableView;

@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationItem.title = @"我的";
    titleArray = @[@"账号 ",@"合同管理",@"短信提醒",@"系统设置",@"客服电话",];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            return 1;
        }
    }
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    switch (indexPath.section) {
        case 0:
        {
            cell.textLabel.text = titleArray[indexPath.row];
        }
            break;
        case 1:
        {
            cell.textLabel.text = titleArray[indexPath.row+1];
        }
            break;
        case 2:
        {
            cell.textLabel.text = titleArray[indexPath.row+3];
            if (indexPath.row == 1) {
                cell.accessoryType = 0;
                cell.detailTextLabel.text = @"10000";
                cell.detailTextLabel.textColor = BlackColor;
            }
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        [self.navigationController  pushViewController:[MineAccountController new] animated:YES];
        
    }else if(indexPath.section == 1 && indexPath.row == 0){
        
        [self.navigationController pushViewController:[MinePactController new] animated:YES];
        
    }else if(indexPath.section == 1 && indexPath.row == 1){
        
        [self.navigationController pushViewController:[MsgNoticController new] animated:YES];
        
    }else if(indexPath.section == 2 && indexPath.row == 0){
        
//     [self.navigationController pushViewController:[YKSettingController new] animated:YES];
     [self.navigationController pushViewController:[SettingController new] animated:YES];
        

    }else if(indexPath.section == 2 && indexPath.row == 1){
        
        NSString *allString = [NSString stringWithFormat:@"tel:10000"];

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];
    }
}
-(void)dealloc
{
    NSLog(@"%@ 内存释放",self.navigationItem.title);
}
@end
