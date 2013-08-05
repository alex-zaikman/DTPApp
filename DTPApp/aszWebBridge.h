//
//  aszWebBridge.h
//  DTPApp
//
//  Created by alex zaikman on 8/4/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDVViewController.h"

@interface aszWebBridge : NSObject


@property (nonatomic,strong) CDVViewController *cdvbrain;

+(aszWebBridge*)the;

-(NSString*)callJs:(NSString*)name withParams:(NSArray*)params OnSucsses:(NSString *)sucsses OnFaliure:(NSString *)faliure;

-(void)setCustomDelegate:(id<UIWebViewDelegate>)delegate;

@end
