// RXMockObjectTests.m
// Created by Rob Rix on 2010-03-22
// Copyright 2010 Monochrome Industries

#import "RXAssertions.h"
#import "RXMockObject.h"

@interface NSObject (RXMockObjectTests)
-(id)response:(id)ignored;
@end

@interface RXMockObjectTests : SenTestCase {
	id mock;
}
@end

@implementation RXMockObjectTests

-(void)setUp {
	mock = [RXMockObject mockObjectForClass: [NSArray class]];
}

-(void)testRespondsToNullaryMessagesWithTheGivenObject {
	[mock setResponseObject: @"nullary response" forSelector: @selector(lastObject)];
	RXAssertEquals([mock lastObject], @"nullary response");
}

-(void)testRespondsToUnaryMessagesWithTheGivenObject {
	[mock setResponseObject: @"result 1" forSelector: @selector(arrayByAddingObject:) withArgument: @"argument 1"];
	[mock setResponseObject: @"result 2" forSelector: @selector(arrayByAddingObject:) withArgument: @"argument 2"];
	RXAssertEquals([mock arrayByAddingObject: @"argument 1"], @"result 1");
	RXAssertEquals([mock arrayByAddingObject: @"argument 2"], @"result 2");
	RXAssertNil([mock arrayByAddingObject: @"not specified"]);
	RXAssertNil([mock arrayByAddingObject: nil]);
}

-(void)testRespondsToMessagesWithNilArguments {
	[mock setResponseObject: @"result 1" forSelector: @selector(arrayByAddingObject:) withArgument: nil];
	[mock setResponseObject: @"result 2" forSelector: @selector(arrayByAddingObject:) withArgument: @"argument 2"];
	RXAssertEquals([mock arrayByAddingObject: nil], @"result 1");
	RXAssertEquals([mock arrayByAddingObject: @"argument 2"], @"result 2");
	RXAssertNil([mock arrayByAddingObject: @"not specified"]);
}

@end
