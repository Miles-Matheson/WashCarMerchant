//
//  YMWebViewController.m
//  MurphysLaw
//
//  Created by Miles on 2017/4/25.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import "YMWebViewController.h"

@interface YMWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *aWebView;

@end

@implementation YMWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = BG_COLOR_View;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSString *pathUrl = [NSString stringWithFormat:@"%@%@%@",YKServer,[YKUrl systeSetting],self.requestCode];
    NSURL *url = [NSURL URLWithString:pathUrl];

    if (!self.requestCode) {
        url = [NSURL URLWithString:self.requestUrlString];
    }
    [self.aWebView loadRequest:[NSURLRequest requestWithURL:url]];
    self.aWebView.scalesPageToFit = YES;
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}
@end
