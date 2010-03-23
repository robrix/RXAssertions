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
	mock = [RXMockObject mockObjectForClass: [NSString class]];
}

-(void)testRespondsToNullaryMessagesWithTheGivenObject {
	[mock setResponseObject: @"nullary response" forSelector: @selector(propertyList)];
	RXAssertEquals([mock propertyList], @"nullary response");
}

-(void)testRespondsToUnaryMessagesWithTheGivenObject {
	[mock setResponseObject: @"result 1" forSelector: @selector(componentsSeparatedByString:) withArgument: @"argument 1"];
	[mock setResponseObject: @"result 2" forSelector: @selector(componentsSeparatedByString:) withArgument: @"argument 2"];
	RXAssertEquals([mock componentsSeparatedByString: @"argument 1"], @"result 1");
	RXAssertEquals([mock componentsSeparatedByString: @"argument 2"], @"result 2");
	RXAssertNil([mock componentsSeparatedByString: @"not specified"]);
	RXAssertNil([mock componentsSeparatedByString: nil]);
}

-(void)testRespondsToMessagesWithNilArguments {
	[mock setResponseObject: @"result 1" forSelector: @selector(componentsSeparatedByString:) withArgument: nil];
	[mock setResponseObject: @"result 2" forSelector: @selector(componentsSeparatedByString:) withArgument: @"argument 2"];
	RXAssertEquals([mock componentsSeparatedByString: nil], @"result 1");
	RXAssertEquals([mock componentsSeparatedByString: @"argument 2"], @"result 2");
	RXAssertNil([mock componentsSeparatedByString: @"not specified"]);
}


-(void)testAcceptsNilResponses {
	[mock setResponseObject: nil forSelector: @selector(propertyList)];
	[mock setResponseObject: nil forSelector: @selector(componentsSeparatedByString:) withArgument: nil];
	[mock setResponseObject: @"" forSelector: @selector(componentsSeparatedByString:) withArgument: @""];
	[mock setResponseObject: nil forSelector: @selector(stringByReplacingOccurrencesOfString:withString:) withArguments: [NSArray arrayWithObjects: RXMockObjectNullPlaceholder, RXMockObjectNullPlaceholder, nil]];
	[mock setResponseObject: nil forSelector: @selector(stringByReplacingOccurrencesOfString:withString:) withArguments: [NSArray arrayWithObjects: @"", RXMockObjectNullPlaceholder, nil]];
	[mock setResponseObject: nil forSelector: @selector(stringByReplacingOccurrencesOfString:withString:) withArguments: [NSArray arrayWithObjects: RXMockObjectNullPlaceholder, @"", nil]];
	RXAssertNil([mock propertyList]);
	RXAssertNil([mock componentsSeparatedByString: nil]);
	RXAssertNotNil([mock componentsSeparatedByString: @""]);
	RXAssertNil([mock stringByReplacingOccurrencesOfString: nil withString: nil]);
	RXAssertNotNil([mock stringByReplacingOccurrencesOfString: @"" withString: nil]);
	RXAssertNotNil([mock stringByReplacingOccurrencesOfString: nil withString: @""]);
}

@end
