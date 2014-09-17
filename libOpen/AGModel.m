//
//  AGModel.m
//  AboveGEM
//
//  Created by traintrackcn on 7/5/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGModel.h"
#import "DSValueUtil.h"

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
        [self updateWithRaw:raw];
    }
    return self;
}

- (void)updateWithRaw:(id)raw{
    
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


@end
