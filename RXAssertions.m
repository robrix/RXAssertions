// RXAssertions.m
// Created by Rob Rix on 2009-08-20
// Copyright 2009 Decimus Software, Inc.

#import <math.h>
#import "RXAssertions.h"

static NSMutableDictionary *RXAssertionHelperComparisonFunctions = nil;
static NSMutableDictionary *RXAssertionHelperDescriptionFunctions = nil;

static double RXAssertionHelperFloatingPointComparisonAccuracy = 0.0;

BOOL RXAssertionHelperInt8Comparison(const void *a, const void *b) {
	return (*(RXUnionCast(a, const uint8_t *))) == (*(RXUnionCast(b, const uint8_t *)));
}

BOOL RXAssertionHelperInt16Comparison(const void *a, const void *b) {
	return (*(RXUnionCast(a, const uint16_t *))) == (*(RXUnionCast(b, const uint16_t *)));
}

BOOL RXAssertionHelperInt32Comparison(const void *a, const void *b) {
	return (*(RXUnionCast(a, const uint32_t *))) == (*(RXUnionCast(b, const uint32_t *)));
}

BOOL RXAssertionHelperInt64Comparison(const void *a, const void *b) {
	return (*(RXUnionCast(a, const uint64_t *))) == (*(RXUnionCast(b, const uint64_t *)));
}

BOOL RXAssertionHelperFloatComparison(const void *a, const void *b) {
	double _a = *RXUnionCast(a, const float *), _b = *RXUnionCast(b, const float *);
	return isless(MAX(_a, _b) - MIN(_a, _b), RXAssertionHelperFloatingPointComparisonAccuracy);
}

BOOL RXAssertionHelperDoubleComparison(const void *a, const void *b) {
	double _a = *RXUnionCast(a, const double *), _b = *RXUnionCast(b, const double *);
	return isless(MAX(_a, _b) - MIN(_a, _b), RXAssertionHelperFloatingPointComparisonAccuracy);
}

BOOL RXAssertionHelperObjectComparison(const void *a, const void *b) {
	const id _a = *RXUnionCast(a, const id *), _b = *RXUnionCast(b, const id *);
	return (_a == _b) || [_a isEqual: _b];
}

BOOL RXAssertionHelperNSPointComparison(const void *a, const void *b) {
	return NSEqualPoints(*RXUnionCast(a, const NSPoint *), *RXUnionCast(b, const NSPoint *));
}


NSString *RXAssertionHelperHexadecimalDescription(const void *ref) {
	return [NSString stringWithFormat: @"%x", *RXUnionCast(ref, const void **)];
}

NSString *RXAssertionHelperInt8Description(const void *ref) {
	return [NSString stringWithFormat: @"%d", *RXUnionCast(ref, const int8_t *)];
}

NSString *RXAssertionHelperUInt8Description(const void *ref) {
	return [NSString stringWithFormat: @"%u", *RXUnionCast(ref, const uint8_t *)];
}

NSString *RXAssertionHelperInt16Description(const void *ref) {
	return [NSString stringWithFormat: @"%d", *RXUnionCast(ref, const int16_t *)];
}

NSString *RXAssertionHelperUInt16Description(const void *ref) {
	return [NSString stringWithFormat: @"%u", *RXUnionCast(ref, const uint16_t *)];
}

NSString *RXAssertionHelperInt32Description(const void *ref) {
	return [NSString stringWithFormat: @"%d", *RXUnionCast(ref, const int32_t *)];
}

NSString *RXAssertionHelperUInt32Description(const void *ref) {
	return [NSString stringWithFormat: @"%u", *RXUnionCast(ref, const uint32_t *)];
}

NSString *RXAssertionHelperInt64Description(const void *ref) {
	return [NSString stringWithFormat: @"%d", *RXUnionCast(ref, const int64_t *)];
}

NSString *RXAssertionHelperUInt64Description(const void *ref) {
	return [NSString stringWithFormat: @"%u", *RXUnionCast(ref, const uint64_t *)];
}

NSString *RXAssertionHelperFloatDescription(const void *ref) {
	return [NSString stringWithFormat: @"%f", *RXUnionCast(ref, const float *)];
}

NSString *RXAssertionHelperDoubleDescription(const void *ref) {
	return [NSString stringWithFormat: @"%f", *RXUnionCast(ref, const double *)];
}

NSString *RXAssertionHelperObjectDescription(const void *ref) {
	return [NSString stringWithFormat: @"%@", *RXUnionCast(ref, const id *)];
}

NSString *RXAssertionHelperNSPointDescription(const void *ref) {
	return NSStringFromPoint(*RXUnionCast(ref, const NSPoint *));
}


@implementation RXAssertionHelper

+(void)initialize {
	if(!RXAssertionHelperComparisonFunctions) {
		RXAssertionHelperComparisonFunctions = [[NSMutableDictionary alloc] init];
	}
	if(!RXAssertionHelperDescriptionFunctions) {
		RXAssertionHelperDescriptionFunctions = [[NSMutableDictionary alloc] init];
	}
	
#ifdef __LP64__
	[self registerComparisonFunction: RXAssertionHelperInt64Comparison forObjCType: @encode(void *)];
#else
	[self registerComparisonFunction: RXAssertionHelperInt32Comparison forObjCType: @encode(void *)];
#endif
	[self registerComparisonFunction: RXAssertionHelperInt8Comparison forObjCType: @encode(int8_t)];
	[self registerComparisonFunction: RXAssertionHelperInt8Comparison forObjCType: @encode(uint8_t)];
	[self registerComparisonFunction: RXAssertionHelperInt16Comparison forObjCType: @encode(int16_t)];
	[self registerComparisonFunction: RXAssertionHelperInt16Comparison forObjCType: @encode(uint16_t)];
	[self registerComparisonFunction: RXAssertionHelperInt32Comparison forObjCType: @encode(int32_t)];
	[self registerComparisonFunction: RXAssertionHelperInt32Comparison forObjCType: @encode(uint32_t)];
	[self registerComparisonFunction: RXAssertionHelperInt64Comparison forObjCType: @encode(int64_t)];
	[self registerComparisonFunction: RXAssertionHelperInt64Comparison forObjCType: @encode(uint64_t)];
	[self registerComparisonFunction: RXAssertionHelperFloatComparison forObjCType: @encode(float)];
	[self registerComparisonFunction: RXAssertionHelperDoubleComparison forObjCType: @encode(double)];
	[self registerComparisonFunction: RXAssertionHelperObjectComparison forObjCType: @encode(id)];
	[self registerComparisonFunction: RXAssertionHelperObjectComparison forObjCType: @encode(Class)];
	[self registerComparisonFunction: RXAssertionHelperNSPointComparison forObjCType: @encode(NSPoint)];
	[self registerComparisonFunction: RXAssertionHelperNSPointComparison forObjCType: @encode(CGPoint)];
	
	[self registerDescriptionFunction: RXAssertionHelperHexadecimalDescription forObjCType: @encode(void *)];
	[self registerDescriptionFunction: RXAssertionHelperInt8Description forObjCType: @encode(int8_t)];
	[self registerDescriptionFunction: RXAssertionHelperUInt8Description forObjCType: @encode(uint8_t)];
	[self registerDescriptionFunction: RXAssertionHelperInt16Description forObjCType: @encode(int16_t)];
	[self registerDescriptionFunction: RXAssertionHelperUInt16Description forObjCType: @encode(uint16_t)];
	[self registerDescriptionFunction: RXAssertionHelperInt32Description forObjCType: @encode(int32_t)];
	[self registerDescriptionFunction: RXAssertionHelperUInt32Description forObjCType: @encode(uint32_t)];
	[self registerDescriptionFunction: RXAssertionHelperInt64Description forObjCType: @encode(int64_t)];
	[self registerDescriptionFunction: RXAssertionHelperUInt64Description forObjCType: @encode(uint64_t)];
	[self registerDescriptionFunction: RXAssertionHelperFloatDescription forObjCType: @encode(float)];
	[self registerDescriptionFunction: RXAssertionHelperDoubleDescription forObjCType: @encode(double)];
	[self registerDescriptionFunction: RXAssertionHelperObjectDescription forObjCType: @encode(id)];
	[self registerDescriptionFunction: RXAssertionHelperObjectDescription forObjCType: @encode(Class)];
	[self registerDescriptionFunction: RXAssertionHelperNSPointDescription forObjCType: @encode(NSPoint)];
	[self registerDescriptionFunction: RXAssertionHelperNSPointDescription forObjCType: @encode(CGPoint)];
}


+(NSString *)keyForObjCType:(const char *)type {
	return [NSString stringWithFormat: @"%s", type];
}

+(RXAssertionHelperComparisonFunction)comparisonFunctionForObjCType:(const char *)type {
	return [[RXAssertionHelperComparisonFunctions objectForKey: [self keyForObjCType: type]] pointerValue];
}

+(void)registerComparisonFunction:(RXAssertionHelperComparisonFunction)comparator forObjCType:(const char *)type {
	[RXAssertionHelperComparisonFunctions setObject: [NSValue valueWithPointer: comparator] forKey: [self keyForObjCType: type]];
}

+(BOOL)compareValue:(const void *)aRef withValue:(const void *)bRef ofObjCType:(const char *)type {
	RXAssertionHelperComparisonFunction function =
		[self comparisonFunctionForObjCType: type]
	?:
#ifdef __LP64__
		RXAssertionHelperInt64Comparison;
#else
		RXAssertionHelperInt32Comparison;
#endif
	return function(aRef, bRef);
}


+(RXAssertionHelperDescriptionFunction)descriptionFunctionForObjCType:(const char *)type {
	return [[RXAssertionHelperDescriptionFunctions objectForKey: [self keyForObjCType: type]] pointerValue];
}

+(void)registerDescriptionFunction:(RXAssertionHelperDescriptionFunction)descriptor forObjCType:(const char *)type {
	[RXAssertionHelperDescriptionFunctions setObject: [NSValue valueWithPointer: descriptor] forKey: [self keyForObjCType: type]];
}

+(NSString *)descriptionForValue:(const void *)ref ofObjCType:(const char *)type {
	RXAssertionHelperDescriptionFunction function = [self descriptionFunctionForObjCType: type] ?: RXAssertionHelperHexadecimalDescription;
	return function(ref);
}


+(double)floatingPointComparisonAccuracy {
	return RXAssertionHelperFloatingPointComparisonAccuracy;
}

+(void)setFloatingPointComparisonAccuracy:(double)epsilon {
	RXAssertionHelperFloatingPointComparisonAccuracy = epsilon;
}

@end