// RXAssertionsTests.m
// Created by Rob Rix on 2009-09-27
// Copyright 2009 Monochrome Industries

#import "RXAssertions.h"

@interface RXAssertionsTests : SenTestCase {}
@end

@implementation RXAssertionsTests

-(void)testDemonstrateFailures {
	BOOL condition = NO;
	RXAssert(condition);
	condition = YES;
	RXAssertFalse(condition);
	id actual = @"one";
	id expected = @"two";
	RXAssertEquals(actual, expected);
	id unexpected = @"one";
	RXAssertNotEquals(actual, unexpected);
	
	id object = @"object";
	RXAssertNil(object);
	object = nil;
	RXAssertNotNil(object);
}

-(void)testCanAddOptionalFailureMessages {
	BOOL condition = NO;
	RXAssert(condition, @"This is a demonstration of an %@ failure", @"RXAssert");
	RXAssertFalse(!condition, @"This is a demonstration of an %@ failure", @"RXAssertFalse");
	
	id actual = @"one";
	id expected = @"two";
	RXAssertEquals(actual, expected, @"This is a demonstration of an %@ failure.", @"RXAssertEquals");
	id unexpected = @"one";
	RXAssertNotEquals(actual, unexpected, @"This is a demonstration of an %@ failure.", @"RXAssertNotEquals");
	
	id object = @"object";
	RXAssertNil(object, @"This is a demonstration of an %@ failure.", @"RXAssertNil");
	object = nil;
	RXAssertNotNil(object, @"This is a demonstration of an %@ failure.", @"RXAssertNotNil");
}

@end