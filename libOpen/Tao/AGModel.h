//
//  AGModel.h
//  AboveGEM
//
//  Created by traintrackcn on 7/5/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGModel : NSObject

- (id)initWithRaw:(id)raw;
- (void)updateWithRaw:(id)raw;

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *name;


@end
