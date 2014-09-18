//
//  DSImageFilter.m
//  og
//
//  Created by traintrackcn on 13-8-23.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import "DSImage.h"
#import "DSDeviceUtil.h"
#import "NSObject+Singleton.h"
//#import "DSHostSettingManager.h"
//#import "AGServer.h"


@implementation DSImage

+ (UIImage *)rectangleWithSize:(CGSize)size fillColor:(UIColor *)fillColor{
    CGFloat scale = 1.0;
    if ([DSDeviceUtil isRetina])  scale = 2.0;
    UIGraphicsBeginImageContextWithOptions(size, YES, scale);
	[fillColor setFill];
	CGRect rect = CGRectMake(0, 0,size.width *scale, size.height*scale);
    UIRectFill(rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)circleWithSize:(CGSize)size fillColor:(UIColor *)fillColor{
    CGFloat scale = 1.0;
    if ([DSDeviceUtil isRetina])  scale = 2.0;
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
	[fillColor setFill];
    CGRect rect = CGRectMake(0, 0,size.width , size.height);
    CGContextFillEllipseInRect(ctx, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


+ (NSString *)largeImageUrl:(NSString *)urlStr{
    return [self imageUrl:urlStr sizePrefix:@"large"];
}

+ (NSString *)smallImageUrl:(NSString *)urlStr{
    return [self imageUrl:urlStr sizePrefix:@"small"];
}

+ (BOOL)isImageUrlAvailableFromUrls:(NSArray *)urls{
    if (![urls isKindOfClass:[NSArray class]]) return NO;
    if ([urls count] ==  0) return NO;
    return YES;
}

+ (NSString *)imageUrl:(NSString *)urlStr sizePrefix:(NSString *)sizePrefix{
    //    TLOG(@"urlStr before -> %@", urlStr);
    //https://www.organogold.com/upload/image/1/large_f9efae0e-0497-4c99-ae41-51e778ced6b9.jpg
    
    //    NSString *serverUrl = [DSHostSettingManager selectedServer].httpUrlWithoutExtension;
    NSString *serverUrl = [DSImage singleton].imageHost;
    //TEMPORARY SOLUTION
    if ([urlStr rangeOfString:@"http"].location == NSNotFound) {
        urlStr = [NSString stringWithFormat:@"%@%@", serverUrl,urlStr];
    }
    
    NSMutableArray *arr = [[urlStr componentsSeparatedByString:@"/"] mutableCopy];
    NSInteger lastIndex = arr.count - 1;
    NSString *imageName = [arr objectAtIndex:lastIndex];
    NSArray *arr1 = [imageName componentsSeparatedByString:@"."];
    if ([arr1 count]<1) return urlStr;
    NSString *imageNameWithoutFormat = [arr1 objectAtIndex:0];
    NSString *imageFormat = [arr1 objectAtIndex:1];
    NSArray *arr2 = [imageNameWithoutFormat componentsSeparatedByString:@"_"];
    if (arr2.count <= 1) return urlStr;
    NSString *imageNameWithoutSize = [arr2 objectAtIndex:1];
    NSString *imageNameFinal = [NSString stringWithFormat:@"%@_%@.%@", sizePrefix,imageNameWithoutSize, imageFormat];
    [arr removeLastObject];
    [arr addObject:imageNameFinal];
    return [arr componentsJoinedByString:@"/"];
}

//+ (UIImage *)fillImageNamed:(NSString *)imageName withColor:(UIColor *)color{
//    UIImage *image = [UIImage imageNamed:imageName];
//
//    UIGraphicsBeginImageContext(image.size);
//
//	// draw original image into the context
//	[image drawAtPoint:CGPointZero];
//
//	// get the context for CoreGraphics
//	CGContextRef ctx = UIGraphicsGetCurrentContext();
//
//	// set stroking color and draw circle
//	[color setFill];
//
//	// make circle rect 5 px from border
//	CGRect rect = CGRectMake(0, 0,
//                             image.size.width,
//                             image.size.height);
//	CGContextFillRect(ctx, rect);
//
//	// make image out of bitmap context
//	UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
//
//	// free the context
//	UIGraphicsEndImageContext();
//    return retImage;
//}





+ (UIImage *)imageWithWhiteBackgroundForImage:(UIImage *)image{
    CGFloat scale = image.scale;
    CGFloat w = image.size.width*scale;
    CGFloat h = image.size.height*scale;
    CGSize s = CGSizeMake(w, h);
    
    
    UIGraphicsBeginImageContext(s);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(ctx, kCGBlendModeCopy);
    [image drawInRect:CGRectMake(0, 0, w, h)];
    CGContextSetBlendMode(ctx, kCGBlendModeDifference);
    CGContextSetFillColorWithColor(ctx,[UIColor whiteColor].CGColor);
    CGContextFillRect(ctx, CGRectMake(0, 0, w, h));
    UIImage *negativeImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return negativeImage;
}


+ (UIImage *) image:(UIImage *)image withMaskColor:(UIColor *)color{
    
    
    
    UIImage *formattedImage = [self imageWithWhiteBackgroundForImage:image];
    //    return formattedImage;
    //    TLOG(@"size %f %f", formattedImage.size.width, formattedImage.size.height);
    CGRect rect = {0, 0, formattedImage.size.width/image.scale, formattedImage.size.height/image.scale};
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *targetColorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //    return  [self imageWithWhiteBackgroundForImage:image];
    //    return targetColorImage;
    //    return formattedImage;
    CGImageRef maskRef = [formattedImage CGImage];
    //    int bitsPerComponent                    = 1;
    //    int bitsPerPixel                        = bitsPerComponent * 1 ;
    //    int bytesPerRow                         = (CGImageGetWidth(maskRef) * bitsPerPixel);
    
    
    CGImageRef maskcg = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                          CGImageGetHeight(maskRef),
                                          CGImageGetBitsPerComponent(maskRef),
                                          CGImageGetBitsPerPixel(maskRef),
                                          CGImageGetBytesPerRow(maskRef),
                                          CGImageGetDataProvider(maskRef),
                                          NULL, false);
    
    CGImageRef maskedcg = CGImageCreateWithMask([targetColorImage CGImage], maskcg);
    CGImageRelease(maskcg);
    
    
    UIImage *result = [UIImage imageWithCGImage:maskedcg scale:[image scale] orientation:[image imageOrientation]];
    CGImageRelease(maskedcg);
    
    return result;
}


+ (UIImage *) imageWithView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}


#pragma mark - resize image

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
