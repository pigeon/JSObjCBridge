//
//  ViewController.m
//  webView
//
//  Created by Dmytro Golub on 07/06/2014.
//  Copyright (c) 2014 Dmytro Golub. All rights reserved.
//

#import "ViewController.h"
#import "APILibrary.h"

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

-(SEL) selectorWithObject:(NSDictionary*) dictionary
{
    NSMutableString* methodSignature = [[NSMutableString alloc] initWithString:dictionary[@"methodName"]];
    [methodSignature appendString:@":"];
    
    NSDictionary* parameters = dictionary[@"parameters"];
    for (int i=1; i<parameters.count; ++i) {
        NSDictionary* paramInfo = parameters[[NSString stringWithFormat:@"param%i",i+1]];
        NSString* methodName = paramInfo[@"name"];
        [methodSignature appendString:methodName];
        [methodSignature appendString:@":"];
    }
    SEL signature = NSSelectorFromString(methodSignature);
    return signature;
}

-(NSInvocation*) buildInvocationWithSelector:(SEL) selector target:(id) target parameters:(NSDictionary*) parameters
{
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:target];
    
    for (int i=1; i<parameters.count; ++i) {
        NSDictionary* paramValue = parameters[[NSString stringWithFormat:@"param%i",i]];
        id value = paramValue[@"value"];
        [invocation setArgument:&(value) atIndex:i+1];
    }
    return invocation;
}

- (void) callLibraryMethodWithObject:(NSDictionary*) parameters
{
    APILibrary* library = [[APILibrary alloc] init];
    SEL signature = [self selectorWithObject:parameters[@"api"]];
    if ([library respondsToSelector:signature]) {
        NSInvocation* invocation = [self buildInvocationWithSelector:signature
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
