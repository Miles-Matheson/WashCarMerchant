//
//  LogInController.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/10.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LogInController.h"
#import "LoginBtnCell.h"
#import "YKLeftLblRightTFCell.h"
#import "BaseNavigationController.h"
#import "YKPushManager.h"
#import "MainViewController.h"

@interface LogInController ()<YKLeftLblRightTFCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *aTableView;

@end

@implementation LogInController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"YKLeftLblRightTFCell" bundle:nil] forCellReuseIdentifier:@"YKLeftLblRightTFCell"];
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"LoginBtnCell" bundle:nil] forCellReuseIdentifier:@"LoginBtnCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    if (indexPath.row == 2){
        
        return 150.0;
    }
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {

    switch (indexPath.row) {

        case 0:
        {
            YKLeftLblRightTFCell *cell5 = [tableView dequeueReusableCellWithIdentifier:@"YKLeftLblRightTFCell"];
            cell5.leftLbl.text = @"账户:";
            cell5.rightBtn.hidden = YES;
            cell5.rightTF.placeholder = @"请输入用户名";
            cell5.delegate = self;
            return cell5;
        }
            break;
        
        case 1:
        {
            YKLeftLblRightTFCell *cell5 = [tableView dequeueReusableCellWithIdentifier:@"YKLeftLblRightTFCell"];
            cell5.leftLbl.text = @"验证码";
            cell5.rightTF.placeholder = @"请输入验证码";
            cell5.delegate = self;
            return cell5;
        }
            break;
        case 2:
        {
            ws(bself);
            LoginBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoginBtnCell"];
        cell.loginCallBack = ^{
            [bself logIn];
        };
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    return [UITableViewCell new];
    
}

- (void)logIn
{
    
    [kUserDefault setBool:YES forKey:@"isUsedApp"];

    [kUserDefault setBool:NO forKey:@"isLogin"];
    

    [UIApplication sharedApplication].keyWindow.rootViewController  = [[BaseNavigationController alloc]initWithRootViewController:[[MainViewController alloc]init]];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//输入的文字
- (void)YKLeftLblRightTFCell:(YKLeftLblRightTFCell *)cell editingChanged:(UITextField *)textFiled
{
    
}
//获取验证码
- (void)YKLeftLblRightTFCell:(YKLeftLblRightTFCell *)cell clickRightBtn:(UIButton *)rightBtn
{
    
}
- (IBAction)getMoneySentClick:(id)sender {
}

@end
