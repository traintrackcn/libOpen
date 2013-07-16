//
//  Quadtree.h
//  libOpen
//
//  Created by traintrackcn on 13-7-16.
//
//


static int TQTreeMaxLeafs = 10;
static int TQTreeMaxLevels = 6;


enum {
    QuadrantUnavalible = -1,
    QuadrantNorthEast = 0,          //Quadrant 1
    QuadrantNorthWest = 1,          //Quadrant 2
    QuadrantSouthWest = 2,          //Quadrant 3
    QuadrantSouthEast = 3              //Quadrant 4
};


#import <Foundation/Foundation.h>
#import "QTreeLeaf.h"

@interface QTree : NSObject


- (id)initWithLevel:(int)level frame:(CGRect)frame;

- (void)appendLeaf:(QTreeLeaf *)leaf;
- (NSArray *)fetch:(CGRect)rect;

- (BOOL)hasNodes;
- (QTree *)node:(int)quadrant;

- (void)clear;

+ (void)setTQTreeMaxLeafs:(int)maxLeafs;
+ (void)setTQTreeMaxLevels:(int)maxLevels;


@property (nonatomic, assign) int level;
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, strong)  NSMutableArray *leafs;

@end
