//
//  aszRowNode.h
//  DTPApp
//
//  Created by alex zaikman on 7/9/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface aszRowNode : NSObject

@property (nonatomic,strong) NSString *value;


-(id)initWithValue:(NSString*)value;
-(id)init;

-(int)count;
-(BOOL)isLeaf;
-(BOOL)isRoot;
-(void)addChild:(aszRowNode*)chiled;
-(NSArray*)getChildren;
-(int)level;
-(void)toggle;
-(NSArray*) getVisibleSubTree;
-(void)toggleAllTo:(BOOL)toggleState;
-(NSString*)getAlignedValue;
-(int)visibleCount;
-(BOOL)isExpandded;
-(aszRowNode*)getParent;

@end
