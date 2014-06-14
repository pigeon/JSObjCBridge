//
//  APILibrary.h
//  APILibrary
//
//  Created by Dmytro Golub on 07/06/2014.
//  Copyright (c) 2014 Dmytro Golub. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TestCompletionHandler)(NSString* param1,NSString* param2);

@interface APILibrary : NSObject

-(void) performTestMethod1WithParameter:(NSString*) param1
                             parameter2:(NSString*) param2
                         withCompletion:(TestCompletionHandler) handler;
-(void) performTestMethod2WithParameter:(NSString*) param
                         withCompletion:(TestCompletionHandler) handler;
-(void) performTestMethod3WithCompletion:(TestCompletionHandler) handler;

@end
