//
//  UIControl+BlocksKit.h
//  BlocksKit
//

@interface UIControl (Block)

- (void)handleControlEvent:(UIControlEvents)controlEvents withBlock:(void (^)(id sender))handler;

@end