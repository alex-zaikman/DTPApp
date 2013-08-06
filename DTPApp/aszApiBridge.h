//
//  aszWebBridge.h
//  DTPApp
//
//  Created by alex zaikman on 8/4/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//
#ifndef aszWebBridge_ghrtdghrty45y6465yteh456h5rtbh46b4b4b544b64h46uh453gyh46htehj4g3123
#define aszWebBridge_ghrtdghrty45y6465yteh456h5rtbh46b4b4b544b64h46uh453gyh46htehj4g3123

#import <Foundation/Foundation.h>
#import "CDVViewController.h"

@interface aszApiBridge : NSObject


@property (nonatomic,strong) CDVViewController *cdvbrain;

+(aszApiBridge*)the;

-(NSString*)callJs:(NSString*)name withParams:(NSArray*)params OnSucsses:(NSString *)sucsses OnFaliure:(NSString *)faliure;

-(void)setCustomDelegate:(id<UIWebViewDelegate>)delegate;

@end
#endif
