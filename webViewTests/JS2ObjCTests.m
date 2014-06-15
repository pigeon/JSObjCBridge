//
//  JS2ObjCTests.m
//  APILibrary
//
//  Created by Dmytro Golub on 15/06/2014.
//  Copyright (c) 2014 Dmytro Golub. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JS2ObjCHelper.h"

@interface JS2ObjCTests : XCTestCase

@property (nonatomic) NSDictionary* apiObject;

@end

@implementation JS2ObjCTests

- (void)setUp {
    [super setUp];
    
    NSString* json= @"{\"api\":{\"methodName\":\"performTestMethod1WithParameter\",\"parameters\":{\"param1\":{\"name\":\"param1\",\"value\":\"test\"},\"param2\":{\"name\":\"parameter2\",\"value\":\"test1\"},\"param3\":{\"name\":\"withCompletion\",\"value\":\"\"}}}}";
    
    self.apiObject = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding]
                                             options:NSJSONReadingMutableContainers error:nil];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSelectorCreationFromJson {
    // This is an example of a functional test case.
    SEL signature = [JS2ObjCHelper selectorWithObject:self.apiObject[@"api"]];
    XCTAssert(signature, @"Selector shouldn't be nil");
}

- (void)testPerformanceSelectorCreationFromJson {
    // This is an example of a performance test case.
    [self measureBlock:^{
        SEL signature = [JS2ObjCHelper selectorWithObject:self.apiObject[@"api"]];
        XCTAssert(signature, @"Selector shouldn't be nil");
    }];
}


@end
