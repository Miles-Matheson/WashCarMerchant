//
//  BindingCarController.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/18.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "BindingCarController.h"
#import "BindingPhoneTFCell.h"
#import "LoginBtnCell.h"
#import "YKLeftLblRightTFCell.h"
@interface BindingCarController ()<YKLeftLblRightTFCellDelegate>

@property (nonatomic,copy)NSString *yanZhengMa;//验证码
@property (nonatomic,copy)NSString *phone;//手机号
@property (nonatomic,copy)NSString *address;//地址
@property (nonatomic,copy)NSString *shopName;//车行名
@property (nonatomic,copy)NSString *contact;//联系人
@property (nonatomic,strong) YKLeftLblRightTFCell *btnCell;

@property (weak, nonatomic) IBOutlet UITableView *aTableView;

@end

@implementation BindingCarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"行车加盟";
    
    self.aTableView.tableFooterView = [UIView new];
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"BindingPhoneTFCell" bundle:nil] forCellReuseIdentifier:@"BindingPhoneTFCell"];
    [self.aTableView registerNib:[UINib nibWithNibName:@"LoginBtnCell" bundle:nil] forCellReuseIdentifier:@"LoginBtnCell"];
    [self.aTableView registerNib:[UINib nibWithNibName:@"YKLeftLblRightTFCell" bundle:nil] forCellReuseIdentifier:@"YKLeftLblRightTFCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    if (indexPath.row == 5) {
        return 90;
    }
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    WS(bself);
    NSArray *labText  = @[@"地址:",@"店名:",@"联系人:",@"手机号:",@"验证码:",@"",];
    NSArray *titleText = @[@"请填写加盟店地址",@"加盟店名称",@"联系人名称",@"请输入手机号",@"请输入短信验证码",@"",];
    if (indexPath.row >= 4 ) {
        if (indexPath.row == 4) {
            _btnCell = [tableView dequeueReusableCellWithIdentifier:@"YKLeftLblRightTFCell"];
            _btnCell.leftLbl.text = labText[indexPath.row];
            _btnCell.rightTF.placeholder = titleText[indexPath.row];
            _btnCell.delegate = self;
            
            return _btnCell;
        }else{
            LoginBtnCell *clickCell = [tableView dequeueReusableCellWithIdentifier:@"LoginBtnCell"];
            [clickCell.loginBtn setTitle:@"提交申请" forState:0];
            clickCell.loginCallBack = ^{//提交申请
                [bself bingDingCarRqquest];
            };
            return clickCell;
        }
    }

    BindingPhoneTFCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BindingPhoneTFCell"];
    
    cell.TF.placeholder = titleText[indexPath.row];
    cell.TF.tag = indexPath.row;
    cell.titleLab.text = labText[indexPath.row];
    if (indexPath.row == 3) {
        cell.TF.keyboardType = UIKeyboardTypeNumberPad;
    }
    cell.inputCallBack = ^(UITextField *textField) {
        [bself textFieldDidEndEditing:textField];
    };

    return cell;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:
        {
            self.address = textField.text;
            
        }
            break;
        case 1:
        {
             self.shopName = textField.text;
        }
            break;
        case 2:
        {
             self.contact = textField.text;
        }
            break;
        case 3:
        {
            self.phone = textField.text;
        }
            break;
            
        default:
            break;
    }
}


- (void)YKLeftLblRightTFCell:(YKLeftLblRightTFCell *)cell editingChanged:(UITextField *)textFiled
{
    self.yanZhengMa = textFiled.text;
}
- (void)YKLeftLblRightTFCell:(YKLeftLblRightTFCell *)cell clickRightBtn:(UIButton *)rightBtn
{
     [self.view endEditing:YES];
    
    ws(bself);
    
    if (![LDValidateUtil validateMobile:self.phone]) {
        
        [self.view showCenterToast:@"请输入正确的手机号"];
        return;
    }
    
    [self.view endEditing:YES];
    
    NSDictionary *param = @{@"key":@"SENDCODE",
                            @"mobile":self.phone?self.phone:@"",
                            @"type":@"6",//1-6	1注册2忘记密码3登录 4提款5其他 6车行加盟 7提款
                            };
    
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
        RC0001;
        [bself.btnCell startCountdown];
       [KeyWindow   showCenterToast:@"验证码已发送,请注意查收"];
        
    } fail:^{
        
    }];
    
}

- (void)bingDingCarRqquest
{
     [self.view endEditing:YES];
    
    if (self.address.length < 1) {
        
        [self.view showCenterToast:@"请输入地址"];
        return;
        
    }else if (self.shopName.length < 1){
        
        [self.view showCenterToast:@"请输入需要加盟的店名"];
        return;
        
    }else if (self.contact.length <1){
        
        [self.view showCenterToast:@"请输入联系人"];
        return;
        
    }else if (![LDValidateUtil validateMobile:self.phone]){
        
        [self.view showCenterToast:@"请输入正确的手机号"];
        return;
        
    }else if (self.yanZhengMa.length < 1 ){
        
        [self.view showCenterToast:@"请输入验证码"];
        return;
        
    }

//    ws(bself)
    NSDictionary *param = @{@"key":@"CARJOIN",
                            @"type":@"6",
                            @"address":self.address?self.address:@"",
                            @"shopName":self.shopName?self.shopName:@"",
                            @"contact":self.contact?self.contact:@"",
                            @"phone":self.phone?self.phone:@"",
                            @"yzm":self.yanZhengMa?self.yanZhengMa:@"",
                            };
    
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
        RC0001
        
        [KeyWindow showCenterToast:@"提交成功!"];
        
    } fail:^{
        
    }];
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
