//
//  aszWebBrain.h
//  DTPApp
//
//  Created by alex zaikman on 7/7/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "aszUtils.h"

@interface aszWebBrain : NSObject 

+(aszWebBrain*)the;

-(void)exec:(NSString*)jsFunction withParams:(NSArray*)params onSuccessCall:(void (^)(NSString *)) success onFailureCall:(void (^)(NSString*)) faliure;

@end
