//
//  AGModel.h
//  AboveGEM
//
//  Created by traintrackcn on 7/5/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGModel : NSObject <NSCoding>

+ (instancetype)instance;

@property (nonatomic, strong) NSString *keyForSavingToDisk;

- (id)initWithRaw:(id)raw;
- (void)updateWithRaw:(id)raw;
- (void)saveToDisk;
- (void)removeFromDisk;
- (NSString *)className;


//- (void)setString:(NSString *)string forProperty:(id)property;

@end
