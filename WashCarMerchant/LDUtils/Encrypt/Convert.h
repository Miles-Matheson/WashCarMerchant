//
//  NSString+StringToHexData.h
//  LimiBuyer
//
//  Created by steven on 16/2/1.
//  Copyright © 2016年 limi360. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringToHexData)

- (NSData *) stringToHexData;

@end


@interface NSData (DataToHexString)

- (NSString *) dataToHexString;

@end
