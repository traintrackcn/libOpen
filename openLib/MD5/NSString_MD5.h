//
//  NSString_MD5.h
//  iPart
//
//  Created by Jason on 6/17/10.
//  Copyright 2010 iPart. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (NSString_MD5)
- (NSString *) md5;
@end

@interface NSData (NSString_MD5)
- (NSString*)md5;
@end

