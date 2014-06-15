//
//  ViewController.m
//  webView
//
//  Created by Dmytro Golub on 07/06/2014.
//  Copyright (c) 2014 Dmytro Golub. All rights reserved.
//

#import "ViewController.h"
#import "APILibrary.h"
#import "JS2ObjCHelper.h"

@interface ViewController () <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString* htmlUrl = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:htmlUrl]]];
    self.webView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) callLibraryMethodWithObject:(NSDictionary*) parameters
{
    APILibrary* library = [[APILibrary alloc] init];
    SEL signature = [JS2ObjCHelper selectorWithObject:parameters[@"api"]];
    if ([library respondsToSelector:signature]) {
        NSInvocation* invocation = [JS2ObjCHelper buildInvocationWithSelector:signature
                                                              target:library
                                                          parameters:[parameters[@"api"] objectForKey:@"parameters"]];
        [invocation invoke];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL* url = request.URL;
    if ([url.absoluteString hasPrefix:@"libtest:"]) {
        NSString* jsURL = [url.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"url %@",jsURL);
        NSArray* separatedURL = [jsURL componentsSeparatedByString:@"?"];
        id obj = [NSJSONSerialization JSONObjectWithData:[separatedURL[1] dataUsingEncoding:NSUTF8StringEncoding]
                                        options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@\n",obj);
        [self callLibraryMethodWithObject:obj];
        return NO;
    }
    return YES;
}

@end
