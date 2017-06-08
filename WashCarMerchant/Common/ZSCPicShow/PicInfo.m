//
//  PicInfo.m
//  Demo1
//
//  Created by ZSC on 15/5/14.
//  Copyright (c) 2015年 ZSC. All rights reserved.
//

#import "PicInfo.h"

@implementation PicInfo

- (id)initWithFrame:(CGRect)frame;
{
    if (self = [super init]) {
        self.picOldFrame = frame;
    }
    return self;
}
//防止kvc由于缺少属性报错
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
