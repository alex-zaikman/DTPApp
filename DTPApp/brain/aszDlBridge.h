//
//  aszDlBridge.h
//  DTPApp
//
//  Created by alex zaikman on 8/4/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#ifndef aszDlData_ghrtdghrty45y6465yteh456h5rtbh46b4b4b544b64h46uh453gyh46htehj4g3
#define aszDlData_ghrtdghrty45y6465yteh456h5rtbh46b4b4b544b64h46uh453gyh46htehj4g3

#import <Foundation/Foundation.h>
#import "CDVViewController.h"
#import "aszDlCallbackDelegate.h"


@interface aszDlBridge : CDVViewController  


//@property (nonatomic,assign) int indexCid;

-(id)initCallOnLoadded:(void (^)(void))callme ;

-(id)initInit:(NSString*)initdata andPlay:(NSString*)playdata dlCallbackDelegate:(id<aszDlCallbackDelegate>)dldelegate;

-(id)initInit:(NSString*)initdata OnLoadded:(void (^)(void))callme  dlCallbackDelegate:(id<aszDlCallbackDelegate>)dldelegate;

#pragma mark bridge funcs

-(void)setFrame:(CGRect)rect;

-(UIView*) getCDVView;

-(BOOL)didDlLoad;


#pragma mark dl Api

-(void)initPlayer:(NSString*)initData OnSuccess:(void (^)(NSString *))success  OnFaliure:(void (^)(NSString *))faliure;

-(void)playSequence:(NSString*)seqData OnSuccess: (void (^)(NSString *))success  OnFaliure:(void (^)(NSString *))faliure;

@end



#endif
