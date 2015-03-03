//
//  SKScene+ABUtil.m
//  libOpen
//
//  Created by traintrackcn on 11/2/15.
//
//

#import "SKScene+ABUtil.h"
#import "DSDeviceUtil.h"

@implementation SKScene (ABUtil)

+ (id)unarchiveFromClass:(Class)cls{
    /* Retrieve scene file path from the application bundle */
//    Class cls = NSClassFromString(className);
    NSString *clsName = NSStringFromClass(cls);
//    NSString *folder = @"Scenes";
//    NSString *path = [NSString stringWithFormat:@"%@/%@",folder, className];
    NSString *fileName = clsName;
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"sks"];
    
//    TLOG(@"cls -> %@ fileName -> %@", cls, fileName);
    TLOG(@"fileName -> %@ nodePath -> %@", fileName, nodePath);
    
    if (!nodePath) {
        CGSize size = [DSDeviceUtil bounds].size;
//        TLOG(@"cls -> %@", cls);
        return [[cls alloc] initWithSize:size];
    }
    
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
//    TLOG(@"cls -> %@ %@", cls, clsName);
    [arch setClass:cls forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end
