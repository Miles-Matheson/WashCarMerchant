//
//  YKLoginController.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/18.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "YKLoginController.h"
#import "LoginBtnCell.h"
#import "BaseNavigationController.h"
#import "MainViewController.h"
#import "YKPhoneLoninIndexCell.h"
#import "PhoneLoginController.h"
#import "FindPswController.h"
#import "BindingCarController.h"
#import "BindingPhoneTFCell.h"
#import "YKPushManager.h"

@interface YKLoginController ()

@property (weak, nonatomic) IBOutlet UITableView *aTableView;

@property (nonatomic,copy)NSString *psw;
@property (nonatomic,copy)NSString *phone;

@property (nonatomic,strong)BindingPhoneTFCell *phoneCell;
@property (nonatomic,strong)BindingPhoneTFCell *pswCell;
@end

@implementation YKLoginController
@synthesize phoneCell;
@synthesize pswCell;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"快快洗车联盟";
    
    self.automaticallyAdjustsScrollViewInsets  = NO;
    self.aTableView.tableFooterView = [UIView new];
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"BindingPhoneTFCell" bundle:nil] forCellReuseIdentifier:@"BindingPhoneTFCell"];
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"LoginBtnCell" bundle:nil] forCellReuseIdentifier:@"LoginBtnCell"];
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"YKPhoneLoninIndexCell" bundle:nil] forCellReuseIdentifier:@"YKPhoneLoninIndexCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    if (indexPath.row == 2){
        
        return 90.0;
    }else if (indexPath.row == 4){
        return 30;
    }
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    ws(bself);
    switch (indexPath.row) {
            
        case 0:
        {
            phoneCell = [tableView dequeueReusableCellWithIdentifier:@"BindingPhoneTFCell"];
            phoneCell.titleLab.text = @"账户:";
            phoneCell.TF.placeholder = @"请输入用户名";
            phoneCell.TF.keyboardType = UIKeyboardTypeNumberPad;
            phoneCell.TF.font = kFont15;
            phoneCell.inputCallBack = ^(UITextField *textField) {
                bself.phone = textField.text?textField.text:@"";
            };
            return phoneCell;
        }
            break;
            
        case 1:
        {
            pswCell = [tableView dequeueReusableCellWithIdentifier:@"BindingPhoneTFCell"];
            pswCell.titleLab.text = @"密码";
            pswCell.TF.placeholder = @"请输入密码";
            pswCell.TF.font = kFont15;
            pswCell.TF.secureTextEntry  = YES;
            pswCell.TF.returnKeyType = UIReturnKeyDone;
            pswCell.TF.clearButtonMode = UITextFieldViewModeWhileEditing;
            pswCell.inputCallBack = ^(UITextField *textField) {
                bself.psw = textField.text?textField.text:@"";
            };
            
            if ([[kUserDefault objectForKey:@"phone"] length] > 0) {
                self.phone = [kUserDefault objectForKey:@"phone"];
                phoneCell.TF.text = self.phone;
            }
            if ([[kUserDefault objectForKey:@"psw"] length] > 0) {
                self.psw = [kUserDefault objectForKey:@"psw"];
                pswCell.TF.text =self.psw;
            }
            
            return pswCell;
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
        case 3:
        {
            ws(bself);
            YKPhoneLoninIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKPhoneLoninIndexCell"];
            cell.logOrFindCallBack = ^(NSInteger tag) {//10 手机登录  20 忘记密码
                
                if (tag == 10) {
                    [bself.navigationController pushViewController:[PhoneLoginController new] animated:YES];
                }else{
                    [bself.navigationController pushViewController:[FindPswController new] animated:YES];
                }
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
    [self.view endEditing:YES];
    
    [kUserDefault setBool:YES forKey:@"isUsedApp"];
    
    if (! [LDValidateUtil validateMobile:phoneCell.TF.text]) {
        
        [self.view showCenterToast:@"请输入正确的手机号"];
        return;
    }
    //    }else if(! [LDValidateUtil validatePassword:pswCell.TF.text]){
    //
    //        [self.view showCenterToast:@"请输入6-12位数字,字母组成的密码"];
    //        return;
    //    };
    

    if (![[kUserDefault objectForKey:@"phone"] isEqualToString:phoneCell.TF.text] ) {
        self.phone = phoneCell.TF.text ;
    }if ([[kUserDefault objectForKey:@"psw"] isEqualToString:pswCell.TF.text] > 0) {
        self.psw = pswCell.TF.text;
    }
    
    ws(bself)
    NSDictionary *param = @{@"key":@"OWERLOGIN",
                            @"mobile":self.phone?self.phone:phoneCell.TF.text,
                            @"type":@"1",//0手机验证码登录 1账号密码登录
                            @"value":self.psw?self.psw:pswCell.TF.text,//密码
                            @"yzmType":@"3",//1注册2忘记密码3登录4提款5其他
                            @"stat":@"1",
                            };
    
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:YES success:^(id json) {
        RC0001;
        
        [kUserDefault setObject:json[@"userId"] forKey:@"userId"];
        
        [kUserDefault setObject:bself.phoneCell.TF.text?bself.phoneCell.TF.text:@"" forKey:@"phone"];
        [kUserDefault setObject:bself.pswCell.TF.text?bself.pswCell.TF.text:@"" forKey:@"psw"];
        
        [bself loginSuccess];
    } fail:^{
        
    }];
}

- (void)loginSuccess
{
    
    [kUserDefault setBool:YES forKey:@"isLogin"];
    [[YKPushManager sharedInstance]setAlias:MemberId];
    
    [UIApplication sharedApplication].keyWindow.rootViewController  = [[BaseNavigationController alloc]initWithRootViewController:[[MainViewController alloc]init]];
}

- (IBAction)xingCheJiaMeng:(UIButton *)sender {
    
    [self.navigationController pushViewController:[BindingCarController new] animated:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

-(void)dealloc
{
    NSLog(@"%@ 内存释放",self.navigationItem.title);
}
@end
