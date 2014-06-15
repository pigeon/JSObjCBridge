//
//  JS2ObjCHelper.m
//  APILibrary
//
//  Created by Dmytro Golub on 15/06/2014.
//  Copyright (c) 2014 Dmytro Golub. All rights reserved.
//

#import "JS2ObjCHelper.h"

@implementation JS2ObjCHelper

+(SEL) selectorWithObject:(NSDictionary*) dictionary
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

+(NSInvocation*) buildInvocationWithSelector:(SEL) selector target:(id) target parameters:(NSDictionary*) parameters
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

@end
