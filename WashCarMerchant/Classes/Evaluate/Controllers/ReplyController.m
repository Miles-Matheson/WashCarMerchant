//
//  ReplyController.m
//  WashCarMerchant
//
//  Created by Miles on 2017/5/8.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "ReplyController.h"
#import "ReplyCell.h"
#import "UIView+Toast.h"

@interface ReplyController ()
@property (weak, nonatomic) IBOutlet UITableView *aTableView;

@end

@implementation ReplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    

    [self.aTableView registerNib:[UINib nibWithNibName:@"ReplyCell" bundle:nil] forCellReuseIdentifier:@"ReplyCell"];
}


- (void)postDataWithContent:(NSString *)content
{
    [self.view endEditing:YES];
    
    NSString *type = self.isRecall?@"1":@"0";
    ws(bself)
    NSDictionary *param = @{@"key":@"SHOPCOMMENTEDIT",
                            @"type":type,//0回复 1回复修改 2详情
                            @"commentId":self.repleId?self.repleId:@"",//评论ID
                            @"replyContent":content,//回复内容或者回复修改的内容
                            };
    
    [YKRequest postDataWithHost:YKServer path:[YKUrl commonUrl] params:param isCache:NO isShowLoading:NO success:^(id json) {
        RC0001;
        
        NSString *string = bself.isRecall?@"修改":@"回复";

        [bself.view makeToast:[NSString stringWithFormat:@"%@成功!",string] duration:0.3 position:CSToastPositionCenter title:@"" image:nil style:nil completion:^(BOOL didTap) {
           
            [bself.navigationController popViewControllerAnimated:YES];
        }];
    } fail:^{
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {

    return 250.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    ws(bself);
    ReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReplyCell"];
    
    if (_isRecall) {
        cell.textView.text = self.fhContent;
        cell.pleaceHolderLab.hidden = YES;
    }else{
        
        cell.pleaceHolderLab.hidden = NO;
    }

    cell.sendCallBack = ^(NSString *string) {
        [bself postDataWithContent:string];
    };
    
    return cell;
}

-(void)dealloc
{
    NSLog(@"%@ 内存释放",self.navigationItem.title);
}
@end
