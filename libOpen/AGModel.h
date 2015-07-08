//
//  AGModel.h
//  AboveGEM
//
//  Created by traintrackcn on 7/5/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface AGModel : NSObject <NSCoding>

+ (instancetype)instance;

@property (nonatomic, strong) NSString *keyForSavingToDisk;
@property (nonatomic, strong) id raw;

- (id)initWithRaw:(id)raw;
- (void)updateWithRaw:(id)raw;
- (void)saveToDisk;
- (void)removeFromDisk;
- (NSString *)className;

#pragma mark - converter
- (NSDate *)dateForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;
- (double)floatForKey:(NSString *)key;
- (NSNumber *)numberForKey:(NSString *)key;
- (NSInteger)integerForKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key;
- (BOOL)isAvailableForKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;

//- (void)setStringForKey:(NSString *)key selector:(SEL)selector;
//- (NSArray *)propertyNames;

@end
