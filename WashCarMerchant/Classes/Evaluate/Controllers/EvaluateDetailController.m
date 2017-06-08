//
//  EvaluateDetailController.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/8.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "EvaluateDetailController.h"
#import "EvaluateDetailCell.h"
#import "ReplyContentCell.h"
#import "ReplyModel.h"
@interface EvaluateDetailController ()
{
    
}
@property (weak, nonatomic) IBOutlet UITableView *aTableView;

@property (nonatomic,copy)NSDictionary *dataDic;

@end

@implementation EvaluateDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"详情";
    
    [_aTableView registerNib:[UINib nibWithNibName:@"EvaluateDetailCell" bundle:nil] forCellReuseIdentifier:@"EvaluateDetailCell"];
    [_aTableView registerNib:[UINib nibWithNibName:@"ReplyContentCell" bundle:nil] forCellReuseIdentifier:@"ReplyContentCell"];
    
    
    [self requestMainData];
   }

- (void)requestMainData
{
    ws(bself)
    NSDictionary *param = @{@"key":@"SHOPCOMMENTEDIT",
                            
                            @"type":@"2",//0回复 1回复修改 2详情
                            
                            @"commentId":self.repleId?self.repleId:@"",//评论ID
 
                            };
    
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {

        RC0001;
        bself.dataDic = json;

        [bself.aTableView reloadData];
    } fail:^{
        
    }];
}

- (IBAction)huifuOrxiugaiClick:(id)sender {
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.dataDic[@"commentDetail"][@"isRecall"] boolValue]) {
        return 2;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    if (indexPath.row != 0) {
        
        
        
        tableView.estimatedRowHeight = 200;
        tableView.rowHeight = UITableViewAutomaticDimension;
        return tableView.rowHeight;
    }
    
    NSString *img = self.dataDic[@"commentDetail"][@"img"];
    NSArray *imgs = [img componentsSeparatedByString:@","];

    int width = (KeyWindow.width- 12*4)/3;
    
    NSString *content = self.dataDic[@"commentDetail"][@"content"];
    
    CGSize size =  [LLUtils getStringSize:content font:13 width:KeyWindow.width-20];
    
    return 370.0/2.0 + (imgs.count/3* (width +12) + 12 + ( content.length==0?0.0:size.height));
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath   {
    
    if (indexPath.row == 0) {
        EvaluateDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EvaluateDetailCell"];

        cell.title.text = self.dataDic[@"serviceNm"];
        cell.price.text = [NSString stringWithFormat:@"¥%@",self.dataDic[@"newPrice"]];

        NSMutableAttributedString *att = [NSMutableAttributedString attributeStringWithText:@"¥" attributes:@[LightGrayColor,kFont12]];
        

        [att appendText:[NSString stringWithFormat:@"%@",self.dataDic[@"oldPrice"]] withAttributesArr:@[LightGrayColor,kFont12,@(NSMutableAttributedStringExtensionTypeLineThrough)]];
        
        
        cell.oldPriceLab.attributedText = att;
        
        if ([self.dataDic[@"serviceType"] integerValue] == 0) {//0 轿车 1 suv
            
            cell.title.text = [NSString stringWithFormat:@"%@(%@)",self.dataDic[@"serviceNm"],@"轿车"];
        }else{
             cell.title.text = [NSString stringWithFormat:@"%@(%@)",self.dataDic[@"serviceNm"],@"SUV"];
        }
        
        cell.washTypeLab.text =cell.title.text;
        
        
        NSDictionary *dic  = self.dataDic[@"commentDetail"];
        
        if (dic.count != 0) {
            
            NSString *img = self.dataDic[@"commentDetail"][@"img"];
            NSArray *imgs = [img componentsSeparatedByString:@","];
            cell.star = [self.dataDic[@"commentDetail"][@"score"] integerValue];
            cell.timeLab.text = [LLUtils dateStrWithTimeStamp:self.dataDic[@"commentDetail"][@"createDate"] dateFormat:@"yyyy-MM-dd HH:mm"];
            cell.contentLab.text = self.dataDic[@"commentDetail"][@"content"];
            cell.images = imgs;
        }
        return cell;
    }

    if ([self.dataDic[@"commentDetail"][@"isRecall"] boolValue]) {
        
        ReplyContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReplyContentCell"];
        cell.contentLab.text = self.dataDic[@"commentDetail"][@"fhContent"];
        cell.timeLab.text = @"2018-09-09";
        return cell;
    }
    
    return [UITableViewCell new];
    
}

-(void)dealloc
{
    NSLog(@"%@ 内存释放",self.navigationItem.title);
}

@end
