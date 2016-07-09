//
// Created by Sergey Fedortsov on 8.7.16.
// Copyright (c) 2016 Sergey Fedortsov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SFPPredicateFormatter.h"

#ifndef SFPPREDICATE_FORMATTER_USE_PREFIXES
#define SFPWHERENAME where
#define SFPWHEREANYNAME whereAny
#define SFPWHEREALLNAME whereAll
#define SFPWHERESELFNAME whereSelf

#else
#define SFPWHERENAME SFPWhere
#define SFPWHEREANYNAME SFPWhereAny
#define SFPWHEREALLNAME SFPWhereAll
#define SFPWHERESELFNAME SFPWhereSelf

#endif

static inline SFPPredicateFormatter * SFPWHERESELFNAME() {
    SFPPredicateFormatter* formatter = [[SFPPredicateFormatter alloc] init];
    return formatter.whereSelf;
}

static inline SFPPredicateFormatter * SFPWHERENAME(NSString* keyPath) {
    SFPPredicateFormatter* formatter = [[SFPPredicateFormatter alloc] init];
    return formatter.where(keyPath);
}

static inline SFPPredicateFormatter * SFPWHEREANYNAME(NSString* keyPath) {
    SFPPredicateFormatter* formatter = [[SFPPredicateFormatter alloc] init];
    return formatter.whereAny(keyPath);
}

static inline SFPPredicateFormatter * SFPWHEREALLNAME(NSString* keyPath) {
    SFPPredicateFormatter* formatter = [[SFPPredicateFormatter alloc] init];
    return formatter.whereAll(keyPath);
}


@interface NSPredicate (SFPPredicateDSL)
+ (instancetype) predicate:(SFPPredicateFormatterFormatAvailable*)formatter;
@end