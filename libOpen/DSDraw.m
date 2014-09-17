//
//  DSDraw.m
//  og
//
//  Created by traintrackcn on 13-8-7.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import "DSDraw.h"

static DSDraw *____instanceDSDraw;

@implementation DSDraw

+ (DSDraw *)sharedInstance{
    if (!____instanceDSDraw) {
        ____instanceDSDraw = [[DSDraw alloc] init];
    }
    return ____instanceDSDraw;
}

- (id)init{
    self = [super init];
    if (self) {
    
    }
    return self;
}


+ (void)drawEclipse:(CGContextRef)c rect:(CGRect)rect fillColor:(UIColor *)fillColor{
    CGContextSaveGState(c);
    CGContextSetFillColorWithColor(c, [fillColor CGColor]);
    CGContextFillEllipseInRect(c, rect);
    CGContextRestoreGState(c);
}

+ (void)drawRect:(CGContextRef)c rect:(CGRect)rect fillColor:(UIColor *)fillColor{
    CGContextSaveGState(c);
    CGContextSetFillColorWithColor(c, [fillColor CGColor]);
//    CGContextAddRect(c, rect);
    CGContextFillRect(c, rect);
    CGContextRestoreGState(c);
}

+ (void)drawEclipse:(CGContextRef)c rect:(CGRect)rect strokeColor:(UIColor *)strokeColor strokeWidth:(CGFloat)strokeWidth{
    CGContextSaveGState(c);
    CGContextSetStrokeColorWithColor(c, [strokeColor CGColor]);
    CGContextSetLineWidth(c, strokeWidth);
    CGContextAddEllipseInRect(c, rect);
    CGContextStrokePath(c);
    CGContextRestoreGState(c);
}

+ (void)drawLine:(CGContextRef)c startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint strokeColor:(UIColor *)strokeColor lineWidth:(CGFloat)lineWidth{
    CGContextSaveGState(c);
    CGContextSetStrokeColorWithColor(c, [strokeColor CGColor]);
    CGContextSetLineWidth(c, lineWidth);
    CGContextMoveToPoint(c, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(c, endPoint.x, endPoint.y);
    CGContextStrokePath(c);
    CGContextRestoreGState(c);

}

@end
