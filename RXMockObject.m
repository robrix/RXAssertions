// RXMockObject.m
// Created by Rob Rix on 2010-03-20
// Copyright 2010 Monochrome Industries

#import "RXMockObject.h"
#import <objc/runtime.h>

NSString const *RXMockObjectNullPlaceholder = @"RXMockObjectNullPlaceholder";

@implementation RXMockObject

-(id)initWithClass:(Class)_mockedClass {
	if(self = [super init]) {
		responses = [[NSMutableDictionary alloc] init];
		mockedClass = _mockedClass;
	}
	return self;
}

-(void)dealloc {
	[responses release];
	[super dealloc];
}

+(RXMockObject *)mockObjectForClass:(Class)mockedClass {
	return [[[self alloc] initWithClass: mockedClass] autorelease];
}

+(RXMockObject *)mockObjectForClass:(Class)mockedClass withResponseObject:(id)response forSelector:(SEL)selector {
	RXMockObject *object = [[[self alloc] initWithClass: mockedClass] autorelease];
	[object setResponseObject: response forSelector: selector];
	return object;
}

+(RXMockObject *)mockObjectForClass:(Class)mockedClass withResponseObject:(id)response forSelector:(SEL)selector withArgument:(id)argument {
	RXMockObject *object = [[[self alloc] initWithClass: mockedClass] autorelease];
	[object setResponseObject: response forSelector: selector withArgument: argument];
	return object;
}

+(RXMockObject *)mockObjectForClass:(Class)mockedClass withResponseObject:(id)response forSelector:(SEL)selector withArguments:(NSArray *)arguments {
	RXMockObject *object = [[[self alloc] initWithClass: mockedClass] autorelease];
	[object setResponseObject: response forSelector: selector withArguments: arguments];
	return object;
}


-(void)setResponseObject:(id)response forSelector:(SEL)selector {
	[self setResponseObject: response forSelector: selector withArguments: [NSArray array]];
	
}

-(void)setResponseObject:(id)response forSelector:(SEL)selector withArgument:(id)argument {
	[self setResponseObject: response forSelector: selector withArguments: [NSArray arrayWithObject: argument ?: RXMockObjectNullPlaceholder]];
}

-(void)setResponseObject:(id)response forSelector:(SEL)selector withArguments:(NSArray *)arguments {
	NSMutableDictionary *responsesByArguments = [responses objectForKey: NSStringFromSelector(selector)];
	if(!responsesByArguments) {
		[responses setObject: (responsesByArguments = [NSMutableDictionary dictionary]) forKey: NSStringFromSelector(selector)];
	}
	[responsesByArguments setObject: response forKey: arguments];
}

-(id)responsesForSelector:(SEL)selector {
	return [responses objectForKey: NSStringFromSelector(selector)];
}

-(id)responseForSelector:(SEL)selector withArguments:(NSArray *)arguments {
	return [[self responsesForSelector: selector] objectForKey: arguments];
}


-(NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
	NSMethodSignature *signature = nil;
	if([self responsesForSelector: selector]) {
		signature = [mockedClass instanceMethodSignatureForSelector: selector];
	}
	return signature;
}

-(void)forwardInvocation:(NSInvocation *)invocation {
	if([self responsesForSelector: invocation.selector]) {
		NSMutableArray *arguments = [NSMutableArray array];
		for(NSUInteger i = 2; i < invocation.methodSignature.numberOfArguments; i++) {
			id argument;
			[invocation getArgument: &argument atIndex: i];
			[arguments addObject: argument ?: RXMockObjectNullPlaceholder];
		}
		id response = [self responseForSelector: invocation.selector withArguments: [arguments copy]];
		[invocation setReturnValue: &response];
	}
}

@end
