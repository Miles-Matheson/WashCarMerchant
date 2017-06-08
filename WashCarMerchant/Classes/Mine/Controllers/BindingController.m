//
//  BindingController.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/13.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "BindingController.h"
#import "BindingPhoneLabCell.h"
#import "BindingPhoneTFCell.h"
#import "LLSinglePickerView.h"

@interface BindingController ()
@property (weak, nonatomic) IBOutlet UITableView *aTableView;

@end

@implementation BindingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"绑定手机";
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"BindingPhoneLabCell" bundle:nil] forCellReuseIdentifier:@"BindingPhoneLabCell"];
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"BindingPhoneTFCell" bundle:nil] forCellReuseIdentifier:@"BindingPhoneTFCell"];
    
    self.aTableView.tableFooterView = [UIView new];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ws(bself);
    switch (indexPath.row) {
        case 0:
        {
            BindingPhoneLabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BindingPhoneLabCell"];
            cell.textLabel.text = @"车行:";
            cell.lab.text = self.carShopName;
            return cell;
        }
            break;
        case 1:
        {
            BindingPhoneLabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BindingPhoneLabCell"];
            cell.textLabel.text = @"角色:";
            cell.lab.text = self.rule;
            return cell;
        }
            break;
        case 2:
        {
            BindingPhoneTFCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BindingPhoneTFCell"];
            cell.textLabel.text = @"姓名:";
            cell.TF.placeholder = @"请输入姓名";
            cell.TF.text  = self.name;
            cell.inputCallBack = ^(UITextField *textField) {
                bself.name = textField.text;
            };
            return cell;
        }
            break;
        case 3:
        {
            BindingPhoneTFCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BindingPhoneTFCell"];
            cell.textLabel.text = @"手机号:";
            cell.TF.placeholder = @"请输入手机号码";
            cell.TF.keyboardType = UIKeyboardTypeNumberPad;
            cell.TF.text  = self.phone;
            
            cell.inputCallBack = ^(UITextField *textField) {
                
                bself.phone = textField.text;
            };
            return cell;
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
    
    if (indexPath.row == 1) {
        ws(bself);
        [LLSinglePickerView show:@{@"datasource":@[@"店长",@"收银员",@"服务员"],} callback:^(NSString *selIndex, NSString *selectStr) {
            
            bself.rule = selectStr;
            
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:0];
        }];
    }
}
- (IBAction)sendBingingInfo:(id)sender {//点击提交
    
    [self postData];
}

- (void)postData
{
    [self.view endEditing:YES];
    
    if (![LLUtils validateMobile:self.phone]) {
        
        [self.view showCenterToast:@"请输入正确的手机号"];
        return;
    }else if (self.name.length == 0){
        [self.view showCenterToast:@"请输入姓名"];
        return;
    }else if (self.rule.length == 0){
      [self.view showCenterToast:@"请输入角色"];
       return;
    }

    ws(bself)
    NSDictionary *param = @{@"key":@"SHOPADDSMSALERTS",
                            @"type":@"1",//0:删除操作  1：增加或修改操作 2：查询
                            @"userId":MemberId,
                            @"smsId":@"",//短信提醒id(删除，修改操作时必传)
                            @"rule":self.rule?self.rule:@"",//角色（店长，收营员，服务员）添加和修改操作时必传
                            @"phone":self.phone?self.phone:@"",//手机号（添加和修改操作时必传
                            @"person":self.name?self.name:@"",//姓名（添加和修改操作时必传）
                            };
    
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
        
        RC0001;

        [bself.view showCenterToast:@"操作成功"];
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
