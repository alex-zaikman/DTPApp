//
//  aszDlPool.h
//  DTPApp
//
//  Created by alex zaikman on 8/5/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#ifndef aszDlPool_4353454325234gterververv345gfv345g535
#define aszDlPool_4353454325234gterververv345gfv345g535

#import <Foundation/Foundation.h>
#import "aszDlBridge.h"


@interface aszDlPool : NSObject

#pragma mark init funcs

-(id)initWithPoolSize:(uint)size useInitData:(NSString*)data  onLoad:(void (^)(void))callme;


#pragma mark play funcs

//1. arrays must be equal to pool size 
-(void)playWithDataArray:(NSArray*)pData forKeyArray:(NSArray*)keys;

//if no old key in pool will do nothing
-(void) playWithData:(NSString*)data forKey:(NSString*)newKey swapKey:(NSString*)oldKid;

#pragma mark funcs

-(NSArray*)cashedKeysNotInKeys:(NSArray*)newKeys;

//nil if not in pool
-(aszDlBridge*)getDlForKey:(NSString*)key;

-(uint)getPoolSize;

@end
#endif
