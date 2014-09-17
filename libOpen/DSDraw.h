//
//  DSDraw.h
//  og
//
//  Created by traintrackcn on 13-8-7.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSDraw : NSObject

+ (void)drawEclipse:(CGContextRef)c rect:(CGRect)rect fillColor:(UIColor *)fillColor;
+ (void)drawRect:(CGContextRef)c rect:(CGRect)rect fillColor:(UIColor *)fillColor;
+ (void)drawLine:(CGContextRef)c startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint strokeColor:(UIColor *)strokeColor  lineWidth:(CGFloat)lineWidth;
@end
