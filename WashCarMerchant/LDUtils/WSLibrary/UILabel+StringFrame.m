//
//  WSNSStringAdditions.m
//  WiseSeller
//
//  Created by steven on 14-5-4.
//  Copyright (c) 2014年 steven. All rights reserved.
//

#import "UILabel+StringFrame.h"

@implementation UILabel (WSLibrary)
- (CGSize)boundingRectWithSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    
    CGSize retSize = [self.text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}@end
