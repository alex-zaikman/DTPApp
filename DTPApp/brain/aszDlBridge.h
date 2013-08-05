//
//  aszDlBridge.h
//  DTPApp
//
//  Created by alex zaikman on 8/4/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDVViewController.h"



@interface aszDlData : NSObject

-(id)initWithJSONDataString:(NSString*)json;

-(NSString*)getDataAsJSONString;

@end



@interface aszDlBridge : CDVViewController  

-(id)initCallOnLoadded:(void (^)(void))callme ;

-(void)setFrame:(CGRect)rect;

-(UIView*) getCDVView;

-(BOOL)didDlLoad;

#pragma mark dl api

-(void) initPlayer:(aszDlData*)initData OnSuccess:(void (^)(NSString *))success  OnFaliure:(void (^)(NSString *))faliure;

-(void) playSequence:(aszDlData*)seqData OnSuccess: (void (^)(NSString *))success  OnFaliure:(void (^)(NSString *))faliure;

@end
