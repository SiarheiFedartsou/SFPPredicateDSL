//
// Created by Sergey Fedortsov on 8.7.16.
// Copyright (c) 2016 Sergey Fedortsov. All rights reserved.
//

#import "SFPPredicateFormatter.h"

typedef NS_ENUM(NSUInteger, SFPPredicateFormatterLogicalOperation) {
    SFPPredicateFormatterLogicalOperationUnknown,
    SFPPredicateFormatterLogicalOperationAnd,
    SFPPredicateFormatterLogicalOperationOr
};

@interface SFPPredicateFormatter ()
@property (nonatomic, strong) NSExpression* leftExpression;

@property (nonatomic, strong) NSMutableArray* predicates;

@property (nonatomic, assign) SFPPredicateFormatterLogicalOperation currentLogicalOperation;

@property (nonatomic, assign) NSComparisonPredicateModifier currentComparisonPredicateModifier;

@property (nonatomic, assign) BOOL isNot;
@end

@implementation SFPPredicateFormatter {

}

- (instancetype) init
{
    if (self = [super init]) {
        self.currentComparisonPredicateModifier = NSDirectPredicateModifier;
        self.predicates = [[NSMutableArray alloc] init];
    }
    return self;
}

- (SFPPredicateFormatter*(^)(NSString*))where
{
    return ^ SFPPredicateFormatter* (NSString* keyPath) {
        self.currentComparisonPredicateModifier = NSDirectPredicateModifier;
        self.leftExpression = [NSExpression expressionWithFormat:@"%K", keyPath];
        return self;
    };
}

- (SFPPredicateFormatter*)whereSelf
{
    self.currentComparisonPredicateModifier = NSDirectPredicateModifier;
    self.leftExpression = [NSExpression expressionWithFormat:@"SELF"];
    return self;
}

- (SFPPredicateFormatter*(^)(NSString*))whereAny
{
    return ^ SFPPredicateFormatter* (NSString* keyPath) {
        self.currentComparisonPredicateModifier = NSAnyPredicateModifier;
        self.leftExpression = [NSExpression expressionWithFormat:@"%K", keyPath];
        return self;
    };
}

- (SFPPredicateFormatter*(^)(NSString*))whereAll
{
    return ^ SFPPredicateFormatter* (NSString* keyPath) {
        self.currentComparisonPredicateModifier = NSAllPredicateModifier;
        self.leftExpression = [NSExpression expressionWithFormat:@"%K", keyPath];
        return self;
    };
}

- (SFPPredicateFormatterFormatAvailable*(^)(id constant)) predicateGeneratorWithOperatorType:(NSPredicateOperatorType)operatorType
{
    return  ^ SFPPredicateFormatterFormatAvailable* (NSString* constant) {

        NSExpression* rightExpression = [NSExpression expressionWithFormat:@"%@", constant];
        NSPredicate* predicate = [NSComparisonPredicate predicateWithLeftExpression:self.leftExpression
                                                                    rightExpression:rightExpression
                                                                           modifier:self.currentComparisonPredicateModifier
                                                                               type:operatorType
                                                                            options:0];
        if (self.isNot) {
            predicate = [NSCompoundPredicate notPredicateWithSubpredicate:predicate];
            self.isNot = NO;
        }

        [self.predicates addObject:predicate];

        return (SFPPredicateFormatterFormatAvailable*)self;
    };
}




- (SFPPredicateFormatterFormatAvailable*(^)(id constant))equals
{
    return [self predicateGeneratorWithOperatorType:NSEqualToPredicateOperatorType];
}

- (SFPPredicateFormatterFormatAvailable*(^)(id constant))notEquals
{
    return [self predicateGeneratorWithOperatorType:NSNotEqualToPredicateOperatorType];
}

- (SFPPredicateFormatterFormatAvailable*(^)(id constant))greaterThan
{
    return [self predicateGeneratorWithOperatorType:NSGreaterThanPredicateOperatorType];
}

- (SFPPredicateFormatterFormatAvailable*(^)(id constant))greaterThanOrEquals
{
    return [self predicateGeneratorWithOperatorType:NSGreaterThanOrEqualToPredicateOperatorType];
}

- (SFPPredicateFormatterFormatAvailable*(^)(id constant))lessThan
{
    return [self predicateGeneratorWithOperatorType:NSLessThanPredicateOperatorType];
}

- (SFPPredicateFormatterFormatAvailable*(^)(id constant))lessThanOrEquals
{
    return [self predicateGeneratorWithOperatorType:NSLessThanOrEqualToPredicateOperatorType];
}

- (SFPPredicateFormatterFormatAvailable*(^)(id constant))between
{
    return [self predicateGeneratorWithOperatorType:NSBetweenPredicateOperatorType];
}

- (SFPPredicateFormatterFormatAvailable*(^)(id constant))in
{
    return [self predicateGeneratorWithOperatorType:NSInPredicateOperatorType];
}

- (SFPPredicateFormatterFormatAvailable*(^)(NSString* constant))beginsWith
{
    return [self predicateGeneratorWithOperatorType:NSBeginsWithPredicateOperatorType];
}

- (SFPPredicateFormatterFormatAvailable*(^)(NSString* constant))contains
{
    return [self predicateGeneratorWithOperatorType:NSContainsPredicateOperatorType];
}

- (SFPPredicateFormatterFormatAvailable*(^)(NSString* constant))endsWith
{
    return [self predicateGeneratorWithOperatorType:NSEndsWithPredicateOperatorType];
}

- (SFPPredicateFormatterFormatAvailable*(^)(NSString* constant))like
{
    return [self predicateGeneratorWithOperatorType:NSLikePredicateOperatorType];
}

- (SFPPredicateFormatterFormatAvailable*(^)(NSString* constant))matches
{
    return [self predicateGeneratorWithOperatorType:NSMatchesPredicateOperatorType];
}

- (SFPPredicateFormatter*)and
{
    switch (self.currentLogicalOperation) {
        case SFPPredicateFormatterLogicalOperationOr:
        {
            NSPredicate* predicate = [NSCompoundPredicate orPredicateWithSubpredicates:self.predicates];
            [self.predicates removeAllObjects];
            [self.predicates addObject:predicate];
            self.currentLogicalOperation = SFPPredicateFormatterLogicalOperationAnd;

            return self;
        }
        case SFPPredicateFormatterLogicalOperationUnknown:
        case SFPPredicateFormatterLogicalOperationAnd:
        {
            self.currentLogicalOperation = SFPPredicateFormatterLogicalOperationAnd;
            return self;
        }
    }
    return self;
}

- (SFPPredicateFormatter*)or
{
    switch (self.currentLogicalOperation) {
        case SFPPredicateFormatterLogicalOperationAnd:
        {
            NSPredicate* predicate = [NSCompoundPredicate andPredicateWithSubpredicates:self.predicates];
            [self.predicates removeAllObjects];
            [self.predicates addObject:predicate];
            self.currentLogicalOperation = SFPPredicateFormatterLogicalOperationOr;
            return self;
        }
        case SFPPredicateFormatterLogicalOperationUnknown:
        case SFPPredicateFormatterLogicalOperationOr:
        {
            return self;
        }
    }
    return self;
}


- (SFPPredicateFormatter*)not
{
    self.isNot = YES;
    return self;
}

- (NSPredicate*)format
{
    switch (self.currentLogicalOperation) {
        case SFPPredicateFormatterLogicalOperationAnd:
            return [NSCompoundPredicate andPredicateWithSubpredicates:self.predicates];
        case SFPPredicateFormatterLogicalOperationOr:
            return [NSCompoundPredicate orPredicateWithSubpredicates:self.predicates];
        case SFPPredicateFormatterLogicalOperationUnknown:
            return self.predicates[0];
    }

    if ([self.predicates count] >= 1) {

        return [NSCompoundPredicate andPredicateWithSubpredicates:self.predicates];
    } else {
        return self.predicates[0];
    }
}

@end

@implementation SFPPredicateFormatterFormatAvailable

- (NSPredicate *)format {
    return [super format];
}

@end