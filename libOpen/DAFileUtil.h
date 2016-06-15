//
//  DAFileUtil.h
//  AGUIKit
//
//  Created by Tao Yunfei on 5/19/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Singleton.h"


#define DA_FILE_UTIL [DAFileUtil singleton]

@interface DAFileUtil : NSObject

@property (nonatomic, assign) NSInteger cacheSize;

- (void)clearTmpDirectory;
- (void)createTmpDirectory;
- (NSURL *)localURLWithFileName:(NSString *)fileName;
- (NSURL *)localURLWithDownloadURL:(NSURL *)downloadURL;
- (NSURL *)localRandomURLWithExtension:(NSString *)extension;
- (NSString *)applicationDocumentsDirectory;
- (NSString *)fileNameFromDownloadURL:(NSURL *)url;
- (NSString *)fileNameFromLocalURL:(NSURL *)url;
- (BOOL)writeImage:(UIImage *)image toLocalURL:(NSURL *)localURL;
- (BOOL)isExistLocalURL:(NSURL *)localURL;

@end
