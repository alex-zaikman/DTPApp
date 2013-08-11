//
//  aszDlPool.m
//  DTPApp
//
//  Created by alex zaikman on 8/5/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszDlPool.h"
#import "aszUtils.h"


@interface aszDlPool()

@property (nonatomic,strong) NSArray *cache;
@property (nonatomic,strong) NSMutableDictionary *cacheGuide;

@property (nonatomic,readonly,assign) uint poolSize;
@property (nonatomic,strong) NSString *initData;

@property (nonatomic,strong) void(^initOnLoadded)(void);

@property (strong,nonatomic) void (^allLoadded)(void);
@property (strong,nonatomic) void (^callOnallLoadded)(void);
@end


@implementation aszDlPool


-(id)initWithPoolSize:(uint)size useInitData:(NSString*)data onLoad: (void (^)(void))callme{
    self = [super init];
    if(self){
        
        
      
        _poolSize=size;
        _initData =data;
        _cacheGuide = [[NSMutableDictionary alloc]init];
        
        
        _callOnallLoadded = callme;
        
       __block aszDlPool *this=self;
        
        _allLoadded = ^{
        
            static int count = 0;
            count ++;
            
            if(count == this.poolSize){
               this.callOnallLoadded();
            }
            
            
        };
        
        NSMutableArray *tmp = [[NSMutableArray alloc]init];
        
        for(uint i=0 ;i<_poolSize ;i++)
        {
            aszDlBridge *bridge = [[aszDlBridge alloc]initInit:_initData OnLoadded:_allLoadded];
            
            
            [tmp addObject:bridge ];
            [_cacheGuide setValue:@(i) forKey:[aszUtils intToString:(-1-i)]];
        }
        
        _cache = [[NSArray alloc]initWithArray:tmp];
        
    }
    return self;
}



-(void) playWithData:(NSString*)data forKey:(NSString*)newKey swapKey:(NSString*)oldKey{
    

    NSString *sindex = [self.cacheGuide valueForKey:oldKey];
    
    [self.cacheGuide removeObjectForKey:oldKey];
    [self.cacheGuide setObject:sindex forKey:newKey];
    
    aszDlBridge *cdv = self.cache[sindex.intValue];
    
    [cdv playSequence:data OnSuccess:^(NSString *msg) {
        //aok
    } OnFaliure:^(NSString *err) {
        @throw [NSException exceptionWithName:@"FAILED_TO_PLAY" reason:@"faild to play seq" userInfo:nil];
    }];

    
}

-(uint)getPoolSize{
    
    return self.poolSize;
    
}

-(NSArray*)cashedKeysNotInKeys:(NSArray*)newKeys{
    
    NSMutableArray *freeOldCids = [[NSMutableArray alloc]init];
    
    NSArray *oldCids=[self.cacheGuide allKeys];

        //for each old cid not in new cid
    for(int i=0; i<self.poolSize ; i++){
        
        if( ![newKeys containsObject:oldCids[i]])
        {
            //add to return
            [freeOldCids addObject:oldCids[i]];
        }
        
    }
    
    return freeOldCids;
    
}

-(void)playWithDataArray:(NSArray*)pData forKeyArray:(NSArray*)keys{
    
    if(self.poolSize != [keys count]  ||  self.poolSize != [keys count])  @throw [NSException exceptionWithName:@"MISS_SIZED_INPUT" reason:@"input arrays must be pool size" userInfo:@{@"pData:": @([pData count]) , @"cids":@([keys count]), @"poolSize":@(self.poolSize) }];
   
    
    NSArray *freeOldCids = [self cashedKeysNotInKeys:keys];
    
    
    int oldCidIndex = 0;
    
     if([freeOldCids count]==0)return;
    
   
     for(int i=0;i<self.poolSize;i++){
        
        if(! [self.cacheGuide valueForKey:keys[i]]){
            
            //find free spot
            NSString *oldCidToSwap = freeOldCids[oldCidIndex];
            oldCidIndex++;
            
            [self playWithData:pData[i] forKey:keys[i] swapKey:oldCidToSwap];
            
        }else{
            
            //already in cach go on
        }
    }
    
}

//nil if not in cache
-(aszDlBridge*)getDlForKey:(NSString*)key{
    
    NSNumber *index = [self.cacheGuide objectForKey:key];
    
    if(!index)
        return nil;
    else
        return self.cache[index.intValue];
    
}


@end

