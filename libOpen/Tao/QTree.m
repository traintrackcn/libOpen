//
//  Quadtree.m
//  libOpen
//
//  Created by traintrackcn on 13-7-16.
//
//

#import "QTree.h"
#import "QTreeLeaf.h"


enum {
    QuadrantUnavalible = -1,
    QuadrantNorthEast = 0,          //Quadrant 1
    QuadrantNorthWest = 1,          //Quadrant 2
    QuadrantSouthWest = 2,          //Quadrant 3
    QuadrantSouthEast = 3              //Quadrant 4
};

@interface QTree(){
    NSMutableArray *leafs;
    NSArray *nodes;
}

@end

@implementation QTree

- (id)initWithLevel:(int)level frame:(CGRect)frame{
    self = [super init];
    if (self) {
        [self setLevel:level];
        [self setFrame:frame];
        leafs = [NSMutableArray array];
    }
    return self;
}


- (void)subdivide {
    
    if ([self hasNodes]) return;
    
    int subWidth = _frame.size.width/2;
    int subHeight = _frame.size.height/2;
    int x = _frame.origin.x;
    int y = _frame.origin.y;
    int subLevel = _level + 1;
    CGRect frameSE = CGRectMake(x + subWidth, y, subWidth, subHeight);
    CGRect frameSW = CGRectMake(x, y, subWidth, subHeight);
    CGRect frameNW = CGRectMake(x, y + subHeight, subWidth, subHeight);
    CGRect frameNE = CGRectMake(x + subWidth, y + subHeight, subWidth, subHeight);
    
    QTree *nodeSE =  [[QTree alloc] initWithLevel:subLevel frame:frameSE];
    QTree *nodeSW = [[QTree alloc] initWithLevel:subLevel frame:frameSW];
    QTree *nodeNW= [[QTree alloc] initWithLevel:subLevel frame:frameNW];
    QTree *nodeNE = [[QTree alloc] initWithLevel:subLevel frame:frameNE];
    
    nodes = [NSArray arrayWithObjects:
                nodeNE,
                nodeNW,
             nodeSW,
             nodeSE,
             nil];
}




#pragma mark - node methods

- (BOOL)hasNodes{
    if (nodes) return YES;
    return NO;
}

- (QTree *)node:(int)quadrant{
    if (![self hasNodes]) return nil;
    return [nodes objectAtIndex:quadrant];
}

#pragma mark - quadrant methods

- (int)quadrant:(CGRect)targetRect {
    int quadrant = QuadrantUnavalible;
    float verticalMidpoint = _frame.origin.x + (_frame.size.width / 2);
    float horizontalMidpoint = _frame.origin.y + (_frame.size.height / 2);
    
    float targetX = targetRect.origin.x;
    float targetY = targetRect.origin.y;
    float targetW = targetRect.size.width;
    float targetH = targetRect.size.height;
    
    BOOL fitTopQuadrant = (targetY < horizontalMidpoint && targetY + targetH < horizontalMidpoint)?YES:NO;
    BOOL fitBottomQuadrant = (targetY > horizontalMidpoint)?YES:NO;
    BOOL fitLeftQuadrant = (targetX < verticalMidpoint && targetX + targetW < verticalMidpoint)?YES:NO;
    BOOL fitRightQuandrat = (targetX > verticalMidpoint)?YES:NO;

    if (fitLeftQuadrant) {
        if (fitTopQuadrant) {
            quadrant = QuadrantNorthWest;
        }else if (fitBottomQuadrant) {
            quadrant = QuadrantSouthWest;
        }
    }else if (fitRightQuandrat) {
        if (fitTopQuadrant) {
            quadrant = QuadrantNorthEast;
        } else if (fitBottomQuadrant) {
            quadrant = QuadrantSouthEast;
        }
    }
    
    return quadrant;
}

- (BOOL)isQuadrantAvailable:(int)quadrant{
    if (quadrant == QuadrantUnavalible) {
        return NO;
    }
    return YES;
}


#pragma mark - append methods

- (void)appendLeaf:(QTreeLeaf *)leaf{
    [self appendLeafToSubNode:leaf];
    [self rearrangeWhenOverCapacity];
}

- (void)appendLeafToCurrentNode:(QTreeLeaf *)leaf{
    [leafs addObject:leaf];
}

- (void)appendLeafToSubNode:(QTreeLeaf *)leaf{
    if (![self hasNodes]) return;
    
    int quadrant = [self quadrant:[leaf frame]];
    
    if ([self isQuadrantAvailable:quadrant]) {
        QTree *node = [self node:quadrant];
        [node appendLeaf:leaf];
        return;
    }
    
    [self appendLeafToCurrentNode:leaf];
}

- (void)rearrangeWhenOverCapacity{
    if ([leafs count] <= TQTreeMaxLeafs) return;
    if (_level >= TQTreeMaxLevels) return;
    
    [self subdivide];
    
    NSMutableArray *tmpLeafs = [NSMutableArray array];
    
    for (int i=0; i<[leafs count]; i++) {
        QTreeLeaf *leaf = [leafs objectAtIndex:i];
        int quadrant = [self quadrant:[leaf frame]];
        if ([self isQuadrantAvailable:quadrant]) {
            QTree *node = [self node:quadrant];
            [node appendLeaf:leaf];
        }else{
            [tmpLeafs addObject:leaf];
        }
    }
    
    //current node's leafs after subdividing
    leafs = tmpLeafs;
    
}



#pragma mark - fetch

/*
 * Return all objects that could collide with the given object
 */
- (NSArray *)fetch:(CGRect)rect{
    int quadrant = [self quadrant:rect];
    NSMutableArray *results;
    if ([self isQuadrantAvailable:quadrant] && [self hasNodes]) {
        QTree *node = [self node:quadrant];
        NSArray *nodeLeafs = [node fetch:rect];
        [results addObjectsFromArray:nodeLeafs] ;
    }
    
    [results addObjectsFromArray:leafs];
    
    return results;
}


#pragma mark - clear methods

- (void)clear{
    [self clearLeafs];
    [self clearNodes];
}

- (void)clearLeafs{
    leafs = [NSMutableArray array];
}

- (void)clearNodes{
    if (nodes == nil) return;
    for (int i=0; i < [nodes count]; i++) {
        QTree *node = [nodes objectAtIndex:i];
        [node clear];
    }
    nodes = nil;
}


@end
