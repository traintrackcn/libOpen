//
//  NSDate+AGText.m
//  AboveGEM
//
//  Created by traintrackcn on 9/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "NSDate+AGUtils.h"

@implementation NSDate (AGUtils)


- (NSString *)textStyleShort{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:[NSDateFormatter dateFormatFromTemplate:@"yyyyMMM" options:0 locale:[NSLocale currentLocale]]];
    
    return [dateFormatter stringFromDate:self];
    
//    NSLog(@"Happy New Year: %@", dateString);
    
    
//    return [NSDateFormatter localizedStringFromDate:self dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)textStyleDefault{
//    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//    [df setDateFormat:@"yyyy-MM-dd"];
//    return  [df stringFromDate:self];
    return [NSDateFormatter localizedStringFromDate:self dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)textStyleDetail{
//    NSDateFormatter *df = [[NSDateFormatter alloc] init];
////    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
//    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"he"];
//    [df setLocale:locale];
//    return  [df stringFromDate:self];
    
    return [NSDateFormatter localizedStringFromDate:self dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)textStyleForPost{
    NSDateFormatter *dfDate = [[NSDateFormatter alloc] init];
    [dfDate setDateFormat:@"yyyy-MM-dd"];
    
    NSDateFormatter *dfTime = [[NSDateFormatter alloc] init];
    [dfTime setDateFormat:@"HH:mm"];
    
    return  [NSString stringWithFormat:@"%@T%@", [dfDate stringFromDate:self], [dfTime stringFromDate:self]];
}


- (NSString *)valueForPost{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    return  [df stringFromDate:self];
}

- (NSString *)valueForPostStyleUTC{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [df setTimeZone:timeZone];
    NSDateFormatter *dfDate = [[NSDateFormatter alloc] init];
    [dfDate setDateFormat:@"yyyy-MM-dd"];
    
    NSDateFormatter *dfTime = [[NSDateFormatter alloc] init];
    [dfTime setDateFormat:@"HH:mm:ss"];
    return  [NSString stringWithFormat:@"%@T%@Z", [dfDate stringFromDate:self], [dfTime stringFromDate:self]];
}

- (NSString *)textStyleForPostAutoshipDate{
    NSDateFormatter *dfDate = [[NSDateFormatter alloc] init];
    [dfDate setDateFormat:@"yyyy-MM-dd"];
    return  [NSString stringWithFormat:@"%@", [dfDate stringFromDate:self]];
}

@end
