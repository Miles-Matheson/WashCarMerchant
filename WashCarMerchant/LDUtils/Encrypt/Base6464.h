//
//  Base6464.h
//  LimiBuyer
//
//  Created by steven on 16/2/2.
//  Copyright © 2016年 limi360. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base6464 : NSObject

+(NSString *)encode:(NSData *)data;
+(NSData *)decode:(NSString *)dataString;

@end
