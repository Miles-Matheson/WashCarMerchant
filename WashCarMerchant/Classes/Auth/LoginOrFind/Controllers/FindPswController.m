//
//  FindPswController.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/17.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "FindPswController.h"
#import "YKFindPswHeader.h"
#import "LoginBtnCell.h"
#import "BindingPhoneTFCell.h"
#import "YKLeftLblRightTFCell.h"
#import "FindPswDownCell.h"
#import "YKLoginController.h"

@interface FindPswController ()<YKLeftLblRightTFCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *aTableView;

@property (nonatomic,strong)BindingPhoneTFCell *cellOne;
@property (nonatomic,strong)BindingPhoneTFCell *cellTwo;
@property (nonatomic,strong)YKLeftLblRightTFCell *btnCell;
@property (nonatomic,copy)NSString *yanzhengString;
@property (nonatomic,copy)NSString *phone;
@property (nonatomic,assign)int  page;



@end

@implementation FindPswController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    
    self.navigationItem.title = @"找回密码";
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"BindingPhoneTFCell" bundle:nil] forCellReuseIdentifier:@"BindingPhoneTFCell"];
    [self.aTableView registerNib:[UINib nibWithNibName:@"YKLeftLblRightTFCell" bundle:nil] forCellReuseIdentifier:@"YKLeftLblRightTFCell"];
    [self.aTableView registerNib:[UINib nibWithNibName:@"LoginBtnCell" bundle:nil] forCellReuseIdentifier:@"LoginBtnCell"];
    [self.aTableView registerNib:[UINib nibWithNibName:@"FindPswDownCell" bundle:nil] forCellReuseIdentifier:@"FindPswDownCell"];
    
    
    
    self.aTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 111.0;
    }else if (section == 1){
        return 5;
    }
    
    return CGFLOAT_MIN;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        YKFindPswHeader *header = [[NSBundle mainBundle] loadNibNamed:@"YKFindPswHeader" owner:nil options:nil][0];
        header.type = _page;
        return header;
    }else{
        
        UIView *view = [UIView new];
        view.backgroundColor = BG_COLOR_View;

        return view;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if (section == 1){
        return  _page == 3?1:2;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    switch (indexPath.section) {
        case 0:
        {
            return 5;;
        }
            break;
        case 1:
        {
            return _page != 3?44:272./2.;
        }
            break;
        case 2:
        {
            return _page != 3?222./2.:60;
        }
            break;
            
        default:
            break;
    }
    return CGFLOAT_MIN;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
   
    ws(bself);
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {

            switch (_page) {//第一页
                case 1:
                {
                    _cellOne = [tableView dequeueReusableCellWithIdentifier:@"BindingPhoneTFCell"];
                    _cellOne.TF.clearButtonMode = UITextFieldViewModeWhileEditing;
                    _cellOne.textLabel.font = kFont13;
                    _cellOne.textLabel.text = @"账户:";
                    _cellOne.textLabel.textColor = TextColor;
                    _cellOne.TF.placeholder =  @"请输入已绑定的手机号";
                    return _cellOne;
                }
                    break;
                case 2://第二页
                {
                    _cellTwo = [tableView dequeueReusableCellWithIdentifier:@"BindingPhoneTFCell"];
                    _cellTwo.TF.clearButtonMode = UITextFieldViewModeWhileEditing;
                    _cellTwo.textLabel.font = kFont13;
                    _cellTwo.textLabel.text = @"设置密码:";
                    _cellTwo.textLabel.textColor = TextColor;
                    _cellTwo.TF.placeholder =  @"建议输入密码为8-14位数字,字母组合";
                    return _cellTwo;
                }
                    break;
                case 3://第三页
                {
                    FindPswDownCell *downCell = [tableView dequeueReusableCellWithIdentifier:@"FindPswDownCell"];

                    return downCell;
                }
                    break;
                    
                default:
                    break;
            }
            
        }else{
            
            switch (_page) {
                case 1:
                {
                    _btnCell = [tableView dequeueReusableCellWithIdentifier:@"YKLeftLblRightTFCell"];
                    _btnCell.leftLbl.text = @"验证码";
                    _btnCell.rightTF.placeholder = @"请输入验证码";
                    _btnCell.delegate = self;
                    return _btnCell;
                }
                    break;
                case 2:
                {
                    _cellOne = [tableView dequeueReusableCellWithIdentifier:@"BindingPhoneTFCell"];
                    _cellOne.TF.clearButtonMode = UITextFieldViewModeWhileEditing;
                    _cellOne.textLabel.font = kFont13;
                    _cellOne.textLabel.text = @"确认密码:";
                    _cellOne.textLabel.textColor = TextColor;
                    _cellOne.TF.placeholder =  @"请再次确认密码";
                    return _cellOne;
                }
                    break;
                    
                default:
                    break;
            }
        }
 
    }else if (indexPath.section == 2){
        
        LoginBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoginBtnCell"];
       
        [cell.loginBtn setTitle:_page!= 3?@"下一步":@"去登陆" forState:0];
        cell.loginCallBack = ^{
            [bself next];
        };
        return cell;
    }
    
    return [UITableViewCell new];
}
- (void)next
{
    switch (_page) {
        case 1://第一页
        {
            if (self.yanzhengString.length <= 0) {
                
                [self.view showCenterToast:@"请输入验证码"];
                return;
            }
        [self yanZheng];//校验验证码
        }
            break;
        case 2://第二页
        {
            if (![_cellTwo.TF.text isEqualToString:_cellOne.TF.text]) {
                [self.view showCenterToast:@"两次密码不一致,请重新输入"];
                return;
            }else if (![LLUtils validatePassword:_cellTwo.TF.text minLength:8 maxLength:14]){
                [self.view showCenterToast:@"请输入8-14位数字,字母组合的密码"];
                return;
            }
            
            [self requestttttttttttt];
        }
            break;
        case 3://第三页
        {
            [self goLogin];
        }
            break;
            
        default:
            break;
    }
}
- (void)yanZheng
{
    [self.view endEditing:YES];
    //校验验证码
    ws(bself)
    NSDictionary *param = @{@"key":@"CHECKYZM",
                            @"mobile":_cellOne.TF.text?_cellOne.TF.text:@"",
                            @"type":@"3",
                            @"yzm":self.yanzhengString?self.yanzhengString:@""
                            };
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
        
        RC0001;
        [bself.aTableView reloadData];
         bself.page ++;
    } fail:^{
        
    }];
}

- (void)requestttttttttttt
{

    [self.view endEditing:YES];
    
    ws(bself)
    NSDictionary *param = @{@"key":@"RESETPASSWORD",
                            @"mobile":self.phone?self.phone:@"",
                            @"password":_cellOne.TF.text?_cellOne.TF.text:@"",
                            };
    
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
        
        RC0001;
        
        bself.page ++;
        [bself.aTableView reloadData];
        
    } fail:^{
        
    }];
}

- (void)YKLeftLblRightTFCell:(YKLeftLblRightTFCell *)cell editingChanged:(UITextField *)textFiled
{
    self.yanzhengString = textFiled.text;
}
- (void)YKLeftLblRightTFCell:(YKLeftLblRightTFCell *)cell clickRightBtn:(UIButton *)rightBtn
{//获取验证码
    if (![LDValidateUtil validateMobile:_cellOne.TF.text]) {
        
        [self.view showCenterToast:@"请输入正确的手机号"];
        return;
    }
    
    ws(bself);
    [self.view endEditing:YES];
    
    self.phone = _cellOne.TF.text;
    NSDictionary *param = @{@"key":@"SENDCODE",
                            @"mobile":_cellOne.TF.text?_cellOne.TF.text:@"",
                            @"type":@"2",//1-6	1注册2忘记密码3登录 4提款5其他 6车行加盟 7提款
                            };
    
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
        RC0001;
        
        
        [bself.btnCell startCountdown];
        
        [KeyWindow   showCenterToast:@"验证码已发送,请注意查收"];
    } fail:^{
        
    }];
}

- (void)goLogin
{
    
    [UIApplication   sharedApplication].keyWindow.rootViewController = [[UINavigationController alloc]initWithRootViewController:[YKLoginController new]];
}

-(void)dealloc
{
    NSLog(@"%@ 内存释放",self.navigationItem.title);
}
@end
