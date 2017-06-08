//
//  PhoneLoginController.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/10.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "PhoneLoginController.h"
#import "LoginBtnCell.h"
#import "YKLeftLblRightTFCell.h"
#import "BaseNavigationController.h"
#import "MainViewController.h"
#import "BindingCarController.h"
#import "YKPushManager.h"

@interface PhoneLoginController ()<YKLeftLblRightTFCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *aTableView;
@property (nonatomic,copy)NSString *psw;
@property (nonatomic,copy)NSString *phone;
@property (nonatomic,strong)YKLeftLblRightTFCell *btnCell;

@end

@implementation PhoneLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"手机登录";
    
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
            cell5.rightTF.placeholder = @"请输入手机号";
            cell5.rightTF.keyboardType = UIKeyboardTypeNumberPad;
            cell5.delegate = self;
            cell5.tag = 10;
            return cell5;
        }
            break;
        
        case 1:
        {
            _btnCell = [tableView dequeueReusableCellWithIdentifier:@"YKLeftLblRightTFCell"];
            _btnCell.leftLbl.text = @"验证码";
            _btnCell.rightTF.placeholder = @"请输入验证码";
            _btnCell.delegate = self;
            _btnCell.tag = 20;
            return _btnCell;
        }
            break;
        case 2:
        {
            ws(bself);
            LoginBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoginBtnCell"];
        cell.loginCallBack = ^{
            [bself yanZheng];
        };
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    return [UITableViewCell new];
    
}

- (void)yanZheng
{
    
    //校验验证码
    ws(bself)
    NSDictionary *param = @{@"key":@"CHECKYZM",
                            @"mobile":self.phone?self.phone:@"",
                            @"yzm":self.psw?self.psw:@"",
                            @"type":@"3",
                            };
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
        
        RC0001;
        [bself logIn];
        
    } fail:^{
        
    }];
}

- (void)logIn
{
    [self.view endEditing:YES];
    
    if (! [LDValidateUtil validateMobile:self.phone]) {
        
        [self.view showCenterToast:@"请输入正确的手机号"];
        return;
    }
    
    if(self.psw.length == 0){
        [self.view showCenterToast:@"请输入验证码"];
        return;
        
    };

    ws(bself)
    NSDictionary *param = @{@"key":@"OWERLOGIN",
                            @"mobile":self.phone?self.phone:@"",
                            @"type":@"0",//0手机验证码登录 1账号密码登录
                            @"value":self.psw?self.psw:@"",//密码/验证码
                            @"yzmType":@"3",//1注册2忘记密码3登录4提款5其他
                            @"stat":@"1",
                            };
    
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
        RC0001;
        
        [kUserDefault setObject:json[@"userId"] forKey:@"userId"];
        [[YKPushManager sharedInstance]setAlias:MemberId];

        [bself loginSuccess];
    } fail:^{
        
    }];
}

- (void)loginSuccess
{
    [UIApplication sharedApplication].keyWindow.rootViewController  = [[BaseNavigationController alloc]initWithRootViewController:[[MainViewController alloc]init]];
}

//输入的文字
- (void)YKLeftLblRightTFCell:(YKLeftLblRightTFCell *)cell editingChanged:(UITextField *)textFiled
{
    if (cell.tag == 10) {
        self.phone = textFiled.text;
    }else{
        self.psw = textFiled.text;
    }
}
//获取验证码
- (void)YKLeftLblRightTFCell:(YKLeftLblRightTFCell *)cell clickRightBtn:(UIButton *)rightBtn
{
    ws(bself);
    NSDictionary *param = @{@"key":@"SENDCODE",
                            @"mobile":self.phone?self.phone:@"",
                            @"type":@"3",//1-6	1注册2忘记密码3登录 4提款5其他 6车行加盟 7提款
                            };
    
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
        RC0001;
        
        [bself.btnCell startCountdown];//开始倒计时
        
        [KeyWindow   showCenterToast:@"验证码已发送,请注意查收"];
    } fail:^{
        
    }];
}

//行车加盟
- (IBAction)CarBindingClik:(id)sender {
    
    [self.navigationController pushViewController:[BindingCarController new] animated:YES];
}

-(void)dealloc
{
    NSLog(@"%@ 内存释放",self.navigationItem.title);
}

@end
