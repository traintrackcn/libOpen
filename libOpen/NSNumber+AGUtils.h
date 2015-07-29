//
//  NSNumber+AGUtils.h
//  AboveGEM
//
//  Created by Tao Yunfei on 4/3/15.
//
//

#import <Foundation/Foundation.h>

@interface NSNumber (AGUtils)

- (BOOL)isZero;
- (BOOL)isNotZero;
- (NSNumber *)minus:(NSNumber *)num;
- (NSNumber *)plus:(NSNumber *)num;

- (BOOL)isSmallerThan:(NSNumber *)num;
- (BOOL)isBiggerThan:(NSNumber *)num;

- (BOOL)isNotSmallerThan:(NSNumber *)num;
- (BOOL)isNotBiggerThan:(NSNumber *)num;

- (NSString *)valueForCurrency;
- (NSString *)valueForPercent;

@end
