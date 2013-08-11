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



@property (strong,nonatomic) id<aszDlCallbackDelegate> dldelegate;

//@property (strong,nonatomic) void (^allLoadded)(void);
//@property (strong,nonatomic) void (^callOnallLoadded)(void);
@end


@implementation aszDlPool

-(id)initUseInitData:(NSString*)data playWithPlayDataDictionarry:(NSDictionary*)pData dlCallbackDelegate:(id<aszDlCallbackDelegate>)dldelegate{
    
    self =[super init];
    
    if(self){
        _iniData = data;
        _cache = [NSMutableDictionary dictionary];
        _dldelegate=dldelegate;
        
        
        __block NSMutableDictionary *tmpCashe = _cache;
        __block NSString *idata=data;
        __block id<aszDlCallbackDelegate> blockDelegate = dldelegate;
        
        [pData enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            
            [tmpCashe setValue:[[aszDlBridge alloc]initInit:idata andPlay:obj dlCallbackDelegate:blockDelegate ] forKey:key];
            
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
    __block id<aszDlCallbackDelegate> blockDelegate = self.dldelegate;
    [pData enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        if(![tmpCashe objectForKey:key]){
            [tmpCashe setValue:[[aszDlBridge alloc]initInit:idata andPlay:obj dlCallbackDelegate:blockDelegate ]  forKey:key];
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

