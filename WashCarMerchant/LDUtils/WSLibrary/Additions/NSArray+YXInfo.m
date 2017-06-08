
#import "NSArray+YXInfo.h"

@implementation NSArray (YXInfo)

- (id)objectAt:(NSUInteger)index
{
    if (index < self.count)	{//self = nil self.count = 0
        return self[index];
    }
    else
    {
        NSLog(@"*****************数组越界");
        return nil;
    }
}


@end
