//
//  MineAccountController.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/5.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "MineAccountController.h"
#import "MinePactIndexCell.h"
#import "FindPswController.h"
#import "WashCarMerchant-Swift.h"
#import "RankingController.h"
#import "YKLoginController.h"
#import "BaseNavigationController.h"
@interface MineAccountController ()
{
    UILabel *accountLab;
}
@property (weak, nonatomic) IBOutlet UITableView *aTableView;

@end

@implementation MineAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的账号";
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"MinePactIndexCell" bundle:nil] forCellReuseIdentifier:@"MinePactIndexCell"];

}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KeyWindow.width, 130./2.0)];
//    
//    accountLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
//    accountLab.center = view.center;
//    accountLab.textAlignment = NSTextAlignmentCenter;
//    accountLab.text = @"总店账号 :31428426283829572";
//    [view addSubview:accountLab];
//    view.backgroundColor = RGB_COLOR(230, 230, 230);
//    return view;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    return  130./2.0;
    return  5.0;
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
    
    MinePactIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MinePactIndexCell"];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"修改等级密码";
    }else if (indexPath.row == 1){
         cell.textLabel.text = @"等级  财主";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self.navigationController   pushViewController:[FindPswController new] animated:YES];
    }else{
        [self.navigationController   pushViewController:[RankingController new] animated:YES];
    }
}
- (IBAction)outLingClick:(id)sender {//退出登录
    
    [kUserDefault setBool:NO forKey:@"isLogin"];
    
    self.view.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[YKLoginController new]];
}

-(void)dealloc
{
    NSLog(@"%@ 内存释放",self.navigationItem.title);
}

@end
