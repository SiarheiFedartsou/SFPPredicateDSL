//
//  SFPPredicateFormatterSpec.m
//  Predicate
//
//  Created by Sergey Fedortsov on 8.7.16.
//  Copyright (c) 2016 Sergey Fedortsov. All rights reserved.
//

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>


@import SFPPredicateDSL;

SpecBegin(SFPPredicateFormatter)
describe(@"SFPPredicateFormatter", ^{
    describe(@"should generate valid NSPredicate", ^{
        it(@"for == predicates", ^{
            SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
            NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath == 10"] predicateFormat];
            NSString *actualPredicateFormat = [[formatter.where(@"keypath").equals(@10) format] predicateFormat];
            expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
        });

        it(@"for != predicates", ^{
            SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
            NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath != 10"] predicateFormat];
            NSString *actualPredicateFormat = [[formatter.where(@"keypath").notEquals(@10) format] predicateFormat];
            expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
        });

        it(@"for IN predicates", ^{
            SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
            NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath IN %@", @[@1, @2, @3]] predicateFormat];
            NSString *actualPredicateFormat = [[formatter.where(@"keypath").in(@[@1, @2, @3]) format] predicateFormat];
            expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
        });

        it(@"for BETWEEN predicates", ^{
            SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
            NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath BETWEEN %@", @[@1, @20]] predicateFormat];
            NSString *actualPredicateFormat = [[formatter.where(@"keypath").between(@[@1, @20]) format] predicateFormat];
            expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
        });

        it(@"for > predicates", ^{
            SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
            NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath > %@", @10] predicateFormat];
            NSString *actualPredicateFormat = [[formatter.where(@"keypath").greaterThan(@10) format] predicateFormat];
            expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
        });

        it(@"for >= predicates", ^{
            SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
            NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath >= %@", @10] predicateFormat];
            NSString *actualPredicateFormat = [[formatter.where(@"keypath").greaterThanOrEquals(@10) format] predicateFormat];
            expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
        });

        it(@"for < predicates", ^{
            SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
            NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath < %@", @10] predicateFormat];
            NSString *actualPredicateFormat = [[formatter.where(@"keypath").lessThan(@10) format] predicateFormat];
            expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
        });

        it(@"for <= predicates", ^{
            SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
            NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath <= %@", @10] predicateFormat];
            NSString *actualPredicateFormat = [[formatter.where(@"keypath").lessThanOrEquals(@10) format] predicateFormat];
            expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
        });


        it(@"for BEGINSWITH predicates", ^{
            SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
            NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath BEGINSWITH \"test\""] predicateFormat];
            NSString *actualPredicateFormat = [[formatter.where(@"keypath").beginsWith(@"test") format] predicateFormat];
            expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
        });

        it(@"for CONTAINS predicates", ^{
            SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
            NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath CONTAINS \"test\""] predicateFormat];
            NSString *actualPredicateFormat = [[formatter.where(@"keypath").contains(@"test") format] predicateFormat];
            expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
        });

        it(@"for ENDSWITH predicates", ^{
            SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
            NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath ENDSWITH \"test\""] predicateFormat];
            NSString *actualPredicateFormat = [[formatter.where(@"keypath").endsWith(@"test") format] predicateFormat];
            expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
        });

        it(@"for LIKE predicates", ^{
            SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
            NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath LIKE \"test\""] predicateFormat];
            NSString *actualPredicateFormat = [[formatter.where(@"keypath").like(@"test") format] predicateFormat];
            expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
        });

        it(@"for MATCHES predicates", ^{
            SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
            NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath MATCHES \"test\""] predicateFormat];
            NSString *actualPredicateFormat = [[formatter.where(@"keypath").matches(@"test") format] predicateFormat];
            expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
        });

        it(@"for two AND subpredicates", ^{
            SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
            NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath == 10 AND keypath2 == 20"] predicateFormat];
            NSString *actualPredicateFormat = [[formatter.where(@"keypath").equals(@10).and.where(@"keypath2").equals(@20) format] predicateFormat];
            expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
        });

        it(@"for three AND subpredicates", ^{
            SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
            NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath == 10 AND keypath2 == 20 AND keypath3 == 30"] predicateFormat];
            NSString *actualPredicateFormat = [[formatter.where(@"keypath").equals(@10).and.
                    where(@"keypath2").equals(@20).and.
                    where(@"keypath3").equals(@30) format] predicateFormat];
            expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
        });

        it(@"for mixed OR and AND subpredicates", ^{
            SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
            NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"(keypath == 10 AND keypath2 == 20) OR keypath3 == 30"] predicateFormat];
            NSString *actualPredicateFormat = [[formatter.where(@"keypath").equals(@10).and.
                    where(@"keypath2").equals(@20).or.
                    where(@"keypath3").equals(@30) format] predicateFormat];
            expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
        });

        it(@"for logical NOT", ^{
            SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
            NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"NOT keypath IN %@", @[@1, @2, @3]] predicateFormat];
            NSString *actualPredicateFormat = [[formatter.where(@"keypath").not.in(@[@1, @2, @3]) format] predicateFormat];
            expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
        });


        it(@"for predicates with ANY modifier", ^{
            SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
            NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"ANY keypaths == 10"] predicateFormat];
            NSString *actualPredicateFormat = [[formatter.whereAny(@"keypaths").equals(@10) format] predicateFormat];
            expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
        });

        it(@"for predicates with ALL modifier", ^{
            SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
            NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"ALL keypaths == 10"] predicateFormat];
            NSString *actualPredicateFormat = [[formatter.whereAll(@"keypaths").equals(@10) format] predicateFormat];
            expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
        });

        it(@"for SELF predicates", ^{
            SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
            NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"SELF == 10"] predicateFormat];
            NSString *actualPredicateFormat = [[formatter.whereSelf.equals(@10) format] predicateFormat];
            expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
        });


    });


});

SpecEnd
