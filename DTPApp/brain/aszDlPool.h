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


-(id)initUseInitData:(NSString*)data playWithPlayDataDictionarry:(NSDictionary*)pData dlCallbackDelegate:(id<aszDlCallbackDelegate>)dldelegate;

-(void)playWithDataDictionary:(NSDictionary*)pData;

-(id)getDlForKey:(NSString*)key;

-(uint)getCurrentPoolSize;

-(void)clearPool;

@end
#endif
