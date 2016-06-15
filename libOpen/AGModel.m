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
#import "AGDateUtil.h"
#import <objc/runtime.h>
//#import "DSNumberUtil.h"

@interface AGModel(){
//    id raw;
}

@end

@implementation AGModel


+ (instancetype)instance{
    return [[self.class alloc] init];
}

- (instancetype)initFromDiskWithKey:(NSString *)key{
//    TLOG(@"%@", key);
    NSData *data = [self.userDefaults objectForKey:key];
    
    NSInteger localDataLen = data.length;
    if(localDataLen!=0) TLOG(@"%@ [%@]", self.className, [NSNumber numberWithInteger:data.length]);
    
    if (data.length > 0) {
        id instanceOnDisk = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (instanceOnDisk) return instanceOnDisk;
    }
    
    return [super init];
}

- (id)init{
    NSString *key = NSStringFromClass(self.class);
    return [self initFromDiskWithKey:key];
}


- (id)initWithCoder:(NSCoder *)aDecoder{
//    TLOG(@"%@", self.className);
    self = [super init];
    if (self) {
        //        [self setInvoiceNumber:[aDecoder decodeObjectForKey:@"invoiceNumber"]];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
//    TLOG(@"%@", NSStringFromClass(self.class));
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

- (void)saveToDiskWithKey:(NSString *)key{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    //    TLOG(@"save %@ %d", key, data.length);
    [self.userDefaults setObject:data forKey:key];
    TLOG(@"%@ SAVED", key);
}

- (void)saveToDisk{
    NSString *key = self.className;
    [self saveToDiskWithKey:key];
    
}

- (void)removeFromDisk{
//    self = [super init];
    NSString *key = self.className;
    [self.userDefaults removeObjectForKey:key];
    
}

#pragma mark - properties

- (NSString *)className{
    return NSStringFromClass(self.class);
}

- (NSUserDefaults *)userDefaults{
    if (_userDefaults) return _userDefaults;
    return [NSUserDefaults standardUserDefaults];
}

#pragma mark - converter

- (NSDate *)dateForKey:(NSString *)key{
    NSString *value = [DSValueUtil toString:[self.raw objectForKey:key]];
//    [self setBirthDate:d];
    return [AGDateUtil dateFromString:value];
}

- (NSString *)stringForKey:(NSString *)key{
    return [DSValueUtil toString:[self.raw objectForKey:key]];
}

//convert NSNumber to float will lose precision. e.g 1558038.94 -> 1558039
- (double)floatForKey:(NSString *)key{
    return [[self.raw objectForKey:key] doubleValue];
}

- (NSNumber *)numberForKey:(NSString *)key{
    id object = [self objectForKey:key];
    
    NSNumber *num;
    
    if ([object isKindOfClass:[NSString class]]) {
        num = [NSNumber numberWithDouble:[(NSString *)object doubleValue]];
    }
    
    if ([object isKindOfClass:[NSNumber class]]) {
        num = object;
    }
    
    return num;
}

- (id)objectForKey:(NSString *)key{
    return [self.raw objectForKey:key];
}

- (NSInteger)integerForKey:(NSString *)key{
    return [[self objectForKey:key] integerValue];
}

- (BOOL)boolForKey:(NSString *)key{
    return [[self objectForKey:key] boolValue];
}

- (BOOL)isAvailableForKey:(NSString *)key{
    if ([DSValueUtil isNotAvailable:self.raw]) return NO;
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


//- (NSArray *)propertyNames {
//    unsigned count;
//    objc_property_t *properties = class_copyPropertyList([self class], &count);
//    NSMutableArray *propertyNames = [NSMutableArray array];
//    for (int i = 0; i < count; i++) {
//        objc_property_t property = properties[i];
//        const char * name = property_getName(property);
//        NSString *stringName = [NSString stringWithUTF8String:name];
//        [propertyNames addObject:stringName];
//    }
//    free(properties);
//    return propertyNames;
//}

@end
