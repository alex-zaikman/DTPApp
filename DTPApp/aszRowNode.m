//
//  aszRowNode.m
//  DTPApp
//
//  Created by alex zaikman on 7/9/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszRowNode.h"


@interface aszRowNode()

@property (nonatomic,strong) aszRowNode *parent;
@property (nonatomic,strong) NSMutableArray *children;
@property (nonatomic,assign) BOOL expanded;




@end



@implementation aszRowNode

#pragma mark constructors

-(id)init{
    
    self=[super init];
    if(self)
    {
        _parent=nil;
        _children = [[NSMutableArray alloc]init];
        _expanded = NO;
        _value = @"N/A";
    }
return self;

}

-(id)initWithValue:(NSString*)value{
    
    self=[super init];
    if(self)
    {
        _parent=nil;
        _children = [[NSMutableArray alloc]init];
        _expanded = NO;
        _value = value;
    }
    return self;
}


#pragma mark suplement api

-(BOOL)isRoot{
    return (self.parent==nil);
}

-(int)count{
    
    int ret=1;

    for(aszRowNode *chiled in self.children){
        
        ret+=[chiled count];
        
    }

    return ret;
}

-(NSArray*)getChildren{
    return [self.children copy];
}



-(NSString*)getAlignedValue{
    
    NSMutableString* ret= [[NSMutableString alloc]initWithCapacity:([self level] + self.value.length)];
    
    for (int i = 1; i<=[self level]; i++) {
        [ret appendString:@" "];
    }
    
    [ret appendString:self.value];
    
    return  ret;
    
}


#pragma mark work api

-(aszRowNode*)getParent{
    return self.parent;
}

-(NSArray*) getVisibleSubTree{
    
    
    if(!self.expanded){
        return @[self];
    }
    else{
       NSMutableArray* ret =  [[NSMutableArray alloc]init];
        
        [ret addObject:self];
        
        for(aszRowNode *chiled in self.children){
          [ret addObjectsFromArray:[chiled getVisibleSubTree]];
        }
        
        return [ret copy];
    }
    
}

-(int)level{
    
    if([self isRoot])
        return 0;
    else{
        return [self.parent level]+1;
    }
    
}

-(void)toggle{
    self.expanded = !self.expanded;
}

-(int)visibleCount{
    
    int ret=1;
    
    if(self.expanded)
        for(aszRowNode *chiled in self.children){
            ret+=[chiled visibleCount];
        }
    
    return ret;
    
}

-(BOOL)isLeaf{
    return (self.children==nil || [self.children count]==0);
}

-(void)addChild:(aszRowNode*)chiled{
    
    chiled.parent=self;
    [self.children addObject:chiled];
    
}

-(void)toggleAllTo:(BOOL)toggleState{
    self.expanded=toggleState;
    
    for(aszRowNode *chiled in self.children){
        [chiled toggleAllTo:toggleState];
    }
    
}

-(BOOL)isExpandded{
    
    return self.expanded;
}

@end
