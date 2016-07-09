//
// Created by Sergey Fedortsov on 8.7.16.
// Copyright (c) 2016 Sergey Fedortsov. All rights reserved.
//

#import <Foundation/Foundation.h>


@class SFPPredicateFormatterFormatAvailable;


@interface SFPPredicateFormatter : NSObject
- (SFPPredicateFormatter*(^)(NSString*))where;
- (SFPPredicateFormatter*)whereSelf;
- (SFPPredicateFormatter*(^)(NSString*))whereAny;
- (SFPPredicateFormatter*(^)(NSString*))whereAll;


- (SFPPredicateFormatterFormatAvailable*(^)(id constant))equals;
- (SFPPredicateFormatterFormatAvailable*(^)(id constant))notEquals;
- (SFPPredicateFormatterFormatAvailable*(^)(id constant))greaterThan;
- (SFPPredicateFormatterFormatAvailable*(^)(id constant))greaterThanOrEquals;
- (SFPPredicateFormatterFormatAvailable*(^)(id constant))lessThan;
- (SFPPredicateFormatterFormatAvailable*(^)(id constant))lessThanOrEquals;
- (SFPPredicateFormatterFormatAvailable*(^)(id constant))between;


- (SFPPredicateFormatterFormatAvailable*(^)(id constant))in;

- (SFPPredicateFormatterFormatAvailable*(^)(NSString* constant))beginsWith;
- (SFPPredicateFormatterFormatAvailable*(^)(NSString* constant))contains;
- (SFPPredicateFormatterFormatAvailable*(^)(NSString* constant))endsWith;
- (SFPPredicateFormatterFormatAvailable*(^)(NSString* constant))like;
- (SFPPredicateFormatterFormatAvailable*(^)(NSString* constant))matches;


- (SFPPredicateFormatter*)and;
- (SFPPredicateFormatter*)or;
- (SFPPredicateFormatter*)not;

@end



@interface SFPPredicateFormatterFormatAvailable : SFPPredicateFormatter
- (NSPredicate *)format;
@end