//
//  JS2ObjCHelper.h
//  APILibrary
//
//  Created by Dmytro Golub on 15/06/2014.
//  Copyright (c) 2014 Dmytro Golub. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JS2ObjCHelper : NSObject

+(SEL) selectorWithObject:(NSDictionary*) dictionary;
+(NSInvocation*) buildInvocationWithSelector:(SEL) selector target:(id) target parameters:(NSDictionary*) parameters;

@end
