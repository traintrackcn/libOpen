//
//  DSImageFilter.h
//  og
//
//  Created by traintrackcn on 13-8-23.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSImage : NSObject

+ (UIImage *) imageWithView:(UIView *)view;

//+ (UIImage *)ipMaskedImageNamed:(NSString *)name color:(UIColor *)color;
+ (UIImage *)image:(UIImage *)image withMaskColor:(UIColor *)color;
//+ (UIImage *)fillImageNamed:(NSString *)imageName withColor:(UIColor *)color;
+ (UIImage *)rectangleWithSize:(CGSize)size fillColor:(UIColor *)fillColor;
+ (UIImage *)circleWithSize:(CGSize)size fillColor:(UIColor *)fillColor;

+ (NSString *)largeImageUrl:(NSString *)urlStr;
+ (NSString *)smallImageUrl:(NSString *)urlStr;

+ (BOOL)isImageUrlAvailableFromUrls:(NSArray *)urls;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;


+ (NSString *)setImageHost:(NSString *)imageHost;

@property (nonatomic, strong) NSString *imageHost;

@end
