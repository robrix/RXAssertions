// RXMockObject.h
// Created by Rob Rix on 2010-03-20
// Copyright 2010 Monochrome Industries

#import <Foundation/Foundation.h>

@interface RXMockObject : NSObject {
	NSMutableDictionary *responses;
}

+(RXMockObject *)mockObject;
+(RXMockObject *)mockObjectRespondingToSelector:(SEL)selector withObject:(id)response;

-(void)respondToSelector:(SEL)selector withObject:(id)response;

@end
