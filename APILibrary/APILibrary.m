//
//  APILibrary.m
//  APILibrary
//
//  Created by Dmytro Golub on 07/06/2014.
//  Copyright (c) 2014 Dmytro Golub. All rights reserved.
//

#import "APILibrary.h"

@implementation APILibrary

-(void) performTestMethod1WithParameter:(NSString*) param1
                             parameter2:(NSString*) param2
                         withCompletion:(TestCompletionHandler) handler
{
    handler(param1,param2);
}

-(void) performTestMethod2WithParameter:(NSString*) param
                         withCompletion:(TestCompletionHandler) handler
{
    handler(param,@"method 2");
}

-(void) performTestMethod3WithCompletion:(TestCompletionHandler) handler
{
    handler(@"method 1",@"method 2");
}

@end
