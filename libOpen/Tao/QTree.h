//
//  Quadtree.h
//  libOpen
//
//  Created by traintrackcn on 13-7-16.
//
//


static int TQTreeMaxLeafs = 10;
static int TQTreeMaxLevels = 6;


#import <Foundation/Foundation.h>

@class QTreeLeaf;

@interface QTree : NSObject


- (id)initWithLevel:(int)level frame:(CGRect)frame;

- (void)appendLeaf:(QTreeLeaf *)leaf;
- (NSArray *)fetch:(CGRect)rect;

- (void)clear;


@property (nonatomic, assign) int level;
@property (nonatomic, assign) CGRect frame;

@end
