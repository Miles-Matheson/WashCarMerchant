//
//  MinePactController.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/5.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "MinePactController.h"
#import "MinePactCell.h"
#import "MineDealViewCell.h"
#import "ZSCPicShowView.h"
#import "MinePactIndexCell.h"
@interface MinePactController ()
{
    ZSCPicShowView *picShowView;
}
@property (weak, nonatomic) IBOutlet UITableView *aTableView;
@property (nonatomic,copy)NSDictionary *dataDic;

@end

@implementation MinePactController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"合同管理";

    [self.aTableView registerNib:[UINib nibWithNibName:@"MinePactIndexCell" bundle:nil] forCellReuseIdentifier:@"MinePactIndexCell"];
    [self.aTableView registerNib:[UINib nibWithNibName:@"MinePactCell" bundle:nil] forCellReuseIdentifier:@"MinePactCell"];
    [self.aTableView registerNib:[UINib nibWithNibName:@"MineDealViewCell" bundle:nil] forCellReuseIdentifier:@"MineDealViewCell"];
    [self requestMainData];
}

- (void)requestMainData
{
    ws(bself)
    NSDictionary *param = @{@"key":@"SHOPCONTRACT",
                            @"userId":MemberId,
                            };
    
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
        
        RC0001;
        
        bself.dataDic = json;
        
        [bself.aTableView reloadData];
        
    } fail:^{
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    if (indexPath.row == 3) {
        return 44*3.0;
    }
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    WS(bself);
    MinePactIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MinePactIndexCell"];
    cell.textLabel.font = kFont13;
    if (indexPath.row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"合同编号 :       %@",[LLUtils strRelay:self.dataDic[@"contractId"]]];

    }else if (indexPath.row == 1){
        cell.textLabel.text = [NSString stringWithFormat:@"合同名称 :       %@",[LLUtils strRelay:self.dataDic[@"contractName"]]];
        
    }else if (indexPath.row == 2){
        MinePactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MinePactCell"];
        cell.textLabel.text = @"合同扫描件";
        cell.detailTextLabel.text = @"2017-09-09";
        cell.textLabel.font = kFont13;
        cell.pactCallBack = ^(UIButton *buttton) {
             [bself checkDealImage:buttton];//查看合同照片
        };
        return cell;
    }else if(indexPath.row == 3){
        MineDealViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineDealViewCell"];
        cell.dealCallBack = ^(UIButton *buttton) {
            [bself checkDealImage:buttton];//查看合同照片
        };
        return cell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)checkDealImage:(UIButton *)btn{
    
    NSArray *contractImgs =  self.dataDic[@"contractImgs"];//合同图片
    NSArray *bcxyImgs = self.dataDic[@"bcxyImgs"];//合同附件图片
    
    NSString *imgPath = @"";
    
    switch (btn.tag) {
        case 0:
        {
         
            if (contractImgs.count != 0) {
                imgPath = contractImgs[0];
            }
        }
            break;
        case 10:
        {
            if (bcxyImgs.count <=1) {
                imgPath = bcxyImgs[0];
            }
        }
            break;
        case 20:
        {
            if (bcxyImgs.count >=2) {
                imgPath = bcxyImgs[1];
            }
        }
            break;
        case 30:
        {
            if (bcxyImgs.count >=3) {
                imgPath = bcxyImgs[2];
            }
        }
            break;
            
        default:
            break;
    }
    
    if ([imgPath isEqualToString:@""]) {
        [LLUtils showAlertWithTitle:@"提示" message:@"暂无详细内容,请核对好数据在重试!" delegate:self tag:0 type:AlertViewTypeOnlyConfirm];
        return;
    }

    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[btn convertRect: btn.bounds toView:window];
    
    [self createImgScrollWithUrlArray:@[imgPath] frame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
    
}

//轮播图放大效果
- (void)createImgScrollWithUrlArray:(NSArray *)urlArray frame:(CGRect)frame
{
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    for (int i = 0; i< urlArray.count; i ++){
        
        PicInfo *info =  [[PicInfo alloc]initWithFrame:frame];
        info.picUrlStr = urlArray[i];
        
        info.picOldFrame = frame;CGRectMake(0, 0, kScreenWidth , kScreenWidth);
        
//        if ([LDUtils validateURL:urlArray[i]]) {//过滤掉无用的URL
            [dataArray addObject:info];
//        }
    }
    
    picShowView = [[ZSCPicShowView alloc]init];
    [picShowView createUIWithPicInfoArr:dataArray];
}

-(void)dealloc
{
    NSLog(@"%@ 内存释放",self.navigationItem.title);
}
@end
