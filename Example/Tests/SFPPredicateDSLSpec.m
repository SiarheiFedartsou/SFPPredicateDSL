//
//  SFPPredicateDSLSpec.m
//  Predicate
//
//  Created by Sergey Fedortsov on 8.7.16.
//  Copyright (c) 2016 Sergey Fedortsov. All rights reserved.
//


#import <Specta/Specta.h>
#import <Expecta/Expecta.h>


#import <SFPPredicateDSL/SFPPredicateDSL.h>

SpecBegin(SFPPredicateDSL)
    describe(@"NSPredicate SFPPredicateDSL category", ^{
        it(@"should provide pretty interface to produce NSPredicate's", ^ {
            NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath == 10"] predicateFormat];
            NSString *actualPredicateFormat = [[NSPredicate predicate:where(@"keypath").equals(@10)] predicateFormat];
            expect(expectedPredicateFormat).to.equal(actualPredicateFormat);
        });

        it(@"should produce valid predicates for filtering arrays", ^ {
            NSArray* originalArray = @[@10, @20, @30, @40, @50];
            NSArray* filteredArray = [originalArray filteredArrayUsingPredicate:[NSPredicate predicate:whereSelf().greaterThan(@25)]];
            expect(filteredArray).to.equal(@[@30, @40, @50]);
        });



    });

SpecEnd

