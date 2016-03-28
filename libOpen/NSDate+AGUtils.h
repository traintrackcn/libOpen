//
//  NSDate+AGText.h
//  AboveGEM
//
//  Created by traintrackcn on 9/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (AGUtils)

- (NSString *)textStyleShort;
- (NSString *)textStyleDefault;
- (NSString *)textStyleDetail;
- (NSString *)textStyleForPost;
- (NSString *)textStyleForPostAutoshipDate;

- (NSString *)valueForPost;
- (NSString *)valueForPostStyleUTC;

@end
