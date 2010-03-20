// RXMockObject.m
// Created by Rob Rix on 2010-03-20
// Copyright 2010 Monochrome Industries

#import "RXMockObject.h"

@implementation RXMockObject

+(RXMockObject *)mockObject {
	return [[[self alloc] init] autorelease];
}

+(RXMockObject *)mockObjectRespondingToSelector:(SEL)selector withObject:(id)response {
	RXMockObject *object = [[[self alloc] init] autorelease];
	[object respondToSelector: selector withObject: response];
	return object;
}


-(id)init {
	if(self = [super init]) {
		responses = [[NSMutableDictionary alloc] init];
	}
	return self;
}

-(void)dealloc {
	[responses release];
	[super dealloc];
}


-(void)respondToSelector:(SEL)selector withObject:(id)response {
	[responses setObject: response forKey: NSStringFromSelector(selector)];
}


-(id)responseForSelector:(SEL)selector {
	return [responses objectForKey: NSStringFromSelector(selector)];
}


-(NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
	NSMethodSignature *signature = nil;
	if([self responseForSelector: selector]) {
		signature = [super methodSignatureForSelector: @selector(self)];
	}
	return signature;
}

-(void)forwardInvocation:(NSInvocation *)invocation {
	id response = [self responseForSelector: invocation.selector];
	[invocation setReturnValue: &response];
}

@end
