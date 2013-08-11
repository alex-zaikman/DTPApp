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

@property (nonatomic,strong) NSMutableDictionary *cache;

@property (nonatomic,strong) NSString *iniData;

//@property (nonatomic,strong) void(^initOnLoadded)(void);
//
//@property (strong,nonatomic) void (^allLoadded)(void);
//@property (strong,nonatomic) void (^callOnallLoadded)(void);
@end


@implementation aszDlPool

-(id)initUseInitData:(NSString*)data playWithPlayDataDictionarry:(NSDictionary*)pData{
    
    self =[super init];
    
    if(self){
        _iniData = data;
        _cache = [NSMutableDictionary dictionary];
        
        __block NSMutableDictionary *tmpCashe = _cache;
        __block NSString *idata=data;
        
        [pData enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            
            [tmpCashe setValue:[[aszDlBridge alloc]initInit:idata andPlay:obj ] forKey:key];
            
        }];
    }
    return self;
}

-(void)playWithDataDictionary:(NSDictionary*)pData{
  

    //clean cashe
    NSArray *casheKyes = [self.cache allKeys];
    
    for(NSString *key in casheKyes){
        if(![pData valueForKey:key]){
            aszDlBridge *tmp = [self.cache objectForKey:key];
            [tmp releaseLock];
            [self.cache removeObjectForKey:key];
          //  tmp=nil;
            
        }
    }
    
    //set cashe
     __block NSMutableDictionary *tmpCashe = self.cache;
     __block NSString *idata=self.iniData;
    [pData enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        if(![tmpCashe objectForKey:key]){
            [tmpCashe setValue:[[aszDlBridge alloc]initInit:idata andPlay:obj ]  forKey:key];
        }
        
    }];

}


-(id)getDlForKey:(NSString*)key{
    
    return [self.cache objectForKey:key];

}

-(uint)getCurrentPoolSize{
    return [self.cache count];
}


-(void)clearPool{
    
    [self.cache enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        [obj viewDidUnload];
        
    }];
    
    [self.cache removeAllObjects];
}


-(void)dealloc{
    
    [self clearPool];
    
}




@end

