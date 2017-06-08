//
//  OrderDetailController.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/13.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "OrderDetailController.h"
#import "OrderDetailTopCell.h"
#import "OrderDetailTiShiCell.h"
#import "OrderDetailListCell.h"

@interface OrderDetailController ()
{
    OrderDetailTiShiCell *headView;
}
@property (weak, nonatomic) IBOutlet UITableView *aTableView;
@property (nonatomic,copy)NSDictionary *dataDic;
@property (nonatomic,copy)NSString *minute;//多少分钟免费取消订单

@property (nonatomic,assign)int tishiCellNum;
@end

@implementation OrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRightBtn];
    
    self.navigationItem.title = @"订单详情";
    
    _tishiCellNum = 1;
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"OrderDetailTopCell" bundle:nil] forCellReuseIdentifier:@"OrderDetailTopCell"];
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"OrderDetailTiShiCell" bundle:nil] forCellReuseIdentifier:@"OrderDetailTiShiCell"];
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"OrderDetailListCell" bundle:nil] forCellReuseIdentifier:@"OrderDetailListCell"];
    
    
    self.aTableView.tableFooterView = [UIView new];
    
    [self request];
}

- (void)request
{
    ws(bself)
    
    NSDictionary *param = @{@"key":@"SHOPORDERDETAIL",
                            @"orderId":self.orderId?self.orderId:@"",//订单ID
                            };
    
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
        RC0001;
        
        bself.minute  = json[@"minute"];
        bself.dataDic = json[@"orderDetail"] ?json[@"orderDetail"] :@{};

        [bself.aTableView reloadData];
        
    } fail:^{
        
    }];
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//   
//    
//    if (section != 2) {
//        
//        return [UIView new];
//    }
//    
//     ws(bself);
// 
//        headView =  [[NSBundle mainBundle] loadNibNamed:@"OrderDetailTiShiCell" owner:nil options:nil][0];
//        headView.textLabel.font = kFont14;
//        headView.textLabel.text = @"消费提示";
//        headView.selectHeadView = ^(OrderDetailTiShiCell *cell) {
//
//            if (cell.didSelect) {//如果点击了
//                bself.tishiCellNum = 1;
//            }else{
//                bself.tishiCellNum = 0;
//            }
//            
//            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
//            
//            [bself.aTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//            
//            cell.selectImg.image = [bself image:cell.selectImg.image rotation:UIImageOrientationDown];
//            
//        };
//    
//    return headView;
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section == 2) {
//        return 44;
//    }
    return 5.0;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return 2;
        }
            break;
        case 2:
        {
            return _tishiCellNum;
        }
            break;
        case 3:
        {
            return 1;
        }
            break;
            
        default:
            break;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    if (indexPath.section != 0) {
        
        
        if (indexPath.section == 2) {
            if (indexPath.row == 1) {
                
                NSString *string =    [LLUtils strRelay:self.dataDic[@"tips"]];
                CGSize size = [LLUtils getStringSize:string font:13 width:KeyWindow.width -25];
                
                if (size.height +20 < 44) {
                    return 44;
                }
                return size.height +20;
            }
            return 44;
        }else if (indexPath.section == 3 ){
            return 462./2.0;
        }
        return 44;
    }
    
    return 336./2.;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {

    switch (indexPath.section) {
        case 0:
        {
            OrderDetailTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailTopCell"];
            
            
            
            
            NSString *fff = self.dataDic[@"userAvatar"] ? self.dataDic[@"userAvatar"]:@"";
            
            
            NSString *imgPath =  [NSString stringWithFormat:@"%@%@",YKServer,fff];
            
            
            [cell.userImageView sd_setBackgroundImageWithURL:[NSURL URLWithString:imgPath] forState:0 placeholderImage:[UIImage imageNamed:@""]];
            
            cell.washCarAddLab.text = [LLUtils strRelay:self.dataDic[@"nick"]];
            cell.carNumberLab.text = @"皖A6666测试";
            cell.nowPrice.text = [LLUtils strRelay:self.dataDic[@"newPrice"]];
            cell.userMobile = [LLUtils strRelay:self.dataDic[@"userMobile"]];
            
            NSString *str = [self.dataDic[@"serviceType"] integerValue] == 0?@"轿车":@"SUV";
            
            cell.washName.text = [NSString stringWithFormat:@"%@(%@)",[LLUtils strNilOrEmpty:self.dataDic[@"serviceName"] elseBack:@""],str];
            
            
            NSMutableAttributedString *att = [NSMutableAttributedString attributeStringWithText:@"门市价¥" attributes:@[LightGrayColor,kFont12]];
            
            [att appendText:[NSString stringWithFormat:@"%@",[LLUtils strNilOrEmpty:self.dataDic[@"oldPrice"] elseBack:@""]] withAttributesArr:@[LightGrayColor,kFont12,@(NSMutableAttributedStringExtensionTypeLineThrough)]];

            cell.oldPirce.attributedText = att;

            NSString *nin = [NSString stringWithFormat:@"%@分钟内免费取消订单",[LLUtils  strNilOrEmpty:self.minute elseBack:@""]];
            
            [cell.rightlawBtn setTitle:nin forState:0];

            return cell;
        }
            break;
        case 1:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
            }
            cell.textLabel.font = kFont14;
            if (indexPath.row == 0) {
                
               cell.textLabel.text = @"服务内容";
               cell.detailTextLabel.text = @"";
                
            }else{
                
                NSString *str = [self.dataDic[@"serviceType"] integerValue] == 0?@"轿车":@"SUV";
                
                cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)",[LLUtils strNilOrEmpty:self.dataDic[@"serviceName"] elseBack:@""],str];
//                
                cell.detailTextLabel.font = kFont13;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"¥%@",[LLUtils strRelay:self.dataDic[@"newPrice"]]];
            }
            
            return cell;
        }
            break;
        case 2:
        {
            OrderDetailTiShiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailTiShiCell"];
            cell.textLabel.font = kFont14;
            
            if (indexPath.row == 0) {
                cell.textLabel.text = @"消费提示";
                cell.selectImg.hidden = NO;
                return cell;
            }else{
                cell.selectImg.hidden = YES;
                cell.textLabel.text = [LLUtils strRelay:self.dataDic[@"tips"]];
                cell.textLabel.font = kFont13;
                cell.textLabel.numberOfLines = 0;
                return cell;
            }
        }
            break;
        case 3:
        {
            OrderDetailListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailListCell"];
            cell.orderNumLab .text = [LLUtils strRelay:self.dataDic[@"orderNum"]];
            cell.orderTimeLab.text = [LLUtils strRelay:self.dataDic[@"orderCreateDate"]];
            cell.phoneNumLab .text = [LLUtils phoneSecureHandle:[LLUtils strRelay:self.dataDic[@"userMobile"]]];
            
            NSString *str1=  [LLUtils strNilOrEmpty:self.dataDic[@"couponName"] elseBack:@""];
            cell.quanLab.text = [NSString stringWithFormat:@"¥%@",str1];
            
            NSString *str2=  [LLUtils strNilOrEmpty:self.dataDic[@"couponName"] elseBack:@"0"];
            cell.waitPayLab .text = [NSString stringWithFormat:@"¥%@",str2];

           NSString *str3=  [LLUtils strNilOrEmpty:self.dataDic[@"payMoney"] elseBack:@"0"];
           cell.realPayLab .text = [NSString stringWithFormat:@"¥%@",str3];

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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   
    if (indexPath.section == 2) {
        OrderDetailTiShiCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.didSelect  = !cell.didSelect;

        self.tishiCellNum = self.tishiCellNum==1?2:1;
        
        NSIndexPath *changeRow = [NSIndexPath indexPathForRow:1 inSection:indexPath.section];
        
        if (self.tishiCellNum == 1) {
            [self.aTableView deleteRowsAtIndexPaths:@[changeRow] withRowAnimation:UITableViewRowAnimationRight];
        } else {
            [self.aTableView insertRowsAtIndexPaths:@[changeRow] withRowAnimation:UITableViewRowAnimationRight];
        }
        
        
        [LLUtils rotateImgViewArrow:cell.selectImg isSelected:_tishiCellNum != 1];
        
        
//        cell.selectImg.image = [LLUtils image:cell.selectImg.image rotation:UIImageOrientationDown];
    }
}

- (void)setRightBtn
{
    
    /////0待付款、1待洗车、2待确认、3已完成、4已取消、5已过期
    
    NSString *rightBtnName;
    
    switch (self.orderState) {
        case 0:
        {
            rightBtnName = @"待付款";
        }
            break;
        case 1:
        {
            rightBtnName = @"待洗车";
        }
            break;
        case 2:
        {
            rightBtnName = @"待确认";
        }
            break;
        case 3:
        {
            rightBtnName = @"已完成";
        }
            break;
        case 4:
        {
            rightBtnName = @"已取消";
        }
            break;
            
        default:
            break;
    }
    
//    [self setRightText:rightBtnName textColor:APPColor ImgPath:nil];
}
-(void)dealloc
{
    NSLog(@"%@ 内存释放",self.navigationItem.title);
}
@end
