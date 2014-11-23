//
//  AGModel.m
//  AboveGEM
//
//  Created by traintrackcn on 7/5/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGModel.h"
#import "DSValueUtil.h"
#import "GlobalDefine.h"


@interface AGModel(){
//    id raw;
}

@end

@implementation AGModel


+ (instancetype)instance{
    return [[self.class alloc] init];
}


- (id)init{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:NSStringFromClass(self.class)];
//    TLOG(@"%@ data -> %d", self.className, data.length);
    
    if (data.length > 0) {
        id instanceOnDisk = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if ([DSValueUtil isAvailable:instanceOnDisk]) return instanceOnDisk;
    }
    
    
    return [super init];
}


- (id)initWithCoder:(NSCoder *)aDecoder{
    TLOG(@"%@", self.className);
    self = [super init];
    if (self) {
        //        [self setInvoiceNumber:[aDecoder decodeObjectForKey:@"invoiceNumber"]];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    TLOG(@"%@", NSStringFromClass(self.class));
}

#pragma mark - raw data ops

- (id)initWithRaw:(NSDictionary *)raw{
    self = [super init];
    if (self) {
        [self setRaw:raw];
        [self updateWithRaw:raw];
    }
    return self;
}

- (void)updateWithRaw:(id)raw{
    [self setRaw:raw];
}

#pragma mark - ops

- (void)saveToDisk{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSString *key = self.className;
    //    TLOG(@"save %@ %d", key, data.length);
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
}

- (void)removeFromDisk{
//    self = [super init];
    NSString *key = self.className;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    
}

#pragma mark - properties

- (NSString *)className{
    return NSStringFromClass(self.class);
}

//#pragma mark - 
//
//- (void)setString:(NSString *)string forProperty:(id)property{
//    
//}

#pragma mark - converter

- (NSDate *)dateForKey:(NSString *)key{
    
    NSString *value = [DSValueUtil toString:[self.raw objectForKey:key]];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];

    
    if ([value rangeOfString:@"T"].location!=NSNotFound && [value rangeOfString:@"Z"].location != NSNotFound) {
        value = [value componentsSeparatedByString:@"T"].firstObject;
        [df setDateFormat:@"yyyy-MM-dd"];
    }else{
        [df setDateFormat:@"yyyy-MM-dd"];
    }
    NSDate *d = [df dateFromString:value];
//    [self setBirthDate:d];
    return d;
}

- (NSString *)stringForKey:(NSString *)key{
    return [DSValueUtil toString:[self.raw objectForKey:key]];
}

- (CGFloat)floatForKey:(NSString *)key{
    return [[self.raw objectForKey:key] floatValue];
}

- (NSInteger)integerForKey:(NSString *)key{
    return [[self.raw objectForKey:key] integerValue];
}

- (BOOL)isAvailableForKey:(NSString *)key{
    return [DSValueUtil isAvailable:[self.raw objectForKey:key]];
}

//- (void)setStringForKey:(NSString *)key selector:(SEL)selector{
//    if ([self isAvailableForKey:key]) {
////        selector([self stringForKey:key]);
////        SEL selector = NSSelectorFromString([NSString stringWithFormat:@"setName:"]);
//        IMP imp = [self methodForSelector:selector];
//        void (*func)(id, SEL) = (void *)imp;
//        func(self, selector);
////        [self performSelector:selector withObject:[self stringForKey:key]];
//    }
//    
//}

@end
