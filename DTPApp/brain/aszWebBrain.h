//
//  aszWebBrain.h
//  DTPApp
//
//  Created by alex zaikman on 7/7/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "aszUtils.h"
#import "CDVViewController.h"

@interface aszWebBrain : NSObject <UIWebViewDelegate>




@property (atomic,strong) CDVViewController *cdvbrain;

+(aszWebBrain*)the;

-(NSString*)callJs:(NSString*)name withParams:(NSArray*)params call:(NSString *)callme;

@end
