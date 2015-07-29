//
//  NSNumber+AGUtils.m
//  AboveGEM
//
//  Created by Tao Yunfei on 4/3/15.
//
//

#import "NSNumber+AGUtils.h"
#import "DSValueUtil.h"

@implementation NSNumber (AGUtils)

- (BOOL)isZero{
    return [self isEqualToNumber:[NSNumber numberWithFloat:0]];
}

- (BOOL)isNotZero{
    return ![self isZero];
}

- (NSNumber *)minus:(NSNumber *)num{
    double value = self.doubleValue - num.doubleValue;
    return [NSNumber numberWithDouble:value];
}

- (NSNumber *)plus:(NSNumber *)num{
    double value = self.doubleValue - num.doubleValue;
    return [NSNumber numberWithDouble:value];
}

- (BOOL)isSmallerThan:(NSNumber *)num{
    if ([self compare:num] == NSOrderedAscending) {
        return YES;
    }
    return NO;
}

- (BOOL)isNotSmallerThan:(NSNumber *)num{
    return ![self isSmallerThan:num];
}

- (BOOL)isBiggerThan:(NSNumber *)num{
    if ([self compare:num] == NSOrderedDescending) {
        return YES;
    }
    return NO;
}

- (BOOL)isNotBiggerThan:(NSNumber *)num{
    return ![self isBiggerThan:num];
}

#pragma mark - formatter

- (NSString *)valueForPercent{
    NSNumber *num = [self copy];
    NSNumberFormatter *f = self.numberFormatter;
    //    [f setPositiveFormat:@"0.##"];
    [f setNumberStyle:NSNumberFormatterPercentStyle];
    [f setMaximumFractionDigits:2];
    NSString *result = [f stringFromNumber:num];
    if ([DSValueUtil isNotAvailable:result]) result = @"0%";
    return result;
}

#pragma mark - kinds of formats

- (NSString *)valueForCurrency{
    NSNumberFormatter *f = [[NSNumberFormatter alloc]init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    [f setRoundingMode:NSNumberFormatterRoundHalfUp];
    [f setMaximumFractionDigits:2];
    [f setMinimumFractionDigits:2];
    return [f stringFromNumber:self];
}

- (NSNumberFormatter *)numberFormatter{
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    [f setLocale:[NSLocale currentLocale]];
    //    TLOG(@"self.languageID -> %@", self.languageID);
    return f;
}


@end