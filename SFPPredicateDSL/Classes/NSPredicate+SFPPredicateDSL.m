//
// Created by Sergey Fedortsov on 8.7.16.
// Copyright (c) 2016 Sergey Fedortsov. All rights reserved.
//

#import "NSPredicate+SFPPredicateDSL.h"
#import "SFPPredicateFormatter.h"


@implementation NSPredicate (SFPPredicateDSL)


+ (instancetype) predicate:(SFPPredicateFormatterFormatAvailable*)formatter
{
    return [formatter format];
}

@end