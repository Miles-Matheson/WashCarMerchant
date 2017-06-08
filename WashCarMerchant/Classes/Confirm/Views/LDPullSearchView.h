//
//  LDPullSearchView.h
//  LimiBuyer
//
//  Created by 厘米科技 on 16/6/29.
//  Copyright © 2016年 limi360. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^callBack)(NSString *idString);
@interface LDPullSearchView : UIView

@property (nonatomic,copy)callBack idCallBack;
@property (nonatomic,copy)callBack nameCallBack;
@property (nonatomic,copy)callBack removeSelfCallBack;
- (id)initWithFrame:(CGRect)frame dataArray:(NSArray *)array;

- (void)removeSelf;
@end
