//
//  aszWebBridge.h
//  DTPApp
//
//  Created by alex zaikman on 8/4/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface aszWebBridge : NSObject

+(aszWebBridge*)the;

-(NSString*)callJs:(NSString*)name withParams:(NSArray*)params OnSucsses:(NSString *)sucsses OnFaliure:(NSString *)faliure;

-(void)setCustomDelegate:(id<UIWebViewDelegate>)delegate;

@end
