// RXAssertions.h
// Created by Rob Rix on 2009-08-20
// Copyright 2009 Decimus Software, Inc.

#import <SenTestingKit/SenTestingKit.h>

// Assertion macros that don’t require you to describe the assertion. Perfect for use with intention-revealing code.

#define RXAssert(_expression) {\
	__typeof__(_expression) __condition = (_expression);\
	if(!__condition)\
		STFail(@"%s was unexpectedly false.", #_expression);\
}
#define RXAssertFalse(_expression) {\
	__typeof__(_expression) __condition = (_expression);\
	if(__condition)\
		STFail(@"%s was unexpectedly true.", #_expression);\
}

// casts the expected value to the type of the actual value. will fail (and rightly so) if you try crazy casts like struct to pointer.
#define RXAssertEquals(_actual, _expected) {\
	__typeof__(_actual) __actual = (_actual), __expected = (__typeof__(_actual))(_expected);\
	if(![RXAssertionHelper compareValue: &__actual withValue: &__expected ofObjCType: @encode(__typeof__(_actual))]) {\
		STFail(@"%s has value %@, not expected value %@.", #_actual, [RXAssertionHelper descriptionForValue: &__actual ofObjCType: @encode(__typeof__(_actual))], [RXAssertionHelper descriptionForValue: &__expected ofObjCType: @encode(__typeof__(_actual))]);\
	}\
}
#define RXAssertNotEquals(_actual, _expected) {\
	__typeof__(_actual) __actual = (_actual), __expected = (__typeof__(_actual))(_expected);\
	if([RXAssertionHelper compareValue: &__actual withValue: &__expected ofObjCType: @encode(__typeof__(_actual))]) {\
		STFail(@"%s has unexpected value %@.", #_actual, [RXAssertionHelper descriptionForValue: &__actual ofObjCType: @encode(__typeof__(_actual))]);\
	}\
}

#define RXAssertNil(_thing) {\
	__typeof__(_thing) __thing = (_thing);\
	if(__thing != nil) STFail(@"%s was unexpectedly %@, not nil.", #_thing, __thing);\
}
#define RXAssertNotNil(_thing) if((_thing) == nil) STFail(@"%s was unexpectedly nil.", #_thing)


#define RXUnionCast(x, toType) (((union{__typeof__(x) a; toType b;})x).b)
#define RXRound(value, place) (round((value) / (place)) * (place))


typedef BOOL (*RXAssertionHelperComparisonFunction)(const void *aRef, const void *bRef);
typedef NSString *(*RXAssertionHelperDescriptionFunction)(const void *ref);

@interface RXAssertionHelper : NSObject

+(void)registerComparisonFunction:(RXAssertionHelperComparisonFunction)comparator forObjCType:(const char *)type;
+(BOOL)compareValue:(const void *)aRef withValue:(const void *)bRef ofObjCType:(const char *)type;

+(void)registerDescriptionFunction:(RXAssertionHelperDescriptionFunction)descriptor forObjCType:(const char *)type;
+(NSString *)descriptionForValue:(const void *)ref ofObjCType:(const char *)type;

+(double)floatingPointComparisonAccuracy;
+(void)setFloatingPointComparisonAccuracy:(double)epsilon;

@end