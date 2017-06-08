//
//  BackMoneyViewController.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/10.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "BackMoneyViewController.h"
#import "YKOneLblCell.h"//row 0-3
#import "YKLeftLblRightTFCell.h" //5
#import "BindingPhoneTFCell.h"


@interface BackMoneyViewController ()<YKLeftLblRightTFCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *aTableView;
@property (nonatomic,copy)NSDictionary *dataDic;
@property (nonatomic,copy)NSString *yzm;//验证码
@property (nonatomic,assign)CGFloat cash;//提款金额

@end

@implementation BackMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提款";
    
    
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"BindingPhoneTFCell" bundle:nil] forCellReuseIdentifier:@"BindingPhoneTFCell"];
    [self.aTableView registerNib:[UINib nibWithNibName:@"YKLeftLblRightTFCell" bundle:nil] forCellReuseIdentifier:@"YKLeftLblRightTFCell"];
    [self.aTableView registerNib:[UINib nibWithNibName:@"YKOneLblCell" bundle:nil] forCellReuseIdentifier:@"YKOneLblCell"];
    
    [self requestMainData];
}

- (void)requestMainData
{
    ws(bself);
    NSDictionary *param = @{
                            @"key":@"WITHDRAWPAGE",
                            @"userId":MemberId,
                            };
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
        RC0001
        bself.dataDic = json[@"contract"];
        [bself.aTableView reloadData];
    } fail:^{
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {

    YKOneLblCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKOneLblCell"];
    
    //    输出参数：{
    //        "contract": {	//合同
    //            "id": "20174720134730",	//合同id
    //            "isNewRecord": false,
    //            "updateDate": "2017-05-24 16:53:07",
    //            "companyId": "287834399b2d4cdc90b6a84a59834d0a",
    //            "contractNm": "test合同",	//合同名称
    //            "tel": "138*****232",		//合同绑定手机号
    //            "img": "upload/20170520130543/827682.jpg",
    //            "bcxyImg": "upload/20170520130500/827700.jpg",
    //            "jffzrNm": "cgq",
    //            "jffzrTel": "13845612323",
    //            "jffzrZw": "总经理",
    //            "jffzrMail": "123@qq.com",
    //            "jjlxrNm": "cgq",
    //            "jjlxrTel": "13845612323",
    //            "jjlxrZw": "总经理",
    //            "jjlxrMail": "123@qq.com",
    //            "contractStime": "2017-05-02 00:00:00",
    //            "contractEtime": "2017-06-03 00:00:00",
    //            "type": "1",
    //            "paydays": "30",
    //            "skrNm": "cgq",
    //            "skricNum": "342401199210034479",
    //            "skAccount": "6282********8208",	//合同绑定银行卡号
    //            "skBank": "中信银行",
    //            "bankAccount": "合肥分行",
    //            "isFr": "1",
    //            "supplierId": "7",
    //            "saleNm": "10",
    //            "creattime": 1495259250000,
    //            "stat": "3",
    //            "glide": "12",
    //            "supplierNm": "供应商supplier",
    //            "saleName": "济南技术部"
    //        },
    //        "userName": "13817974101",	//车行平台账号
    //        "code": "10000"
    //    }
    
    switch (indexPath.row) {
        case 0:
        {
            cell.lbl.text = [NSString stringWithFormat:@"合同名称:            %@",[LLUtils strNilOrEmpty:_dataDic[@"contractNm"] elseBack:@""]];
            return cell;
        }
            break;
        case 1:
        {
            cell.lbl.text = [NSString stringWithFormat:@"合同绑定银行卡:%@",[LLUtils strNilOrEmpty:_dataDic[@"skAccount"] elseBack:@""]];
            return cell;
        }
            break;
        case 2:
        {
            cell.lbl.text = [NSString stringWithFormat:@"车行平台账号:    %@",[LLUtils strNilOrEmpty:_dataDic[@"skAccount"] elseBack:@""]];
            return cell;
        }
            break;
        case 3:
        {
            cell.lbl.text = @"结算金额:";
            return cell;
        }
            break;
        case 4:
        {
            ws(bself);
            BindingPhoneTFCell *cell5 = [tableView dequeueReusableCellWithIdentifier:@"BindingPhoneTFCell"];
            cell5.titleLab.text = @"手提取金额:";
            cell5.maxLength  = 300;
            cell5.TF.placeholder = @"最低提取金额不得低于100元";
            cell5.TF.keyboardType = UIKeyboardTypeDecimalPad;
            cell5.inputCallBack = ^(UITextField *textField) {
                
                bself.cash = [textField.text floatValue];
                
                NSLog(@"bself.cash == %.2f",bself.cash);
            };
            return cell5;
        }
            break;
        case 5:
        {
            cell.lbl.text = [NSString stringWithFormat:@"绑定合同手机号:    %@",[LLUtils strNilOrEmpty:_dataDic[@"tel"] elseBack:@""]];
            return cell;
        }
            break;
        case 6:
        {
            YKLeftLblRightTFCell *cell5 = [tableView dequeueReusableCellWithIdentifier:@"YKLeftLblRightTFCell"];
            cell5.leftLbl.text = @"手机验证码";
            cell5.rightTF.placeholder = @"请输入验证码";
            cell5.delegate = self;
            return cell5;
        }
            break;
            
        default:
            break;
    }
    
    return [UITableViewCell new];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//输入的文字
- (void)YKLeftLblRightTFCell:(YKLeftLblRightTFCell *)cell editingChanged:(UITextField *)textFiled
{
    self.yzm = textFiled.text;
}
//获取验证码
- (void)YKLeftLblRightTFCell:(YKLeftLblRightTFCell *)cell clickRightBtn:(UIButton *)rightBtn
{
    [self sendYZM];
}

//确认提款
- (IBAction)getMoneySentClick:(id)sender {
    [self.view endEditing:YES];
    
    [self getMoney];
    
}
- (void)sendYZM
{
    [self.view endEditing:YES];
    ws(bself);
    NSDictionary *param = @{
                            @"key":@"SENDCODE",
                            @"type":@"4",
                            };
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:YES success:^(id json) {
        RC0001
        [bself.view showCenterToast:@"验证码已发送"];
        
    } fail:^{
        
    }];
}

- (void)getMoney
{
    if (_cash<= 0) {
        
        [self.view showCenterToast:@"请输入提取金额"];
        return;
    }
    
    [self.view endEditing:YES];
    ws(bself);
    NSDictionary *param = @{
                            @"key":@"WITHDRAW",
                            @"userId":MemberId,
                            @"yzm":_yzm?_yzm:@"",//短信验证码
                            @"type":@"4",//短信验证码验证类型此处为4
                            @"cash":[NSString stringWithFormat:@"%.2f",_cash],//提款金额
                            };
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:YES success:^(id json) {
        RC0001;
        [bself.view showCenterToast:@"提款申请已提交,后台会尽快处理"];
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
