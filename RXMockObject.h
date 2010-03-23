// RXMockObject.h
// Created by Rob Rix on 2010-03-20
// Copyright 2010 Monochrome Industries

#import <Foundation/Foundation.h>

extern NSString const *RXMockObjectNullPlaceholder;

@interface RXMockObject : NSObject {
	NSMutableDictionary *responses;
}

+(RXMockObject *)mockObject;
+(RXMockObject *)mockObjectWithResponseObject:(id)response forSelector:(SEL)selector;
+(RXMockObject *)mockObjectWithResponseObject:(id)response forSelector:(SEL)selector withArgument:(id)argument;
+(RXMockObject *)mockObjectWithResponseObject:(id)response forSelector:(SEL)selector withArguments:(NSArray *)arguments;

-(void)setResponseObject:(id)object forSelector:(SEL)selector;
-(void)setResponseObject:(id)object forSelector:(SEL)selector withArgument:(id)argument;
-(void)setResponseObject:(id)response forSelector:(SEL)selector withArguments:(NSArray *)arguments;

@end
