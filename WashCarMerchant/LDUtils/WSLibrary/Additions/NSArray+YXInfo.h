//
//  NSArray+YXInfo.h
//  LimiBuyer
//
//  Created by steven on 16/3/3.
//  Copyright © 2016年 limi360. All rights reserved.
//  数组越界不崩溃


#import <Foundation/Foundation.h>

@interface NSArray (YXInfo)

- (id)objectAt:(NSUInteger)index;

@end