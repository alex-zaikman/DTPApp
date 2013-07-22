//
//  aszDls.m
//  DTPApp
//
//  Created by alex zaikman on 7/22/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszDls.h"
#import "aszUtils.h"

@implementation aszDl

@end


@implementation aszDls


-(id) initWithHrefs:(NSArray *)refs forCourseId:(NSString*)cid{
    self = [super init];
    if(self){
    
        _dataArray = [[NSMutableArray alloc]init];
        for(NSString *ref in refs){
            
            aszDl *dl = [[aszDl alloc]init];
            
            //media url
            NSMutableString *mediaUrl=[[NSMutableString alloc]init];
            
            [mediaUrl appendString: @"\"/cms/courses/"];
            
            [mediaUrl appendString: cid];
            
            [mediaUrl appendString: @"\""];
            
            //init data
            NSMutableString *initData=[[NSMutableString alloc]init];
            
            [initData appendString:@"{ width: 1024, height: 600, scale: 1, basePaths: { player:"];
            
            //this.playerPath
            [initData appendString: @"\"http://cto.timetoknow.com/cms/player/dl\""];
            
            
            [initData appendString: @", media:"];
            
            [initData appendString: mediaUrl];
            
            [initData appendString: @"}, complay:true, localeName:\"en_US\",   apiVersion: '1.0',  loId: 'inst_s', isLoggingEnabled: true, userInfo : { role: '"];
            
            [initData appendString:@"student"];//[initData appendString:role];
            
            [initData appendString:  @"' }   }"];
            

            
            dl.iniData = initData ;
            
            ///////////////////////////////////////
            
            NSString  *jsonUrl = [@"http://cto.timetoknow.com"  stringByAppendingString:ref ];

            NSURLRequest *reqPlayData = [aszUtils requestWithUrl:jsonUrl usingMethod:@"GET" withUrlParams:nil andBodyData:nil];
            
            NSURLResponse *response = nil;
            NSError *error = nil;
           
            NSData *responseData = [NSURLConnection sendSynchronousRequest:reqPlayData returningResponse:&response error:&error];
            
            dl.playData = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            
            [_dataArray addObject:dl];

        }
        
        
    }
    return self;
    
}


@end
